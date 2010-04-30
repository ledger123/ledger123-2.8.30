# INSTALLATION
# Please follow 4 steps in the comments below to install this report into sql-ledger.

# (1) Add these 3 lines to custom_menu.ini (remove # characters)
#[Gross Rental Profit]
#module=rp.pl
#action=rentalprofit_search

# (2) Add following 6 lines to bin/mozilla/custom_rp.pl (for first report only).
1; 
sub export { &{ $form->{nextsub} } };

sub save_report {
  $form->save_form('report');
}

# (3) Run 'perl locales.pl' in your locale folder if you are not using Default English language

# (4) Add following code to bin/mozilla/custom_rp.pl for each new report.
sub rentalprofit_search {
  $form->{title} = $locale->text('Gross Rental Profit');

  $form->all_vc(\%myconfig, 'vendor', 'AP');
  delete $form->{all_employee}; # Prevent duplicate list
  $form->all_vc(\%myconfig, 'customer', 'AR');

  # Departments 
  if (@{ $form->{all_department} }) {
    if ($myconfig{department_id} and $myconfig{role} eq 'user'){
	$form->{selectdepartment} = qq|<option value="$myconfig{department}--$myconfig{department_id}">$myconfig{department}\n|;
    } else {
	$form->{selectdepartment} = "<option>\n";
	for (@{ $form->{all_department} }) { $form->{selectdepartment} .= qq|<option value="|.$form->quote($_->{description}).qq|--$_->{id}">$_->{description}\n| }
    }
    $department = qq| 
        <tr> 
	  <th align=right nowrap>|.$locale->text('Department').qq|</th>
	  <td><select name=department>$form->{selectdepartment}</select></td>
	</tr>
|;
  }
  # Month/Year widget if needed

  @a = ();
  push @a, (qq|<input name="l_no" class=checkbox type=checkbox value=Y>|.$locale->text('No.'));

  push @a, (qq|<input name="l_department" class=checkbox type=checkbox value=Y checked>|.$locale->text('Department'));
  push @a, (qq|<input name="l_booking" class=checkbox type=checkbox value=Y checked>|.$locale->text('Booking'));
  push @a, (qq|<input name="l_accno" class=checkbox type=checkbox value=Y checked>|.$locale->text('Account'));
  push @a, (qq|<input name="l_acctitle" class=checkbox type=checkbox value=Y checked>|.$locale->text('Acctitle'));
  push @a, (qq|<input name="l_amount" class=checkbox type=checkbox value=Y checked>|.$locale->text('Total'));
  $form->header;

  print qq|
<body>

<form method=post action=$form->{script}>

<table width=100%>
  <tr>
    <th class=listtop>$form->{title}</th>
  </tr>
  <tr height="5"></tr>
  <tr>
    <td>
      <table width=100%>
        <tr valign=top>
	  <td>
	    <table>
$customer
$vendor
$department
$warehouse
$employee
$project
$partsgroup		<tr>
		  <th align=right>|.$locale->text('Booking').qq|</th>
		  <td><input name=booking size=25 value="$form->{booking}"></td>
		</tr>
		<tr>
		  <th align=right>|.$locale->text('Account').qq|</th>
		  <td><input name=accno size=30 value="4020 5010 5411"></td>
		</tr>
		<tr>
		  <th align=right>|.$locale->text('Acctitle').qq|</th>
		  <td><input name=acctitle size=25 value="$form->{acctitle}"></td>
		</tr>
		<tr>
		  <th align=right>|.$locale->text('Total').qq|</th>
		  <td>
		     <input name=amount1 size=8 value="$form->{amount1}" title="$myconfig{dateformat}"> - 
		     <input name=amount2 size=8 value="$form->{amount2}" title="$myconfig{dateformat}">
		  </td>
		</tr>

	     </table>
	   </td>
	</tr>
	<tr>
	  <table>
	    <tr>
	      <th align=right>|.$locale->text('Include in Report').qq|</th>
	      <td>
		<table>

|;
  while (@a) {
    print qq|<tr>\n|;
    for (1 .. 6) {
      print qq|<td nowrap>|. shift @a;
      print qq|</td>\n|;
    }
    print qq|</tr>\n|;
  }

  print qq|
	   	    <tr>
		      <td><input name="l_subtotal" class=checkbox type=checkbox value=Y> |.$locale->text('Subtotal').qq|</td>
		    </tr>
		  </table>
	        </td>
	      </tr>
	    </table>
	</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><hr size=3 noshade></td>
  </tr>
</table>

<input type=hidden name=nextsub value=rentalprofit_report>
|;

  $form->hide_form(qw(path login));
  
  print qq|
<br>
<input class=submit type=submit name=action value="|.$locale->text('Continue').qq|">
</form>
|;

  print qq|

</body>
</html>
|;
}

