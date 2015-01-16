1;

sub continue { &{ $form->{nextsub} } }

sub list {

    $form->{title} = $locale->text('Ledger Browser');
    $form->header;
    print qq|<table width=100%><tr><th class=listtop>$form->{title} -- $form->{table_name}</th></tr></table>\n|;
    use DBIx::Simple;
    my $dbh = $form->dbconnect( \%myconfig );
    my $db  = DBIx::Simple->connect($dbh);

    $form->{limit_clause}   = '100'    if !$form->{limit_clause};
    $form->{orderby_clause} = '1 DESC' if !$form->{orderby_clause};

    $all_columns_checked = 'checked' if $form->{all_columns};
    $l_subtotal_checked  = 'checked' if $form->{l_subtotal};

    print qq|
<form method=get action=$form->{script}>
<table border=0 cellspacing=0 cellpadding=2>
<tr>
    <th align="right">| . $locale->text('ID') . qq|</th>
    <td><input type=text name=id size=20 value="$form->{id}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('Invoice Number') . qq|</th>
    <td><input type=text name=invnumber size=20 value="$form->{invnumber}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('Order Number') . qq|</th>
    <td><input type=text name=ordnumber size=20 value="$form->{ordnumber}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('Name') . qq|</th>
    <td><input type=text name=name size=20 value="$form->{name}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('Description') . qq|</th>
    <td><input type=text name=description size=20 value="$form->{description}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('From') . qq|</th>
    <td><input type=text name=fromdate class=date size=11 value="$form->{fromdate}" title="$myconfig{dateformat}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('To') . qq|</th>
    <td><input type=text name=todate class=date size=11 value="$form->{todate}" title="$myconfig{dateformat}"></td>
</tr>
<tr>
    <th align="right">| . $locale->text('All Columns') . qq|</th>
    <td><input type=checkbox name=all_columns value=1 $all_columns_checked></td>
</tr>
<tr>
    <th align="right">| . $locale->text('Subtotal') . qq|</th>
    <td><input type=checkbox name=l_subtotal value=1 $l_subtotal_checked></td>
</tr>
</table>
<hr/>
<input name=action class=submit type=submit value="| . $locale->text('List') . qq|">
<a href="$form->{script}?action=list&table_name=$form->{old_table_name}&old_table_name=$form->{table_name}&path=$form->{path}&login=$form->{login}">$form->{old_table_name}</a>
|;
    $form->hide_form(qw(table_name path login));
    print qq|
</form>
|;

    $form->{table_name} = 'acc_trans' if !$form->{table_name};
    my $valid_table_name = $form->{dbs}->query( qq|SELECT 1 FROM information_schema.tables WHERE table_schema='public' AND table_name = ?|, $form->{table_name} )->list;
    $form->error('Invalid table name ...') if !$valid_table_name;

    my $table = $db->query(
        qq|
	SELECT table_name FROM information_schema.tables WHERE table_schema='public' ORDER BY 1|
      )->xto(
        tr => { class => [ 'listrow0', 'listrow1' ] },
        th => { class => ['listheading'] },
      );


    $table->map_cell(
        sub {
            my $datum = shift;
            my $row   = $table->get_current_row();
            my $col   = $table->get_current_col();

            my $varslink;
            if ($datum =~ /^(acc_trans|ar|ap|invoice|inventory|transdate|gl|fifo|)$/){
                $varslink="&fromdate=$form->{fromdate}&todate=$form->{todate}";
            } else {
                $varlink='';
            }

            return
qq|<a href="$form->{script}?action=list&table_name=$datum&old_table_name=$form->{table_name}$varslink&path=$form->{path}&login=$form->{login}&all_columns=$form->{all_columns}&l_subtotal=$form->{l_subtotal}">$datum</a>|;
        },
        'table_name'
    );

    print qq|
<table cellspacing=0 cellpadding=5 border=0>
<tr><td valign=top>
|;
    print $table->output;

    print qq|
</td><td valign=top>
|;

    &print_table;

    print qq|
</tr></table>
|;

    print qq|
</body>
</html>
|;

}

