#!/usr/bin/env perl

my $s = "1,2,25-27,4,8,14,7-10";
my $s = "0-31";
my %seen;
my @arr =
  sort { $a <=> $b }
  grep { !$seen{$_}++ }
  map { 
    my @r = split /-/; 
    @r>1 ? ($r[0] .. $r[1]) : @r;
  }
  split /,/, $s;

print "@arr\n";
