1;

sub continue { &{$form->{nextsub} } };

sub ask_dbcheck {
  $form->{title} = $locale->text('Ledger Doctor');
  $form->header;
  $firstdate = $form->current_date(\%myconfig);
  $lastdate = $form->current_date(\%myconfig);
  print qq|
<body>
  <table width=100%>
     <tr><th class=listtop>$form->{title}</th></tr>
  </table><br />

<h1>Check for database inconsistancies</h1>
<form method=post action='$form->{script}'>
  <table>
    <th>|. $locale->text('First transaction date') . qq|</th><td><input name=firstdate size=11 value='$firstdate' title='$myconfig{dateformat}'></td></tr>
<th>|. $locale->text('Last transaction date') . qq|</th><td><input name=lastdate size=11 value='$lastdate' title='$myconfig{dateformat}'></td></tr>
  </table>|.
$locale->text('All transactions outside this date range will be reported as having invalid dates.').qq|
<br><br><hr />
<input type=submit class=submit name=action value="|.$locale->text('Continue').qq|">
|;

  $form->{nextsub} = 'do_dbcheck';
  $form->hide_form(qw(title path nextsub login));

print qq|
</table>
</form>
</body>
|;
}

sub do_dbcheck {
  $form->{title} = $locale->text('Ledger Doctor');
  $form->header;
  print qq|<body><table width=100%><tr><th class=listtop>$form->{title}</th></tr></table><br />|;
  my $dbh = $form->dbconnect(\%myconfig);
  my $query, $sth, $i;

  #------------------
  # 1. Invalid Dates
  #------------------
  print qq|<h2>Invalid Dates</h2>|;
  $query = qq|
		SELECT 'AR' AS module, id, invnumber, transdate 
		FROM ar
		WHERE transdate < '$form->{firstdate}'
		OR transdate > '$form->{lastdate}'

		UNION ALL

		SELECT 'AP' AS module, id, invnumber, transdate 
		FROM ap
		WHERE transdate < '$form->{firstdate}'
		OR transdate > '$form->{lastdate}'

		UNION ALL

		SELECT 'GL' AS module, id, reference, transdate 
		FROM gl
		WHERE transdate < '$form->{firstdate}'
		OR transdate > '$form->{lastdate}'
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Module').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Invoice Number / Reference').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Date').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     print qq|<tr class=listrow$i>|;
     print qq|<td>$ref->{module}</td>|;
     print qq|<td>$ref->{invnumber}</td>|;
     print qq|<td>$ref->{transdate}</td>|;
     print qq|</tr>|;
  }
  print qq|</table>|;

  #------------------------
  # 2. Unbalanced Journals
  #------------------------
  print qq|<h3>Unbalanced Journals</h3>|;
  $query = qq|
	SELECT 'GL' AS module, gl.reference AS invnumber, 
		gl.transdate, SUM(ac.amount) AS amount
	FROM acc_trans ac
	JOIN gl ON (gl.id = ac.trans_id)
	GROUP BY 1, 2, 3
	HAVING SUM(ac.amount) <> 0

	UNION ALL

	SELECT 'AR' AS module, ar.invnumber, 
		ar.transdate, SUM(ac.amount) AS amount
	FROM acc_trans ac
	JOIN ar ON (ar.id = ac.trans_id)
	GROUP BY 1, 2, 3 
	HAVING SUM(ac.amount) <> 0

	UNION ALL

	SELECT 'AP' AS module, ap.invnumber, 
		ap.transdate, SUM(ac.amount) AS amount
	FROM acc_trans ac
	JOIN ap ON (ap.id = ac.trans_id)
	GROUP BY 1, 2, 3 
	HAVING SUM(ac.amount) <> 0

	ORDER BY 3
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Module').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Invoice Number / Reference').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Date').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Amount').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     if ($form->round_amount($ref->{amount}, 2) != 0){
     	print qq|<tr class=listrow$i>|;
     	print qq|<td>$ref->{module}</td>|;
     	print qq|<td>$ref->{invnumber}</td>|;
     	print qq|<td>$ref->{transdate}</td>|;
     	print qq|<td align=right>|.$form->format_amount(\%myconfig, $ref->{amount}).qq|</td>|;
     	print qq|</tr>|;
     }
  }
  print qq|</table>|;

  #-------------------
  # 3. Orphaned Rows
  #-------------------
  print qq|<h3>Orphaned Rows</h3>|;
  $query = qq|
		SELECT * FROM acc_trans
		WHERE trans_id NOT IN 
			(SELECT id FROM ar 
			UNION ALL  
			SELECT id FROM ap
			UNION ALL
			SELECT id FROM gl)
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Trans ID').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Date').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     print qq|<tr class=listrow$i>|;
     print qq|<td>$ref->{trans_id}</td>|;
     print qq|<td>$ref->{transdate}</td>|;
     print qq|</tr>|;
  }
  print qq|</table>|;

  #---------------------------------------
  # 4. Transactions with Deleted Accounts
  #---------------------------------------
  print qq|<h3>Deleted Accounts</h3>|;
  $query = qq|
		SELECT trans_id, chart_id, source, transdate, amount
		FROM acc_trans
		WHERE chart_id NOT IN (SELECT id FROM chart)
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Chart ID').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Source').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Date').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Amount').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     print qq|<tr class=listrow$i>|;
     print qq|<td>$ref->{chart_id}</td>|;
     print qq|<td>$ref->{source}</td>|;
     print qq|<td>$ref->{transdate}</td>|;
     print qq|<td align=right>$ref->{amount}</td>|;
     print qq|</tr>|;
  }
  print qq|</table>|;


  #----------------------------
  # 5. Duplicate Part Numbers
  #----------------------------
  print qq|<h3>Duplicate Parts</h3>|;
  $query = qq|
		SELECT partnumber, COUNT(*) AS cnt
		FROM parts
		GROUP BY partnumber
		HAVING COUNT(*) > 1
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Number').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Duplicates').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     print qq|<tr class=listrow$i>|;
     print qq|<td>$ref->{partnumber}</td>|;
     print qq|<td align=right>$ref->{cnt}</td>|;
     print qq|</tr>|;
  }
  print qq|</table>|;

  #-----------------------------
  # 6. Invoices with Deleted Parts
  #-----------------------------
  print qq|<h3>Deleted Parts</h3>|;
  $query = qq|
		SELECT trans_id, parts_id, description, qty
		FROM invoice
		WHERE parts_id NOT IN (SELECT id FROM parts)
  |;
  $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute;
  print qq|<table>|;
  print qq|<tr class=listheading>|;
  print qq|<th class=listheading>|.$locale->text('Part ID').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Description').qq|</td>|;
  print qq|<th class=listheading>|.$locale->text('Qty').qq|</td>|;
  print qq|</tr>|;
  $i = 0;
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
     print qq|<tr class=listrow$i>|;
     print qq|<td>$ref->{parts_id}</td>|;
     print qq|<td>$ref->{description}</td>|;
     print qq|<td align=right>$ref->{qty}</td>|;
     print qq|</tr>|;
  }
  print qq|
</table>
</body>
</html>|;

  $dbh->disconnect;
}

######
# EOF 
######

