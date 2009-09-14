
require "$form->{path}/lib.pl";
require "$form->{path}/mylib.pl";

1;

#===============================
sub continue { &{$form->{nextsub}} };

#=================================================
#
# Inventory Onhand Qty and Value by Based on FIFO
#
#=================================================
#-------------------------------
sub onhandvalue_search {
   $form->{title} = $locale->text('Inventroy Onhand Value');
   &print_title;

   &start_form;
   &start_table;

   &bld_department;
   &bld_warehouse;
   &bld_partsgroup;

   #&print_date('dateto', 'To');
   &print_text('partnumber', 'Number', 20);
   &print_select('partsgroup', 'Group');
   #&print_select('department', 'Department');
   #&print_select('warehouse', 'Warehouse');
 
   print qq|<tr><th align=right>| . $locale->text('Include in Report') . qq|</th><td>|;

   #&print_radio;
   &print_checkbox('l_no', $locale->text('No.'), '', '');
   #&print_checkbox('l_warehouse', $locale->text('Warehouse'), 'checked', '');
   &print_checkbox('l_partnumber', $locale->text('Number'), 'checked', '');
   &print_checkbox('l_description', $locale->text('Description'), 'checked', '');
   &print_checkbox('l_partsgroup', $locale->text('Group'), 'checked', '');
   &print_checkbox('l_unit', $locale->text('Unit'), 'checked', '<br>');
   &print_checkbox('l_onhand_qty', $locale->text('Onhand Qty'), 'checked', '');
   &print_checkbox('l_components', $locale->text('Components'), '', '');
   &print_checkbox('l_onhand_amt', $locale->text('Onhand Amount'), 'checked', '<br>');
   &print_checkbox('l_subtotal', $locale->text('Subtotal'), '', '');
   &print_checkbox('l_csv', $locale->text('CSV'), '', '');
   &print_checkbox('l_sql', $locale->text('SQL'), '');
   print qq|</td></tr>|;
   &end_table;
   print('<hr size=3 noshade>');
   $form->{nextsub} = 'onhandvalue_list';
   &print_hidden('nextsub');
   &add_button('Continue');
   &end_form;
}

