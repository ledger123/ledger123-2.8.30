
1;

# CUSTOMER / VENDORS AUTO COMPLETE

sub vc_autocomplete {
  print q|
<script>
$(function() {
   $("#vc").autocomplete({
	source: "js.pl?action=vc_data&|.qq|db=$form->{db}&vc=$form->{vc}&path=$form->{path}&login=$form->{login}|.q|",
	minLength: 2,
	select: function(event, ui) {
	   $('#vc_id').val(ui.item.id);
	   $('#vcnumber').val(ui.item.vcnumber);
	}
   });
});
</script>
|;

}


sub vc_data {
   # TODO: Add condition for start/end date

   my $term = $form->like(lc $form->{term});
   my $query;
   $form->{db} = $form->{vc} if $form->{vc};
   if ($form->{db}){
      $query = "SELECT id, name, $form->{db}number AS number FROM $form->{db} WHERE lower(name) LIKE ? ORDER BY 1";
   } else {
      $query = qq|
	SELECT id, name, customernumber AS number FROM customer WHERE lower(name) LIKE ?
	UNION ALL 
	SELECT id, name, vendornumber AS number FROM vendor WHERE lower(name) LIKE ?
	ORDER BY 1
      |;
   }
   my $data = qq|Content-Type: text/html\n\n
   [|;
   if ($form->{db}){
      for my $ref ($form->{dbs}->query($query, $term)->hashes){
         $data .= qq|{ "id": "$ref->{id}", "value": "$ref->{name}", "vcnumber": "$ref->{number}" },|;
      }
   } else {
      for my $ref ($form->{dbs}->query($query, $term, $term)->hashes){
         $data .= qq|{ "id": "$ref->{id}", "value": "$ref->{name}", "vcnumber": "$ref->{number}" },|;
      }
   }
   chop $data;
   $data .= ']';
   print $data;
}



# GL ACCOUNTS AUTO COMPLETE

sub gl_autocomplete {
  print q|
<script>
$(function() {
   $('#accno').val("");
   $("#acc_description").autocomplete({
	   source: "js.pl?action=gl_data&|.qq|path=$form->{path}&login=$form->{login}|.q|",
	   minLength: 2,
	   select: function(event, ui) {
	      $('#chart_id').val(ui.item.id);
	      $('#accno').val(ui.item.accno);
	   }
   });
});
</script>
|;

}

sub gl_data {
   my $term = $form->like(lc $form->{term});
   my $query = "SELECT id, accno, description FROM chart WHERE charttype = 'A' AND lower(description) LIKE ? ORDER BY description";
   my $data = qq|Content-Type: text/html\n\n
   [|;
   for my $ref ($form->{dbs}->query($query, $term)){
      $data .= qq|{ "id": "$ref->{id}", "value": "$ref->{description}", "accno": "$ref->{accno}" },|;
   }
   chop $data;
   $data .= ']';
   print $data;
}


# PARTSGROUP AUTO COMPLETE
sub pg_autocomplete {
  print q|
<script>
$(function() {
   $('#partsgroupcode').val("");
   $("#partsgroup").autocomplete({
	   source: "js.pl?action=pg_data&|.qq|path=$form->{path}&login=$form->{login}|.q|",
	   minLength: 1,
	   select: function(event, ui) {
	      $('#partsgroupcode').val(ui.item.id);
	      $('#partsgroup').val(ui.item.partsgroup);
	   }
   });
});
</script>
|;

}

sub pg_data {
   my $term = $form->like(lc $form->{term});
   my $query = "SELECT code, partsgroup FROM partsgroup WHERE lower(partsgroup) like ? ORDER BY partsgroup";
   my $data = qq|Content-Type: text/html\n\n
   [|;
   for my $ref ($form->{dbs}->query($query, $term)->hashes){
      $data .= qq|{ "id": "$ref->{code}", "value": "$ref->{partsgroup}", "partsgroup": "$ref->{partsgroup}" },|;
   }
   chop $data;
   $data .= ']';
   print $data;
}


# PARTS NUMBER AND DESCRIPTION AUTO COMPLETE

sub partnumber_partdescription_autocomplete {
  print q|
<script>
$(function() {
    $("#partdescription").autocomplete({
	source: "js.pl?action=partdescription_data&|.qq|path=$form->{path}&login=$form->{login}|.q|",
        minLength: 2,
        select: function(event, ui) {
            $('#parts_id').val(ui.item.id);
            $('#partnumber').val(ui.item.partnumber);
        }
    });
});

$(function() {
    $("#partnumber").autocomplete({
    	source: "js.pl?action=partnumber_data&|.qq|path=$form->{path}&login=$form->{login}|.q|",
	minLength: 2,
	select: function(event, ui) {
                    $('#parts_id').val(ui.item.id);
                    $('#partdescription').val(ui.item.partdescription);
       }
    });
});

</script>
|;

}

sub partnumber_data {
   my $term = $form->like(lc $form->{term});

   #TODO Filter obsolete parts
   my $query = "SELECT id, partnumber, description 
		FROM parts 
		WHERE lower(partnumber) LIKE ?
		ORDER BY partnumber";
   my $data = qq|Content-Type: text/html\n\n
   [|;
   for my $ref ($form->{dbs}->query($query, $term)->hashes){
      $data .= qq|{ "id": "$ref->{id}", "value": "$ref->{partnumber}", "partdescription": "$ref->{description}" },|;
   }
   chop $data;
   $data .= ']';
   print $data;
}

sub partdescription_data {
   my $term = $form->like(lc $form->{term});
   #TODO Filter obsolete parts
   my $query = "SELECT id, partnumber, description 
		FROM parts 
		WHERE lower(description) LIKE ?
		ORDER BY description";
   my $data = qq|Content-Type: text/html\n\n
   [|;
   for my $ref ($form->{dbs}->query($query, $term)->hashes){
      $data .= qq|{ "id": "$ref->{id}", "value": "$ref->{description}", "partnumber": "$ref->{partnumber}" },|;
   }
   chop $data;
   $data .= ']';
   print $data;
}

# EOF

