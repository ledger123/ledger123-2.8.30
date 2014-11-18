#!/usr/bin/perl

use Data::Dumper;
use CGI::FormBuilder;

1;

sub continue { &{ $form->{nextsub} } }

#--------------------------------------------------------------------------------
sub search_invoices {

    my @departments = $form->{dbs}->query('select id, description from department order by 2')->arrays;
    my @form1flds   = qw(department_id);

    my $form1 = CGI::FormBuilder->new(
        method     => 'post',
        table      => 1,
        fields     => \@form1flds,
        required   => [qw()],
        options    => { department_id => \@departments },
        messages   => { form_required_text => '', },
        labels     => { department_id => $locale->text('Department'), },
        selectnum  => 2,
        submit     => [qw(Continue)],
        params     => $form,
        stylesheet => 1,
        template   => {
            type     => 'TT2',
            template => 'search.tmpl',
            variable => 'form1',
        },
        keepextras => [qw(id title action path login callback)],
    );
    $form->header;
    print $form1->render;
    print qq|
    </table>
  </tr>
</table>
<hr size=3 noshade />
<input type=hidden name=nextsub value="process_invoices" >
<input type=submit class=submit name=action value="Continue" >
</form>
<br/>
<br/>
|;

    $form->info( $locale->text('Import preview ...') );

    my $table1 = $form->{dbs}->query(
        qq|
            SELECT i.filetype, i.customer_id, c.name, i.transdate, i.duedate,
                    i.currency, i.salesperson, i.partnumber, p.description part_description, i.description, i.qty, i.sellprice, i.qty*i.sellprice amount
            FROM invoices_import i
            LEFT JOIN customer c ON (c.id = i.customer_id)
            LEFT JOIN parts p ON (p.partnumber = i.partnumber)
            ORDER BY i.customer_id, i.filetype, i.partnumber
        |
      )->xto(
        tr => { class => [ 'listrow0', 'listrow1' ] },
        th => { class => ['listheading'] },
      );
      $table1->set_group( 'customer_id', 1 );
      $table1->calc_totals(    [qw(amount)] );
      $table1->calc_subtotals( [qw(amount)] );
      $table1->modify( td => { align => 'right' }, [qw(qty sellprice amount)] );

    print $table1->output;

    print qq|
</body>
</html>
|;

}

#--------------------------------------------------------------------------------
sub process_invoices {

    use SL::IS;
    my $newform = new Form;

    # TODO: Remove hard coded values
    $newform->{type}            = 'invoice';
    $newform->{vc}              = 'customer';
    $newform->{customer}        = "maverick solutions--10071";
    $newform->{oldcustomer}     = $newform->{customer};
    $newform->{customer_id}     = 10071;
    $newform->{currency}        = 'USD';
    $newform->{defaultcurrency} = 'USD';
    $newform->{employee}        = qq|$form->{"employee_$i"}--$form->{"employee_id_$i"}|;
    $newform->{transdate}       = $form->current_date(\%myconfig);
    $newform->{description}     = 'auto night posting';
    $newform->{AR}              = '1200';
    $newform->{partnumber_1}    = '001';
    $newform->{id_1}            = $form->{dbs}->query(qq|select id from parts where partnumber='001'|)->list;
    $newform->{description_1}   = 'Room rental';
    $newform->{qty_1}           = 1;
    $newform->{sellprice_1}     = 123;
    $newform->{rowcount}        = 2;

    @customertax = $form->{dbs}->query(qq|SELECT accno FROM chart WHERE id IN (SELECT chart_id FROM customertax WHERE customer_id = ?)|, $row->{customer_id})->hashes;
    @partstax = $form->{dbs}->query(qq|
        SELECT accno FROM chart WHERE id IN 
        (SELECT chart_id FROM partstax WHERE parts_id = (SELECT id FROM parts WHERE partnumber = '101' limit 1))
    |)->hashes;
    @tax = $form->{dbs}->query(qq|SELECT c.accno, t.rate FROM tax t JOIN chart c ON (c.id = t.chart_id) WHERE validto >= ? OR validto IS NULL|, $systemdate)->hashes;

    for (@customertax){ $newform->{taxaccounts} .= "$_->{accno} " }
    for (@partstax){ $newform->{taxaccounts_1} .= "$_->{accno} " }
    for (@tax) { $newform->{"$_->{accno}_rate"} = $_->{rate} }

    if ( IS->post_invoice( \%myconfig, \%$newform ) ) {
        $form->info(" $row->{customernumber}, $row->{name}, $newform->{invnumber}");
        $form->info( " ... " . $locale->text('ok') . "\n" );
    }
    else {
        $form->error( $locale->text('Posting failed!') );
    }

    $form->redirect( $locale->text('Processed!') );
}


#--------------------------------------------------------------------------------
sub ask_delete {

  $form->header;

  print qq|
<body>

<form method=post action=$form->{script}>
|;

  $form->{nextsub} = "do_delete";
  $form->hide_form;

  print qq|
<h2 class=confirm>|.$locale->text('Confirm!').qq|</h2>

<h4>|.$locale->text('Are you sure you want to delete Invoice staging table?').qq|
</h4>

<p>
<input name=action class=submit type=submit value="|.$locale->text('Yes').qq|">
</form>
|;


}



sub yes {
    $form->{dbs}->query("delete from invoices_import");
    $form->{dbs}->commit;
    $form->info('Staging table purged!');
}


#########
### EOF
#########