#-------------------------------
sub onhandvalue_list {
  # callback to report list
   my $callback = qq|$form->{script}?action=onhandvalue_list|;
   for (qw(path login sessionid)) { $callback .= "&$_=$form->{$_}" }

   &split_combos('department,warehouse,partsgroup');
   $form->{department_id} *= 1;
   $form->{warehouse_id} *= 1;
   $form->{partsgroup_id} *= 1;
   $partnumber = $form->like(lc $form->{partnumber});
   $description = $form->like(lc $form->{description});
   
   my $where = qq| (1 = 1)|;
   my $subwhere = '';
   $where .= qq| AND (LOWER(p.partnumber) LIKE '$partnumber')| if $form->{partnumber};
   $where .= qq| AND (LOWER(p.description) LIKE '$name')| if $form->{description};
   $where .= qq| AND (p.partsgroup_id = $form->{partsgroup_id})| if $form->{partsgroup};
   #$where .= qq| AND (i.department_id = $form->{department_id})| if $form->{department};
   #$where .= qq| AND (i.warehouse_id = $form->{warehouse_id})| if $form->{warehouse};
   $subwhere .= qq| AND (i.transdate <= '$form->{dateto}')| if $form->{dateto};

   my $componentswhere;
   $componentswhere = qq| AND i.assemblyitem IS FALSE| if !$form->{l_components};

   @columns = qw(id warehouse partnumber description partsgroup unit onhand_qty onhand_amt);
   # if this is first time we are running this report.
   $form->{sort} = 'partnumber' if !$form->{sort};
   $form->{oldsort} = 'none' if !$form->{oldsort};
   $form->{direction} = 'ASC' if !$form->{direction};
   @columns = $form->sort_columns(@columns);

   my %ordinal = (	id => 1,
			warehouse => 2,
			partnumber => 3,
			description => 4,
			partsgroup => 5,
			unit => 6,
			onhand_qty => 7,
			onhand_amt => 8
   );
   my $sort_order = $form->sort_order(\@columns, \%ordinal);

   # No. columns should always come first
   splice @columns, 0, 0, 'no';

   # Select columns selected for report display
   foreach $item (@columns) {
     if ($form->{"l_$item"} eq "Y") {
       push @column_index, $item;

       # add column to href and callback
       $callback .= "&l_$item=Y";
     }
   }
   $callback .= "&l_subtotal=$form->{l_subtotal}&l_components=$form->{l_components}";
   my $href = $callback;
   $form->{callback} = $form->escape($callback,1);

   $query = qq|SELECT 
		p.id,
		p.partnumber,
		p.description,
		pg.partsgroup,
		p.unit,
		SUM(0-(i.qty+i.allocated)) AS onhand_qty,
		SUM((0-(i.qty+i.allocated))*i.sellprice) AS onhand_amt

		FROM parts p
		JOIN invoice i ON (i.parts_id = p.id)
		LEFT JOIN partsgroup pg ON (pg.id = p.partsgroup_id)

		WHERE $where
		AND i.qty < 0
		AND p.inventory_accno_id IS NOT NULL
		$componentswhere

		GROUP BY 1,2,3,4,5
		HAVING SUM(0-(i.qty+i.allocated)) <> 0

		ORDER BY $form->{sort} $form->{direction}
	|;

   # store oldsort/direction information
   $href .= "&direction=$form->{direction}&oldsort=$form->{sort}";

   $column_header{no}   	= rpt_hdr('no', $locale->text('No.'));
   $column_header{partnumber} 	= rpt_hdr('partnumber', $locale->text('Number'), $href);
   $column_header{description} 	= rpt_hdr('description', $locale->text('Description'), $href);
   $column_header{partsgroup}  	= rpt_hdr('partsgroup', $locale->text('Group'), $href);
   $column_header{unit}  	= rpt_hdr('unit', $locale->text('Unit'), $href);
   $column_header{onhand_qty}  	= rpt_hdr('onhand_qty', $locale->text('Onhand Qty'));
   $column_header{onhand_amt}  	= rpt_hdr('onhand_amt', $locale->text('Onhand Amount'));

   $dbh = $form->dbconnect(\%myconfig);
   my %defaults = $form->get_defaults($dbh, \@{['precision', 'company']});
   for (keys %defaults) { $form->{$_} = $defaults{$_} }

   if ($form->{l_csv} eq 'Y'){
	&export_to_csv($dbh, $query, 'parts_onhand');
	exit;
   }
   $sth = $dbh->prepare($query);
   $sth->execute || $form->dberror($query);

   $form->{title} = $locale->text('Inventory Onhand Value');
   &print_title;
   &print_criteria('partnumber','Number');
   &print_criteria('warehouse_name', 'Warehouse');
   &print_criteria('department_name', 'Department');
   &print_criteria('dateto', 'To');

   $form->info($query) if $form->{l_sql};
   print qq|<table width=100%><tr class=listheading>|;
   # print header
   for (@column_index) { print "\n$column_header{$_}" }
   print qq|</tr>|; 

   # Subtotal and total variables
   my $onhand_qty_total, $onhand_amt_total;

   # print data
   my $i = 1; my $no = 1;
   while (my $ref = $sth->fetchrow_hashref(NAME_lc)){
   	$form->{link} = qq|$form->{script}?action=onhandvalue_detail&id=$ref->{id}&l_components=$form->{l_components}&l_sql=$form->{l_sql}&path=$form->{path}&login=$form->{login}&callback=$form->{callback}|;

	$column_data{no}   		= rpt_txt($no);
   	$column_data{partnumber}	= rpt_txt($ref->{partnumber});
   	$column_data{description} 	= rpt_txt($ref->{description}, $form->{link});
   	$column_data{partsgroup}    	= rpt_txt($ref->{partsgroup});
   	$column_data{unit}    		= rpt_txt($ref->{unit});
   	$column_data{onhand_qty}    	= rpt_dec($ref->{onhand_qty});
   	$column_data{onhand_amt}    	= rpt_dec($ref->{onhand_amt});

	print "<tr valign=top class=listrow$i>";
	for (@column_index) { print "\n$column_data{$_}" }
	print "</tr>";
	$i++; $i %= 2; $no++;

	$onhand_qty_total += $ref->{onhand_qty};
	$onhand_amt_total += $ref->{onhand_amt};
   }

   # prepare data for footer
   for (@column_index) { $column_data{$_} = rpt_txt('&nbsp;') }
   $column_data{onhand_qty}    	= rpt_dec($onhand_qty_total);
   $column_data{onhand_amt}    	= rpt_dec($onhand_amt_total);

   # print footer
   print "<tr valign=top class=listtotal>";
   for (@column_index) { print "\n$column_data{$_}" }
   print "</tr>";

   print qq|</table>|;
   $sth->finish;
   $dbh->disconnect;
}

