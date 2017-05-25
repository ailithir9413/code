use strict;
use warnings;


my @x = ( -7, -5, -2, 2, 3, 8, 10 );

@x = sort {$a <=> $b} @x;

my %y = map { $_ => 1 } @x;

print "missing: $_\n" for grep { not exists $y{ $_ } } ( $x[0] .. $x[-1] );