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
            select *
            from invoices_import
            order by 1
        |
      )->xto(
        tr => { class => [ 'listrow0', 'listrow1' ] },
        th => { class => ['listheading'] },
      );
      #$table1->set_group( 'reference', 1 );
      #$table1->calc_totals(    [qw(debit credit)] );
      #$table1->calc_subtotals( [qw(debit credit)] );
      #$table1->modify( td => { align => 'right' }, [qw(debit credit)] );

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

#########
### EOF
#########