#-------------------------------
sub onhandvalue_detail {
  # callback to report list
   my $callback = qq|$form->{script}?action=onhandvalue_list|;
   for (qw(path login sessionid)) { $callback .= "&$_=$form->{$_}" }

   my $where = qq| (1 = 1)|;
   $where .= qq| AND parts_id = $form->{id}|;

   my $componentswhere;
   $componentswhere = qq| AND i.assemblyitem IS FALSE| if !$form->{l_components};

   @columns = qw(transdate invnumber qty sellprice extended);
   # if this is first time we are running this report.
   $form->{sort} = 'transdate' if !$form->{sort};
   $form->{oldsort} = 'none' if !$form->{oldsort};
   $form->{direction} = 'ASC' if !$form->{direction};
   @columns = $form->sort_columns(@columns);

   my %ordinal = (	invnumber => 1,
			transdate => 2,
			qty => 3,
			sellprice => 4,
			extended => 5
   );
   my $sort_order = $form->sort_order(\@columns, \%ordinal);

   # No. columns should always come first
   splice @columns, 0, 0, 'no';
   for (qw(no invnumber transdate qty sellprice extended)) { $form->{"l_$_"} = 'Y' }

   # Select columns selected for report display
   foreach $item (@columns) {
     if ($form->{"l_$item"} eq "Y") {
       push @column_index, $item;

       # add column to href and callback
       $callback .= "&l_$item=Y";
     }
   }
   $callback .= "&l_subtotal=$form->{l_subtotal}";
   my $href = $callback;
   $form->{callback} = $form->escape($callback,1);

   $dbh = $form->dbconnect(\%myconfig);
   $query = qq|SELECT partnumber, description FROM parts WHERE id=$form->{id}|;
   ($form->{partnumber}, $form->{description}) = $dbh->selectrow_array($query);

   $query = qq|SELECT
		ap.id,
		ap.invnumber,
		ap.transdate,
		(i.qty + i.allocated) * -1 AS qty,
		'ir' AS module,
		i.sellprice

		FROM ap
		JOIN invoice i ON (i.trans_id = ap.id)
		WHERE $where 
		AND i.qty + i.allocated < 0
		$componentswhere

	      UNION ALL

	      SELECT 
		ar.id,
		ar.invnumber,
		ar.transdate,
		(i.qty + i.allocated) * -1 AS qty,
		'is' AS module,
		i.sellprice

		FROM ar
		JOIN invoice i ON (i.trans_id = ar.id)
		WHERE $where 
		AND i.qty + i.allocated < 0
		$componentswhere

	      ORDER BY $form->{sort} $form->{direction}
	|;

   # store oldsort/direction information
   $href .= "&direction=$form->{direction}&oldsort=$form->{sort}";

   $column_header{no}   	= rpt_hdr('no', $locale->text('No.'));
   $column_header{invnumber} 	= rpt_hdr('invnumber', $locale->text('Invoice'), $href);
   $column_header{transdate} 	= rpt_hdr('transdate', $locale->text('Date'), $href);
   $column_header{qty}  	= rpt_hdr('qty', $locale->text('Qty'), $href);
   $column_header{sellprice}  	= rpt_hdr('sellprice', $locale->text('Price'), $href);
   $column_header{extended}  	= rpt_hdr('extended', $locale->text('Extended'));

   my %defaults = $form->get_defaults($dbh, \@{['precision', 'company']});
   for (keys %defaults) { $form->{$_} = $defaults{$_} }

   $sth = $dbh->prepare($query);
   $sth->execute || $form->dberror($query);

   $form->{title} = $locale->text('Inventory Onhand Value Detail');
   &print_title;
   print $locale->text('Number') . qq|: $form->{partnumber} / $form->{description}|;

   $form->info($query) if $form->{l_sql};
   print qq|<table width=100%><tr class=listheading>|;
   # print header
   for (@column_index) { print "\n$column_header{$_}" }
   print qq|</tr>|; 

   # Subtotal and total variables
   my $qty_total = 0;
   my $extended_total = 0;

   # print data
   my $i = 1; my $no = 1;
   while (my $ref = $sth->fetchrow_hashref(NAME_lc)){
   	$form->{link} = qq|$ref->{module}.pl?readonly=1&action=edit&id=$ref->{id}&path=$form->{path}&login=$form->{login}&sessionid=$form->{sessionid}&callback=$form->{callback}|;

	$column_data{no}   	= rpt_txt($no);
   	$column_data{invnumber}	= rpt_txt($ref->{invnumber}, $form->{link});
   	$column_data{transdate} = rpt_txt($ref->{transdate});
   	$column_data{qty}    	= rpt_dec($ref->{qty});
   	$column_data{sellprice} = rpt_dec($ref->{sellprice});
   	$column_data{extended} 	= rpt_dec($ref->{qty} * $ref->{sellprice});

	print "<tr valign=top class=listrow$i>";
	for (@column_index) { print "\n$column_data{$_}" }
	print "</tr>";
	$i++; $i %= 2; $no++;

	$qty_total += $ref->{qty};
	$extended_total += $ref->{qty} * $ref->{sellprice};
   }

   # prepare data for footer
   for (@column_index) { $column_data{$_} = rpt_txt('&nbsp;') }
   $column_data{qty}   	  = rpt_dec($qty_total);
   $column_data{extended} = rpt_dec($extended_total);

   # print footer
   print "<tr valign=top class=listtotal>";
   for (@column_index) { print "\n$column_data{$_}" }
   print "</tr>";

   print qq|</table>|;
   $sth->finish;
   $dbh->disconnect;
}

