#=====================================================================
# SQL-Ledger ERP
# Copyright (C) 2006
#
# Author: DWS Systems Inc.
# Web: http://www.sql-ledger.com
#
#======================================================================
#
# Overpayment function
# used in AR, AP, IS, IR, OE, CP
#
#======================================================================

package OP;

$userspath = "users";
# to enable debugging rename file carp_debug.inc.bak to carp_debug.inc and enable the following line
if (-f "$userspath/carp_debug.inc") {
# eval { require "$userspath/carp_debug.inc"; };
}

sub overpayment {
 my ($self, $myconfig, $form, $dbh, $amount, $ml) = @_;

 my $fxamount = 0;

 # bp 2014/11 store the document precision as $form->{fxprecision}
 # and ensure that $form->{precision} is our home currency precision
 # no problem if both are the same but we need to know which on is our default precision
 $form->{fxprecision} = $form->{precision};

 my $dbh = $form->dbconnect($myconfig);
 %res = $form->get_defaults( $dbh, \@{ ['precision'] } );
 $form->{precision} = $res{precision};

#carp("amount: $amount - curr: $form->{currency} - def-curr: $form->{defaultcurrency} exrate: $form->{exchangerate} \n");

 # bp 2014/121 round with the correct precision
 if ($form->{currency} ne $form->{defaultcurrency} ) {
 $fxamount = $form->round_amount($amount , $form->{fxprecision} );
 $amount = $form->round_amount($amount * $form->{exchangerate}, $form->{precision});
 } else {
 $amount = $form->round_amount($amount, $form->{precision} );
 }

 # bp 2014/12 get the paymentmethod_id
 my ( $null, $paymentmethod_id ) = split /--/, $form->{paymentmethod};
 $paymentmethod_id *= 1;

 my ($paymentaccno) = split /--/, $form->{"$form->{ARAP}_paid"};

 my ($null, $department_id) = split /--/, $form->{department};
 $department_id *= 1;

 my $action = 'posted';

 my $approved = ($form->{pending}) ? '0' : '1';
 my $batchid ||= $form->{batchid};

 if (!$approved) {
 $action = 'saved';
 }

 my $uid = localtime;
 $uid .= $$;

 # add AR/AP header transaction with a payment
 $query = qq|INSERT INTO $form->{arap} (invnumber, employee_id, approved)
 VALUES ('$uid', (SELECT id FROM employee WHERE login ='$form->{login}' ), '$approved')|;
 $dbh->do($query) || $form->dberror($query);

 $query = qq|SELECT id FROM $form->{arap}
 WHERE invnumber = '$uid'|;
 ($uid) = $dbh->selectrow_array($query);

 my $voucherid = 'NULL';

 if ($form->{batch}) {
 $form->{vouchernumber} = $form->update_defaults($myconfig, 'vouchernumber', $dbh) unless $form->{vouchernumber};

 if (!($voucherid = $form->{voucherid})) {
 $query = qq|SELECT nextval('id')|;
 ($voucherid) = $dbh->selectrow_array($query);
 }
 }

 my $invnumber = $form->{invnumber};

 # bp 2014/12 order number with 4-digit year will only be created if the transdate is available for the 'update_defaults' routine
 $form->{transdate} = $form->{datepaid};
 $invnumber = $form->update_defaults($myconfig, ($form->{arap} eq 'ar') ? "sinumber" : "vinumber", $dbh) unless $invnumber;

 # bp 2014/12 amount in home currency is $amount, added fields from $paymentmethod_id
 $query = qq|UPDATE $form->{arap} set
 invnumber = |.$dbh->quote($invnumber).qq|,
 $form->{vc}_id = $form->{"$form->{vc}_id"},
 transdate = '$form->{datepaid}',
 datepaid = '$form->{datepaid}',
 duedate = '$form->{datepaid}',
 netamount = 0,
 amount = 0,
 paid = $amount,
 curr = '$form->{currency}',
 exchangerate = $form->{exchangerate},
 department_id = $department_id,
 paymentmethod_id = $paymentmethod_id,
 dcn = '',
 description = '',
 ponumber = '',
 notes = '',
 ordnumber = '',
 bank_id = (SELECT id FROM chart WHERE accno = '$paymentaccno')
 WHERE id = $uid|;
 $dbh->do($query) || $form->dberror($query);

 # add AR/AP
 my ($accno) = split /--/, $form->{$form->{ARAP}};

 # bp 2014/12 amount in home currency is $amount
 $query = qq|INSERT INTO acc_trans (trans_id, chart_id, transdate, amount, approved, vr_id)
 VALUES ($uid, (SELECT id FROM chart WHERE accno = '$accno'),
 '$form->{datepaid}', $amount * $ml, '$approved', $voucherid)|;
 $dbh->do($query) || $form->dberror($query);

 # add payment
 # bp 2014/12 one record for the total amount in home currency,add id for link to payment record
 $query = qq|INSERT INTO acc_trans (trans_id, chart_id, transdate, amount, id, source, memo, approved, vr_id)
 VALUES ($uid, (SELECT id FROM chart
 WHERE accno = '$paymentaccno'),
 '$form->{datepaid}', $amount * $ml * -1, 1, |
 .$dbh->quote($form->{source}).qq|, |
 .$dbh->quote($form->{memo}).qq|, '$approved', $voucherid)|;
 $dbh->do($query) || $form->dberror($query);

 # bp 2014/12 get paymentid
 # paymentid
 $query = qq|SELECT MAX(id)
 FROM payment
 WHERE trans_id = $uid|;
 ($paymentid) = $dbh->selectrow_array($query);
 $paymentid++;

 # bp 2014/12 store the amount paid in table payment
 $query = qq|INSERT INTO payment (id, trans_id, exchangerate, paymentmethod_id, fxamount)
 VALUES ($paymentid, $uid, $form->{exchangerate}, $paymentmethod_id, $fxamount)|;
 $dbh->do($query) || $form->dberror($query);

 # add voucher
 if ($form->{batch}) {
 $query = qq|INSERT INTO vr (br_id, trans_id, id, vouchernumber)
 VALUES ($batchid, $uid, $voucherid, |
 .$dbh->quote($form->{vouchernumber}).qq|)|;
 $dbh->do($query) || $form->dberror($query);

 # update batch
 $form->update_balance($dbh,
 'br',
 'amount',
 qq|id = $batchid|,
 $fxamount);

 }

 my %audittrail = ( tablename => $form->{arap},
 reference => $invnumber,
 formname => ($form->{arap} eq 'ar') ? 'deposit' : 'pre-payment',
 action => $action,
 id => $uid );

 $form->audittrail($dbh, "", \%audittrail);

}


1;