sub print_table {

    my $limit = 100;

    my $where = ' 1 = 1 ';
    my @bind  = ();
    if ( $form->{fromdate} ) {
        $where .= qq| AND transdate >= ?|;
        push @bind, $form->{fromdate};
    }
    if ( $form->{todate} ) {
        $where .= qq| AND transdate <= ?|;
        push @bind, $form->{todate};
    }
    if ( $form->{id} ) {
        $where .= qq| AND id = ?|;
        push @bind, $form->{id};
    }
    if ( $form->{trans_id} ) {
        $where .= qq| AND trans_id = ?|;
        push @bind, $form->{trans_id};
    }
    if ( $form->{parts_id} ) {
        $where .= qq| AND parts_id = ?|;
        push @bind, $form->{parts_id};
    }
    if ( $form->{aid} ) {
        $where .= qq| AND aid = ?|;
        push @bind, $form->{aid};
    }
    if ( $form->{aa_id} ) {
        $where .= qq| AND aa_id = ?|;
        push @bind, $form->{aa_id};
    }
    if ( $form->{project_id} ) {
        $where .= qq| AND project_id = ?|;
        push @bind, $form->{project_id};
    }
    if ( $form->{customer_id} ) {
        $where .= qq| AND customer_id = ?|;
        push @bind, $form->{customer_id};
    }
    if ( $form->{vendor_id} ) {
        $where .= qq| AND vendor_id = ?|;
        push @bind, $form->{vendor_id};
    }
    if ( $form->{department_id} ) {
        $where .= qq| AND department_id = ?|;
        push @bind, $form->{department_id};
    }
    if ( $form->{invoice_id} ) {
        $where .= qq| AND invoice_id = ?|;
        push @bind, $form->{invoice_id};
    }
    if ( $form->{chart_id} ) {
        $where .= qq| AND chart_id = ?|;
        push @bind, $form->{chart_id};
    }
    if ( $form->{invnumber} ) {
        $name = lc $form->like( $form->{invnumber} );
        $where .= qq| AND LOWER(invnumber) like ?|;
        push @bind, $name;
    }
    if ( $form->{ordnumber} ) {
        $name = lc $form->like( $form->{ordnumber} );
        $where .= qq| AND LOWER(ordnumber) like ?|;
        push @bind, $name;
    }
    if ( $form->{name} ) {
        $name = lc $form->like( $form->{name} );
        $where .= qq| AND LOWER(name) like ?|;
        push @bind, $name;
    }
    if ( $form->{description} ) {
        $name = lc $form->like( $form->{description} );
        $where .= qq| AND LOWER(description) like ?|;
        push @bind, $name;
    }

    my @columns = $form->{dbs}->query(
        qq|
        SELECT column_name FROM information_schema.columns WHERE table_name = ?|, $form->{table_name}
    )->flat;

    $form->{sort} = '1' if !$form->{sort};

    my $query;
    my @links;
    my @total_columns = qw(amount netamount paid creditlimit qty cost cogs allocated sellprice fxsellprice discount);
    if ( $form->{table_name} eq 'ar' or $form->{table_name} eq 'ap' ) {
        if ( $form->{table_name} eq 'ar' ) {
            @columns = qw(invnumber transdate customer_id description amount netamount paid) if !$form->{all_columns};
        }
        elsif ( $form->{table_name} eq 'ap' ) {
            @columns = qw(invnumber transdate vendor_id description amount netamount paid) if !$form->{all_columns};
        }
        push @links, { tbl => 'invoice',    pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'inventory',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'acc_trans',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'fifo',       pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'dpt_trans',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'oe',         pk => 'id', fk => 'aa_id' };
        push @links, { tbl => 'invoicetax', pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'audittrail', pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'status',     pk => 'id', fk => 'trans_id' };
    }
    elsif ( $form->{table_name} eq 'oe' ) {
        @columns = qw(id ordnumber transdate vendor_id customer_id amount netamount aa_id) if !$form->{all_columns};
        push @links, { tbl => 'ar',         pk => 'aa_id', fk => 'id' };
        push @links, { tbl => 'orderitems', pk => 'id',    fk => 'trans_id' };
        push @links, { tbl => 'inventory',  pk => 'id',    fk => 'trans_id' };
        push @links, { tbl => 'audittrail', pk => 'id',    fk => 'trans_id' };
    }
    elsif ( $form->{table_name} eq 'trf' ) {
        @columns = qw(id transdate trfnumber description department_id) if !$form->{all_columns};
        push @links, { tbl => 'inventory',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'audittrail', pk => 'id', fk => 'trans_id' };
    }
    elsif ( $form->{table_name} eq 'gl' ) {
        @columns = qw(id reference description transdate department_id) if !$form->{all_columns};
        push @links, { tbl => 'acc_trans',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'dpt_trans',  pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'audittrail', pk => 'id', fk => 'trans_id' };
    }
    elsif ( $form->{table_name} eq 'customer' or $form->{table_name} eq 'vendor' ) {
        push @links, { tbl => 'address', pk => 'id', fk => 'trans_id' };
        push @links, { tbl => 'bank',    pk => 'id', fk => 'id' };
        push @links, { tbl => 'contact', pk => 'id', fk => 'trans_id' };
        if ( $form->{table_name} eq 'customer' ) {
            @columns = qw(id customernumber name contact email terms taxincluded business_id discount creditlimit) if !$form->{all_columns};
            push @links, { tbl => 'customertax', pk => 'id', fk => 'customer_id' };
        }
        else {
            @columns = qw(id vendornumber name contact email terms taxincluded business_id discount creditlimit) if !$form->{all_columns};
            push @links, { tbl => 'vendortax', pk => 'id', fk => 'vendor_id' };
        }
    }
    elsif ( $form->{table_name} eq 'invoice' ) {
        @columns = qw(id trans_id parts_id description qty allocated sellprice fxsellprice discount) if !$form->{all_columns};
        push @links, { tbl => 'ar',         pk => 'trans_id', fk => 'id' };
        push @links, { tbl => 'ap',         pk => 'trans_id', fk => 'id' };
        push @links, { tbl => 'parts',      pk => 'parts_id', fk => 'id' };
        push @links, { tbl => 'invoicetax', pk => 'id',       fk => 'invoice_id' };
        push @links, { tbl => 'fifo',       pk => 'id',       fk => 'invoice_id' };
    }
    elsif ( $form->{table_name} eq 'chart' ) {
        push @links, { tbl => 'acc_trans',   pk => 'id', fk => 'chart_id' };
        push @links, { tbl => 'bank',        pk => 'id', fk => 'id' };
        push @links, { tbl => 'tax',         pk => 'id', fk => 'chart_id' };
        push @links, { tbl => 'customertax', pk => 'id', fk => 'chart_id' };
        push @links, { tbl => 'vendortax',   pk => 'id', fk => 'chart_id' };
    }
    elsif ( $form->{table_name} eq 'parts' ) {
        @columns = qw(id partnumber description partsgroup_id lastcost sellprice) if !$form->{all_columns};
        push @links, { tbl => 'partscustomer', pk => 'id', fk => 'parts_id' };
        push @links, { tbl => 'partsvendor',   pk => 'id', fk => 'parts_id' };
        push @links, { tbl => 'partstax',      pk => 'id', fk => 'parts_id' };
        push @links, { tbl => 'assembly',      pk => 'id', fk => 'aid' };
    }
    elsif ( $form->{table_name} eq 'project' ) {
        push @links, { tbl => 'jcitems', pk => 'id', fk => 'project_id' };
    }
    elsif ( $form->{table_name} eq 'inventory' ) {
        push @links, { tbl => 'ar',    pk => 'trans_id', fk => 'id' };
        push @links, { tbl => 'ap',    pk => 'trans_id', fk => 'id' };
        push @links, { tbl => 'trf',   pk => 'trans_id', fk => 'id' };
        push @links, { tbl => 'parts', pk => 'parts_id', fk => 'id' };
        @columns = qw(id warehouse_id parts_id trans_id qty cost shippingdate department_id description invoice_id cogs) if !$form->{all_columns};
    }
    elsif ( $form->{table_name} eq 'acc_trans' ) {
        @columns = qw(trans_id chart_id amount source id entry_id) if !$form->{all_columns};
        push @links, { tbl => 'chart', pk => 'chart_id', fk => 'id' };
    }
    elsif ( $form->{table_name} eq 'audittrail' ) {
        push @links, { tbl => 'employee', pk => 'employee_id', fk => 'id' };
    }
    elsif ( $form->{table_name} eq 'recurring' ) {
        push @links, { tbl => 'recurringemail', pk => 'id', fk => 'id' };
        push @links, { tbl => 'recurringprint', pk => 'id', fk => 'id' };
    }
    $query = qq|SELECT * FROM $form->{table_name} WHERE $where ORDER BY 1 LIMIT $limit|;

    my @report_columns = @columns;
    my @allrows = $form->{dbs}->query( $query, @bind )->hashes; # or die( $form->{dbs}->error );
    my ( %tabledata, %totals, %subtotals );

    my $url = "$form->{script}?oldsort=$sort&sortorder=$sortorder";
    for (qw(name description invnumber ordnumber)) { $form->{$_} = $form->escape( $form->{$_} ) }
    for (
        qw(table_name fromdate todate trans_id id trans_id parts_id aid aa_id project_id customer_id vendor_id department_id invoice_id chart_id invnumber ordnumber name description action nextsub sortorder l_subtotal login path all_columns)
      )
    {
        $url .= "&$_=$form->{$_}";
    }
    for (@report_columns) { $url .= qq|&l_$_=$form->{"l_$_"}| if $form->{"l_$_"} }
    for (@search_columns) { $url .= qq|&$_=$form->{$_}|       if $form->{$_} }
    for (@report_columns) { $tabledata{$_} = qq|<th><a class="listheading" href="$url&sort=$_">| . ucfirst $_ . qq|</a></th>\n| }

    print qq|
        <table cellpadding="3" cellspacing="2">
        <tr class="listheading">
|;
    for (@links)          { print qq|<th>&nbsp;</th>| }
    for (@report_columns) { print $tabledata{$_} }

    print qq|
        </tr>
|;

    my $groupvalue;
    my $i = 0;
    my $link;
    for $row (@allrows) {
        $groupvalue = $row->{ $form->{sort} } if !$groupvalue;
        if ( $form->{l_subtotal} and $row->{ $form->{sort} } ne $groupvalue ) {
            for (@report_columns) { $tabledata{$_} = qq|<td>&nbsp;</td>| }
            for (@total_columns) { $tabledata{$_} = qq|<th align="right">| . $form->format_amount( \%myconfig, $subtotals{$_}, 2 ) . qq|</th>| }

            print qq|<tr class="listsubtotal">|;
            for (@links)          { print qq|<td>&nbsp;</td>| }
            for (@report_columns) { print $tabledata{$_} }
            print qq|</tr>\n|;
            $groupvalue = $row->{$sort};
            for (@total_columns) { $subtotals{$_} = 0 }
        }
        for (@report_columns) { $tabledata{$_} = qq|<td>$row->{$_}</td>| }

        for (@total_columns) { $tabledata{$_} = qq|<td align="right">| . $form->format_amount( \%myconfig, $row->{$_}, 2 ) . qq|</td>| }
        for (@total_columns) { $totals{$_}    += $row->{$_} }
        for (@total_columns) { $subtotals{$_} += $row->{$_} }

        print qq|<tr class="listrow$i">|;
        for (@links) {
            $link = "$form->{script}?action=list&table_name=$_->{tbl}&$_->{fk}=$row->{$_->{pk}}&path=$form->{path}&login=$form->{login}";
            print qq|<td><a href=$link>$_->{tbl}</a></td>|;
        }
        for (@report_columns) { print $tabledata{$_} }
        print qq|</tr>\n|;
        $i += 1;
        $i %= 2;
    }

    for (@report_columns) { $tabledata{$_} = qq|<td>&nbsp;</td>| }
    for (@total_columns) { $tabledata{$_} = qq|<th align="right">| . $form->format_amount( \%myconfig, $subtotals{$_}, 2 ) . qq|</th>| }

    if ( $form->{l_subtotal} ) {
        print qq|<tr class="listsubtotal">|;
        for (@links)          { print qq|<td>&nbsp;</td>| }
        for (@report_columns) { print $tabledata{$_} }
        print qq|</tr>\n|;
    }

    for (@total_columns) { $tabledata{$_} = qq|<th align="right">| . $form->format_amount( \%myconfig, $totals{$_}, 2 ) . qq|</th>| }
    print qq|<tr class="listtotal">|;
    for (@links)          { print qq|<td>&nbsp;</td>| }
    for (@report_columns) { print $tabledata{$_} }
    print qq|</tr>
</table>
|;

}

