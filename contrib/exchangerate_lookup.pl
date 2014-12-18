#!/usr/bin/perl -w
#=================================================================
# SQL-Ledger ERP
# Copyright (C) 2014
#
#  Author: First Choice Internet Ltd, Tokyo
#
#======================================================================
#use strict;
use Finance::Quote;

1;

# Retrieve the current exchange rate for 2 currencies.
# Use international 3 character currency symbols, the foreign currency comes first
# Example usage:   currency-lookup.pl USD AUD
# (Converts from US Dollars to Australian Dollars)
#
# The result is rounded by the variable $places; defaults to 2

sub get_exchange_rate {
  my ($tcurr, $hcurr, $places) = @_;

  $places = 2 if ! ( $places );

  my $q = Finance::Quote->new();
  my $newrate = $q->currency($tcurr,$hcurr);

  return int(($newrate * (10**$places)) + ($neg * 0.5)) / (10**$places);
}


# enable these 2 lines for testing
#my $rate = get_exchange_rate("USD","JPY");
#print("Result: $rate \n");