sub rentalprofit_report {

  my @columns = qw( department booking accno acctitle amount);
  my %ordinal = (
  department => 1,
    booking => 2,
    accno => 3,
    acctitle => 4,
    amount => 5,
  );

  $form->{sort} = "acctype" unless $form->{sort};
  $form->{direction} = 'ASC' if !$form->{direction};
  $form->{direction} = ($form->{direction} eq 'ASC') ? "ASC" : "DESC";

  $href = "$form->{script}?action=rentalprofit_report";
  for (qw(path login l_subtotal summary)) { $href .= "&$_=$form->{$_}" }
  @columns = $form->sort_columns(@columns);
  my $sort_order = $form->sort_order(@columns, \%ordinal);
  splice @columns, 0, 0, 'no';
  $href .= "&direction=$form->{direction}&oldsort=$form->{sort}";

  for (qw(customer vendor department warhouse project employee partsgroup)){
     if ($form->{$_}){
       ($form->{$_}, $form->{"${_}_id"}) = split(/--/, $form->{$_});
       $form->{"${_}_id"} *= 1;
       $href .= "&$_=".$form->escape($form->{$_});
     }
  }
  for (qw(department warehouse project employee partsgroup)) { $form->{"l_$_"} = '' if $form->{$_} }

  $form->{title} = $locale->text('Gross Rental Profit') . " / $form->{company}";

  my $dbh = $form->dbconnect(\%myconfig);
  my %defaults = $form->get_defaults($dbh, \@{['precision', 'company']});
  for (keys %defaults) { $form->{$_} = $defaults{$_} }

  my $where = "c.category IN ('I', 'E')";

  if ($form->{department}){
     $where .= " AND aa.department_id = $form->{department_id}";
     $option .= "\n<br>" if $option;
     $option .= $locale->text('Department') . " : $form->{'department'}";
  }

  if ($form->{booking}){
     $href .= "&booking=".$form->escape($form->{booking});
     $option .= "\n<br>" if $option;
     $option .= $locale->text('Booking') . " : $form->{booking}";
     $var = $form->like(lc $form->{booking});
     $where .= " AND lower(aa.description) LIKE '$var'";
  }

  if ($form->{accno}){
     $href .= "&accno=".$form->escape($form->{accno});
     $option .= "\n<br>" if $option;
     $option .= $locale->text('Account') . " : $form->{accno}";
     my $str;
     for (split / /, $form->{accno}){ $str .= "'$_'," };
     chop $str;
     $where .= " AND c.accno IN ($str)";
  }

  if ($form->{acctitle}){
     $href .= "&acctitle=".$form->escape($form->{acctitle});
     $option .= "\n<br>" if $option;
     $option .= $locale->text('Acctitle') . " : $form->{acctitle}";
     $var = $form->like(lc $form->{acctitle});
     $where .= " AND lower(c.description) LIKE '$var'";
  }

  if ($form->{amount1} or $form->{amount2}){
     $option .= "\n<br>" if $option;
     if ($form->{amount1}){
       $form->{amount1} *= 1;
       $href .= "&amount1=".$form->escape($form->{amount1});
       $where .= " AND amount >= $form->{amount1}";
     }
     if ($form->{amount2}){
       $form->{amount2} *= 1;
       $href .= "&amount2=".$form->escape($form->{amount2});
       $where .= " AND amount <= $form->{amount2}";
     }
     $option .= $locale->text('Total') . " : $form->{amount1} - $form->{amount2}";
  }

  my $query;

  $query = qq|
SELECT d.description AS department, aa.description AS booking, 'I' AS acctype, c.accno, c.description AS acctitle, SUM(ac.amount) AS amount
FROM ar aa
JOIN department d ON (d.id = aa.department_id)
JOIN acc_trans ac ON (ac.trans_id = aa.id)
JOIN chart c ON (c.id = ac.chart_id)
WHERE c.link LIKE '%AR_amount%'
AND aa.description IS NOT NULL
AND $where
GROUP BY 1, 2, 3, 4, 5

UNION ALL

SELECT d.description AS department, aa.description AS booking, 'X' AS acctype, c.accno, c.description AS acctitle, SUM(ac.amount) AS amount
FROM ap aa
JOIN department d ON (d.id = aa.department_id)
JOIN acc_trans ac ON (ac.trans_id = aa.id)
JOIN chart c ON (c.id = ac.chart_id)
WHERE c.link LIKE '%AP_amount%'
AND aa.description IS NOT NULL
AND $where
GROUP BY 1, 2, 3, 4, 5

ORDER BY 1, 2, 3, 4, 5

|;  

#ORDER BY $form->{sort} $form->{direction}
  my $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute || $form->dberror($query);

  @column_index = ();
  foreach $item (@columns) {
    if ($form->{"l_$item"} eq "Y") {
      push @column_index, $item;
      $href .= "&l_$item=Y";
    }
  }
  $callback = $form->escape($href,1);

  $column_header{no} = "<th>".$locale->text('No.')."</th>";
  $column_header{department} = "<th><a class=listheading href=$href&sort=department>".$locale->text('Department')."</a></th>";  $column_header{booking} = "<th><a class=listheading href=$href&sort=booking>".$locale->text('Booking')."</a></th>";  $column_header{accno} = "<th><a class=listheading href=$href&sort=accno>".$locale->text('Account')."</a></th>";  $column_header{acctitle} = "<th><a class=listheading href=$href&sort=acctitle>".$locale->text('Acctitle')."</a></th>";  $column_header{amount} = "<th><a class=listheading href=$href&sort=amount>".$locale->text('Total')."</a></th>";

  $form->header;

  print qq|
<body>

<table width=100%>
  <tr>
    <th class=listtop>$form->{title}</th>
  </tr>
  <tr height="5"></tr>
  <tr>
    <td>$option</td>
  </tr>
  <tr>
    <td>
      <table width=100%>
	<tr class=listheading>
|;

  for (@column_index) { print "$column_header{$_}\n" }

  print "
        </tr>
";
  

  my $amount_total = 0; my $amount_subtotal = 0;

  my $i = 1; my $no = 1;
  my $groupbreak = 'none';
  my $lastbooking = 'none';
  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
    # You can use the link below to goto any form (and come back too)
    $form->{link} = qq|$form->{script}?action=edit&id=$ref->{id}&path=$form->{path}&login=$form->{login}&callback=$callback|;
    $groupbreak = $ref->{$form->{sort}} if $groupbreak eq 'none';
    if ($form->{l_subtotal}){
       if ($groupbreak ne $ref->{$form->{sort}}){
 	  $groupbreak = $ref->{$form->{sort}};
	  for (@column_index) { $column_data{$_} = "<td>&nbsp;</td>" }
	  $column_data{amount} = qq|<th align=right>|.$form->format_amount(\%myconfig, $amount_subtotal, $form->{precision}) . qq|</th>|;
	  $amount_subtotal = 0;
	  print "<tr valign=top class=listsubtotal>";
	  for (@column_index) { print "\n$column_data{$_}" }
	  print "</tr>";
	  if ($ref->{acctype} eq 'I'){
	     $column_data{amount} = qq|<th align=right>|.$form->format_amount(\%myconfig, $amount_total, $form->{precision}) . qq|</th>|;
	     $amount_total = 0;
	     print "<tr valign=top class=listtotal>";
	     for (@column_index) { print "\n$column_data{$_}" }
	     print "</tr>";
	  }
       }
    }
    $column_data{no} = qq|<td align=right>$no</td>|;
    $column_data{department} = qq|<td nowrap>$ref->{department}</td>|;
    if ($lastbooking eq $ref->{booking}){
      $column_data{booking} = qq|<td nowrap>&nbsp;</td>|;
    } else {
      $column_data{booking} = qq|<td nowrap>$ref->{booking}</td>|;
      $lastbooking = $ref->{booking};
    }
    $column_data{accno} = qq|<td nowrap>$ref->{accno}</td>|;
    $column_data{acctitle} = qq|<td nowrap>$ref->{acctitle}</td>|;
    $column_data{amount} = qq|<td align=right>|.$form->format_amount(\%myconfig, $ref->{amount}, $form->{precision}).qq|</td>|;

    print qq|
	<tr class=listrow$i>
|;
    for (@column_index) { print "$column_data{$_}\n" }
    $i++; $i %= 2; $no++;

    print qq|
        </tr>
|;

    $amount_subtotal += $ref->{amount}; $amount_total += $ref->{amount};

  }

  # Print subtotals of last group
  if ($form->{l_subtotal}){
     for (@column_index) { $column_data{$_} = "<td>&nbsp;</td>" }
     $column_data{amount} = qq|<th align=right>|.$form->format_amount(\%myconfig, $amount_subtotal, $form->{precision}) . qq|</th>|;
     print "<tr valign=top class=listsubtotal>";
     for (@column_index) { print "\n$column_data{$_}" }
     print "</tr>";
  }

  # Now print grand totals
  print qq|
	<tr class=listtotal>
