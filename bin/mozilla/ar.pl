#=====================================================================
# SQL-Ledger ERP
# Copyright (c) 2006
#
#  Author: DWS Systems Inc.
#     Web: http://www.sql-ledger.com
#
#======================================================================
#
# Accounts Receivable
#
#======================================================================

# bp 2015/05 utf8 mode
use feature 'unicode_strings';

use SL::PE;
use SL::IS;

require "$form->{path}/arap.pl";
require "$form->{path}/arapprn.pl";
require "$form->{path}/aa.pl";

$form->{vc} = 'customer';
$form->{ARAP} = 'AR';

1;
# end of main