#=================================================
#
# Complete General Ledger
#
#=================================================
#-------------------------------
sub gl_search {
   $form->{title} = $locale->text('General Ledger');
   &print_title;

   &start_form;
   &start_table;

   &bld_department;
   &bld_warehouse;
   &bld_partsgroup;

   &print_date('fromdate', 'From');
   &print_date('todate', 'To');
   &print_text('fromaccount', 'Account >=', 15);
   &print_text('toaccount', 'Account <=', 15);
 
   print qq|<tr><th align=right>| . $locale->text('Include in Report') . qq|</th><td>|;

   #&print_radio;
   &print_checkbox('l_no', $locale->text('No.'), '', '');
   &print_checkbox('l_transdate', $locale->text('Date'), 'checked', '');
   &print_checkbox('l_reference', $locale->text('Reference'), 'checked', '');
   &print_checkbox('l_description', $locale->text('Description'), 'checked', '');
   &print_checkbox('l_source', $locale->text('Source'), 'checked', '<br>');
   &print_checkbox('l_debit', $locale->text('Debit'), 'checked', '');
   &print_checkbox('l_credit', $locale->text('Credit'), 'checked', '');
   &print_checkbox('l_balance', $locale->text('Balance'), 'checked', '<br>');
   &print_checkbox('l_group', $locale->text('Group'), '', '');
   #&print_checkbox('l_sql', $locale->text('SQL'), '');
   print qq|</td></tr>|;
   &end_table;
   print('<hr size=3 noshade>');
   $form->{nextsub} = 'gl_list';
   &print_hidden('nextsub');
   &add_button('Continue');
   &end_form;
}