|;
  for (@column_index) { $column_data{$_} = "<td>&nbsp;</td>" }
  $column_data{amount} = qq|<th align=right>|.$form->format_amount(\%myconfig, $amount_total, $form->{precision}) . qq|</th>|;
  for (@column_index) { print "\n$column_data{$_}" }

  print qq|
	</tr>
      </table>
    </td>
  </tr>
  <tr>
    <td><hr size=3 noshade></td>
  </tr>
</table>

<form method=post action=$form->{script}>
|;

  $form->{actionname} = 'test_report';
  $form->{nextsub} = 'rentalprofit_export';
  $form->hide_form;
  
  print qq|
<br>
<select name=filetype><option value=csv>csv<option value=tsv>tsv<option value=xml>xml</select>
<input class=submit type=submit name=action value="|.$locale->text('Export').qq|">
&nbsp;&nbsp;
<input name=reportname type=text size=20>
<input class=submit type=submit name=action value="|.$locale->text('Save Report').qq|">
</form>

</body>
</html>
|;

}

sub rentalprofit_export {

  $form->{file} = 'rentalprofit';
  my @columns = qw( department booking accno acctitle amount);

  @column_index = ();
  foreach $item (@columns) {
    push @column_index, $item if ($form->{"l_$item"} eq "Y")
  }

  $form->{includeheader} = 1;

  if ($form->{filetype} eq 'csv'){
    $form->{tabdelimited} = 0;
    $form->{delimiter} = ",";
  } elsif ($form->{filetype} eq 'tsv') {
    $form->{tabdelimited} = 1;
    $form->{delimiter} = "\t";
    for (@column_index) { $column_index{$_} = 1 }
  }

  for (qw(customer vendor department warhouse project employee partsgroup)){
     if ($form->{$_}){
       ($form->{$_}, $form->{"${_}_id"}) = split(/--/, $form->{$_});
       $form->{"${_}_id"} *= 1;
     }
  }
  for (qw(department warehouse project employee partsgroup)) { $form->{"l_$_"} = '' if $form->{$_} }

  my $dbh = $form->dbconnect(\%myconfig);

  my $where = "c.category IN ('I', 'E')";
  if ($form->{department}){
     $where .= " AND department_id = $form->{department_id}";
  }






  if ($form->{booking}){
     $var = $form->like(lc $form->{booking});
     $where .= " AND lower(aa.description) LIKE '$var'";
  }
  if ($form->{accno}){
     my $str;
     for (split / /, $form->{accno}){ $str .= "'$_'," };
     chop $str;
     $where .= " AND c.accno IN ($str)";
  }
  if ($form->{acctitle}){
     $var = $form->like(lc $form->{acctitle});
     $where .= " AND lower(c.description) LIKE '$var'";
  }
  if ($form->{amount1} or $form->{amount2}){
     if ($form->{amount1}){
       $where .= " AND aa.amount >= $form->{amount1}";
     }
     if ($form->{amount2}){
       $where .= " AND amount <= $form->{amount2}";
     }
  }

  $query = qq|
SELECT d.description AS department, aa.description AS booking, c.accno, c.description AS acctitle, SUM(ac.amount) AS amount
FROM ar aa
JOIN department d ON (d.id = aa.department_id)
JOIN acc_trans ac ON (ac.trans_id = aa.id)
JOIN chart c ON (c.id = ac.chart_id)
WHERE c.link LIKE '%AR_amount%'
AND aa.description IS NOT NULL
AND $where
GROUP BY 1, 2, 3, 4

UNION ALL

SELECT d.description AS department, aa.description AS booking, c.accno, c.description AS acctitle, SUM(ac.amount) AS amount
FROM ap aa
JOIN department d ON (d.id = aa.department_id)
JOIN acc_trans ac ON (ac.trans_id = aa.id)
JOIN chart c ON (c.id = ac.chart_id)
WHERE c.link LIKE '%AP_amount%'
AND aa.description IS NOT NULL
AND $where
GROUP BY 1, 2, 3, 4

ORDER BY 1, 2, 3, 4

|;  
  my $sth = $dbh->prepare($query) || $form->dberror($query);
  $sth->execute || $form->dberror($query);

  $column_header{department} = $locale->text('Department');
  $column_header{booking} = $locale->text('Booking');
  $column_header{accno} = $locale->text('Account');
  $column_header{acctitle} = $locale->text('Acctitle');
  $column_header{amount} = $locale->text('Total');


  open(OUT, ">-") or $form->error("STDOUT : $!");
  binmode(OUT);
  print qq|Content-Type: application/file;
Content-Disposition: attachment; filename="$form->{file}.$form->{filetype}"\n\n|;

  print OUT qq|<?xml version="1.0" ?>\n<database>\n| if $form->{filetype} eq 'xml';
  # header
  $line = "";
  if ($form->{includeheader} and $form->{filetype} ne 'xml') {
    for (@column_index) {
      if ($form->{tabdelimited}) {
	$line .= qq|$column_header{$_}$form->{delimiter}|;
      } else {
	$line .= qq|"$column_header{$_}"$form->{delimiter}|;
      }
    }
    chop $line;
    print OUT "$line\n";
  }

  while ($ref = $sth->fetchrow_hashref(NAME_lc)){
      $line = '';
      $line = qq|<record>\n| if $form->{filetype} eq 'xml';
      for (@column_index) {
	if ($form->{filetype} eq 'xml'){
           $line .= qq|   <$_>$ref->{$_}</$_>\n|;
	} else {
	  if ($column_index{$_}) {
	    $line .= qq|$ref->{$_}$form->{delimiter}|;
	  } else {
	    $line .= qq|"$ref->{$_}"$form->{delimiter}|;
	  }
	}
      }
      if ($form->{filetype} eq 'xml'){
        $line .= qq|</record>|;
      } else {
        chop $line;
      }
      print OUT "$line\n";
  }
  print qq|</database>\n| if $form->{filetype} eq 'xml';
  close(OUT);
}

# End of rentalprofit