#-------------------------------
sub gl_list {
  # callback to report list
   my $callback = qq|$form->{script}?action=onhandvalue_list|;
   for (qw(path login)) { $callback .= "&$_=$form->{$_}" }

   my $glwhere = qq| (1 = 1)|;
   $glwhere .= qq| AND c.accno >= '$form->{fromaccount}'| if $form->{fromaccount};
   $glwhere .= qq| AND c.accno <= '$form->{toaccount}'| if $form->{toaccount};
   $glwhere .= qq| AND ac.transdate >= '$form->{fromdate}'| if $form->{fromdate};
   $glwhere .= qq| AND ac.transdate <= '$form->{todate}'| if $form->{todate};
   my $arwhere = $glwhere;
   my $apwhere = $glwhere;

   @columns = qw(id transdate reference description source debit credit balance);
   # if this is first time we are running this report.
   $form->{sort} = '1' if !$form->{sort};
   $form->{oldsort} = 'none' if !$form->{oldsort};
   $form->{direction} = 'ASC' if !$form->{direction};
   @columns = $form->sort_columns(@columns);

   my %ordinal = (	id => 1,
			accno => 2,
			transdate => 3,
			reference => 4,
			description => 5,
			source => 6,
			debit => 7,
			credit => 8,
			balance => 9
   );
   my $sort_order = $form->sort_order(\@columns, \%ordinal);

   # No. columns should always come first
   splice @columns, 0, 0, 'no';

   # Select columns selected for report display
   foreach $item (@columns) {
     if ($form->{"l_$item"} eq "Y") {
       push @column_index, $item;

       # add column to href and callback
       $callback .= "&l_$item=Y";
     }
   }
   $callback .= "&l_subtotal=$form->{l_subtotal}";
   my $href = $callback;
   $form->{callback} = $form->escape($callback,1);

   my $query;

   if ($form->{l_group}){
     $query = qq|SELECT c.accno, c.description AS accdescription,
		 ac.transdate, g.reference, SUM(ac.amount) AS amount
                 FROM gl g
		 JOIN acc_trans ac ON (g.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 LEFT JOIN department d ON (d.id = g.department_id)
                 WHERE $glwhere
		 GROUP BY 1,2,3,4

		 UNION ALL

	         SELECT c.accno, c.description AS accdescription,
		 ac.transdate, a.invnumber, SUM(ac.amount) AS amount
		 FROM ar a
		 JOIN acc_trans ac ON (a.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 JOIN customer ct ON (a.customer_id = ct.id)
		 LEFT JOIN department d ON (d.id = a.department_id)
		 WHERE $arwhere
		 GROUP BY 1,2,3,4

		 UNION ALL

	         SELECT c.accno, c.description AS accdescription,
		 ac.transdate, a.invnumber, SUM(ac.amount) as amount
		 FROM ap a
		 JOIN acc_trans ac ON (a.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 JOIN vendor ct ON (a.vendor_id = ct.id)
		 LEFT JOIN department d ON (d.id = a.department_id)
		 WHERE $apwhere
		 GROUP BY 1,2,3,4

         	 ORDER BY 1,2,3,4|;
   } else {
     $query = qq|SELECT g.id, 'gl' AS type, g.reference,
                 g.description, ac.transdate, ac.source,
		 ac.amount, c.accno, g.notes, 
		 ac.cleared, d.description AS department,
		 ac.memo, '0' AS name_id, '' AS db,
		 c.description AS accdescription
                 FROM gl g
		 JOIN acc_trans ac ON (g.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 LEFT JOIN department d ON (d.id = g.department_id)
                 WHERE $glwhere

		 UNION ALL

	         SELECT a.id, 'ar' AS type, a.invnumber,
		 a.description, ac.transdate, ac.source,
		 ac.amount, c.accno, a.notes,
		 ac.cleared, d.description AS department,
		 ac.memo, ct.id AS name_id, 'customer' AS db,
		 c.description AS accdescription
		 FROM ar a
		 JOIN acc_trans ac ON (a.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 JOIN customer ct ON (a.customer_id = ct.id)
		 JOIN address ad ON (ad.trans_id = ct.id)
		 LEFT JOIN department d ON (d.id = a.department_id)
		 WHERE $arwhere

		 UNION ALL

	         SELECT a.id, 'ap' AS type, a.invnumber,
		 a.description, ac.transdate, ac.source,
		 ac.amount, c.accno, a.notes,
		 ac.cleared, d.description AS department,
		 ac.memo, ct.id AS name_id, 'vendor' AS db,
		 c.description AS accdescription
		 FROM ap a
		 JOIN acc_trans ac ON (a.id = ac.trans_id)
		 JOIN chart c ON (ac.chart_id = c.id)
		 JOIN vendor ct ON (a.vendor_id = ct.id)
		 JOIN address ad ON (ad.trans_id = ct.id)
		 LEFT JOIN department d ON (d.id = a.department_id)
		 WHERE $apwhere

         	 ORDER BY 8, 5, 3|;
   }

   # store oldsort/direction information
   $href .= "&direction=$form->{direction}&oldsort=$form->{sort}";

   $column_header{no}   	= rpt_hdr('no', $locale->text('No.'));
   $column_header{transdate} 	= rpt_hdr('transdate', $locale->text('Date'), $href);
   $column_header{reference} 	= rpt_hdr('reference', $locale->text('Reference'), $href);
   $column_header{description} 	= rpt_hdr('description', $locale->text('Description'), $href);
   $column_header{source}  	= rpt_hdr('source', $locale->text('Source'), $href);
   $column_header{debit}  	= rpt_hdr('debit', $locale->text('Debit'));
   $column_header{credit}  	= rpt_hdr('credit', $locale->text('Credit'));
   $column_header{balance}  	= rpt_hdr('balance', $locale->text('Balance'));

   $form->error($query) if $form->{l_sql};
   $dbh = $form->dbconnect(\%myconfig);
   my %defaults = $form->get_defaults($dbh, \@{['precision', 'company']});
   for (keys %defaults) { $form->{$_} = $defaults{$_} }

   if ($form->{l_csv} eq 'Y'){
	&export_to_csv($dbh, $query, 'parts_onhand');
	exit;
   }
   $sth = $dbh->prepare($query);
   $sth->execute || $form->dberror($query);

   $form->{title} = $locale->text('General Ledger');
   &print_title;
   &print_criteria('fromdate','From');
   &print_criteria('todate', 'To');
   &print_criteria('fromaccount', 'Account >=');
   &print_criteria('toaccount', 'Account <=');


   # Subtotal and total variables
   my $debit_total, $credit_total, $debit_subtotal, $credit_subtotal, $balance;

   # print data
   my $i = 1; my $no = 1;
   my $groupbreak = 'none';
   while (my $ref = $sth->fetchrow_hashref(NAME_lc)){
   	$form->{link} = qq|$form->{script}?action=onhandvalue_detail&id=$ref->{id}&path=$form->{path}&login=$form->{login}&callback=$form->{callback}|;
	if ($groupbreak ne "$ref->{accno}--$ref->{accdescription}"){
	   if ($groupbreak ne 'none'){
	      for (@column_index){ $column_data{$_} = rpt_txt('&nbsp;') }
              $column_data{debit} = rpt_dec($debit_subtotal * -1);
	      $column_data{credit} = rpt_dec($credit_subtotal);
	      print "<tr valign=top class=listsubtotal>";
	      for (@column_index) { print "\n$column_data{$_}" }
	      print "</tr>";
	   }
	   $groupbreak = "$ref->{accno}--$ref->{accdescription}";
	   print qq|<tr valign=top>|;
	   print qq|<th align=left colspan=6><br />|.$locale->text('Account') . qq| $groupbreak</th>|;
	   print qq|</tr>|;

   	   # print header
   	   print qq|<table width=100%><tr class=listheading>|;
   	   for (@column_index) { print "\n$column_header{$_}" }
   	   print qq|</tr>|; 

	   $debit_subtotal = 0; $credit_subtotal = 0; $balance = 0;
	   if ($form->{fromdate}){
   	      my $openingquery = qq|
		SELECT SUM(amount) 
		FROM acc_trans
		WHERE chart_id = (SELECT id FROM chart WHERE accno = '$ref->{accno}')
		AND transdate < '$form->{fromdate}'
	     |;
	     ($balance) = $dbh->selectrow_array($openingquery);
	     if ($balance != 0){
	        for (@column_index){ $column_data{$_} = rpt_txt('&nbsp;') }
   		$column_data{debit} 	= rpt_dec(0);
   		$column_data{credit} 	= rpt_dec(0);
   		$column_data{balance} 	= rpt_dec(0 - $balance);

		# print footer
		print "<tr valign=top class=listrow0>";
		for (@column_index) { print "\n$column_data{$_}" }
		print "</tr>";
	     }
	   }
        }
	$column_data{no}   		= rpt_txt($no);
   	$column_data{transdate}		= rpt_txt($ref->{transdate});
   	$column_data{reference} 	= rpt_txt($ref->{reference});
   	$column_data{description} 	= rpt_txt($ref->{description});
   	$column_data{source}    	= rpt_txt($ref->{source});
	if ($ref->{amount} > 0){
  	  $column_data{debit}    	= rpt_dec(0);
   	  $column_data{credit}    	= rpt_dec($ref->{amount});
	} else {
  	  $column_data{debit}    	= rpt_dec(0 - $ref->{amount});
   	  $column_data{credit}    	= rpt_dec(0);
	}
	$balance += $ref->{amount};
	$column_data{balance} 		= rpt_dec($balance * -1);

	print "<tr valign=top class=listrow$i>";
	for (@column_index) { print "\n$column_data{$_}" }
	print "</tr>";
	$i++; $i %= 2; $no++;

	$debit_subtotal += $ref->{amount} if $ref->{amount} < 0;
	$credit_subtotal += $ref->{amount} if $ref->{amount} > 0;
	$debit_total += $ref->{amount} if $ref->{amount} < 0;
	$credit_total += $ref->{amount} if $ref->{amount} > 0;
   }

   # prepare data for footer
   for (@column_index) { $column_data{$_} = rpt_txt('&nbsp;') }

   # subtotal for last group
   $column_data{debit} = rpt_dec($debit_subtotal * -1);
   $column_data{credit} = rpt_dec($credit_subtotal);
   print "<tr valign=top class=listsubtotal>";
   for (@column_index) { print "\n$column_data{$_}" }
   print "</tr>";

   $column_data{debit} = rpt_dec($debit_total * -1);
   $column_data{credit} = rpt_dec($credit_total);

   # grand totals
   print "<tr valign=top class=listtotal>";
   for (@column_index) { print "\n$column_data{$_}" }
   print "</tr>";

   print qq|</table>|;
   $sth->finish;
   $dbh->disconnect;
}

#===================================
#
# Audit Trail Report
#
#==================================
#-------------------------------
sub audit_search {
   $form->{title} = $locale->text('Audit Trail Report');
   &print_title;
   &start_form;
   &start_table;

   &bld_employee;

   &print_text('trans_id', 'Trans ID', 15);
   &print_text('tablename', 'Table', 15);
   &print_text('refernece', 'Refernce', 15);
   &print_text('formname', 'Form', 15);
   &print_text('formaction', 'Action', 15);
   &print_date('fromtransdate', 'From Trans Date');
   &print_date('totransdate', 'To Trans Date');
   &print_select('employee', 'Employee');
 
   print qq|<tr><th align=right>| . $locale->text('Include in Report') . qq|</th><td>|;

   &print_checkbox('l_no', $locale->text('No.'), '', '<br>');
   &print_checkbox('l_trans_id', $locale->text('Trans ID'), 'checked', '<br>');
   &print_checkbox('l_tablename', $locale->text('Table'), 'checked', '<br>');
   &print_checkbox('l_reference', $locale->text('Reference'), 'checked', '<br>');
   &print_checkbox('l_formname', $locale->text('Form'), 'checked', '<br>');
   &print_checkbox('l_action', $locale->text('Action'), 'checked', '<br>');
   &print_checkbox('l_transdate', $locale->text('Trans Date'), 'checked', '<br>');
   &print_checkbox('l_name', $locale->text('Employee'), 'checked', '<br>');
   &print_checkbox('l_csv', $locale->text('CSV'), '', '<br>');
   #&print_checkbox('l_sql', $locale->text('SQL'), '', '<br>');

   print qq|</td></tr>|;
   &end_table;
   print('<hr size=3 noshade>');
   $form->{nextsub} = 'audit_list';
   &print_hidden('nextsub');
   &add_button('Continue');
   &end_form;
}

#-------------------------------
sub audit_list {
  # callback to report list
   my $callback = qq|$form->{script}?action=audit_list|;
   for (qw(path login sessionid)) { $callback .= "&$_=$form->{$_}" }

   &split_combos('employee');
   $form->{employee_id} *= 1;
   $tablename = lc $form->{tablename};
   $reference = $form->like(lc $form->{reference});
   $formname = lc $form->{formname};
   $formaction = lc $form->{formaction};
   
   my $where = qq| (1 = 1)|;
   $where .= qq| AND (a.trans_id = $form->{trans_id})| if $form->{trans_id};
   $where .= qq| AND (a.tablename = '$tablename')| if $form->{tablename};
   $where .= qq| AND (a.LOWER(reference) LIKE '$reference')| if $form->{reference};
   $where .= qq| AND (a.formname = '$formname')| if $form->{formname};
   $where .= qq| AND (a.action = '$formaction')| if $form->{formaction};
   $where .= qq| AND (a.transdate >= '$form->{fromtransdate}')| if $form->{fromtransdate};
   $where .= qq| AND (a.transdate <= '$form->{totransdate}')| if $form->{totransdate};
   $where .= qq| AND (a.employee_id = $form->{employee_id})| if $form->{employee};

   @columns = qw(trans_id tablename reference formname action transdate employee_id);
   # if this is first time we are running this report.
   $form->{sort} = 'tablename' if !$form->{sort};
   $form->{oldsort} = 'none' if !$form->{oldsort};
   $form->{direction} = 'ASC' if !$form->{direction};
   @columns = $form->sort_columns(@columns);

   my %ordinal = (	trans_id => 1,
			tablename => 2,
			reference => 3,
			formname => 4,
			action => 5,
			transdate => 6,
			name => 7
   );
   my $sort_order = $form->sort_order(\@columns, \%ordinal);

   # No. columns should always come first
   splice @columns, 0, 0, 'no';

   # Select columns selected for report display
   foreach $item (@columns) {
     if ($form->{"l_$item"} eq "Y") {
       push @column_index, $item;

       # add column to href and callback
       $callback .= "&l_$item=Y";
     }
   }
   $callback .= "&l_subtotal=$form->{l_subtotal}";
   my $href = $callback;
   $form->{callback} = $form->escape($callback,1);

   $query = qq|SELECT 
		a.trans_id, 
		a.tablename, 
		a.reference, 
		a.formname,
		a.action,
		a.transdate,
		e.name
		FROM audittrail a
		LEFT JOIN employee e ON (e.id = a.employee_id)
		WHERE $where
		ORDER BY $form->{sort} $form->{direction}|;
		#ORDER BY $sort_order|;

   # store oldsort/direction information
   $href .= "&direction=$form->{direction}&oldsort=$form->{sort}";

   $column_header{no}   		= rpt_hdr('no', $locale->text('No.'));
   $column_header{trans_id} 		= rpt_hdr('trans_id', $locale->text('Trans ID'), $href);
   $column_header{tablename} 		= rpt_hdr('tablename', $locale->text('Table'), $href);
   $column_header{reference}  		= rpt_hdr('reference', $locale->text('Reference'), $href);
   $column_header{formname}  		= rpt_hdr('formname', $locale->text('Form'), $href);
   $column_header{action}  		= rpt_hdr('action', $locale->text('Action'), $href);
   $column_header{transdate}  		= rpt_hdr('transdate', $locale->text('Date'), $href);
   $column_header{name}  		= rpt_hdr('name', $locale->text('Employee'), $href);

   $form->error($query) if $form->{l_sql};
   $dbh = $form->dbconnect(\%myconfig);
   my %defaults = $form->get_defaults($dbh, \@{['precision', 'company']});
   for (keys %defaults) { $form->{$_} = $defaults{$_} }

   if ($form->{l_csv} eq 'Y'){
	&export_to_csv($dbh, $query, 'audit_trail');
	exit;
   }
   $sth = $dbh->prepare($query);
   $sth->execute || $form->dberror($query);

   $form->{title} = $locale->text('Audit Trail');
   &print_title;
   &print_criteria('tablename','Table');
   &print_criteria('reference', 'Reference');
   &print_criteria('formname', 'Form');
   &print_criteria('formaction', 'Action');
   &print_criteria('fromtransdate', 'From');
   &print_criteria('totransdate', 'To');
   &print_criteria('employee_name', 'Employee');

   print qq|<table width=100%><tr class=listheading>|;
   # print header
   for (@column_index) { print "\n$column_header{$_}" }
   print qq|</tr>|; 

   # print data
   my $i = 1; my $no = 1;
   my $groupbreak = 'none';
   while (my $ref = $sth->fetchrow_hashref(NAME_lc)){
   	$form->{link} = qq|$form->{script}?action=edit&id=$ref->{id}&path=$form->{path}&login=$form->{login}&sessionid=$form->{sessionid}&callback=$form->{callback}|;

	$column_data{no}   		= rpt_txt($no);
   	$column_data{trans_id}		= rpt_txt($ref->{trans_id});
   	$column_data{tablename}		= rpt_txt($ref->{tablename});
   	$column_data{reference} 	= rpt_txt($ref->{reference});
   	$column_data{formname}    	= rpt_txt($ref->{formname});
   	$column_data{action}   		= rpt_txt($ref->{action});
   	$column_data{transdate}    	= rpt_txt($ref->{transdate});
   	$column_data{name}    		= rpt_txt($ref->{name});

	print "<tr valign=top class=listrow$i>";
	for (@column_index) { print "\n$column_data{$_}" }
	print "</tr>";
	$i++; $i %= 2; $no++;

   }
   print qq|</table>|;

   $sth->finish;
   $dbh->disconnect;
}

#######
## EOF
#######

