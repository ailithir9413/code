use strict;
use warnings;

use util_routines;

my $dbh = util_routines::connect_to_sqlite('a.dat');

my $sql = qq/select  imagename, bottom_depth, vehicle_depth, timestamp, cruise_id from metadata where bottom_depth = '28.1' order by imagename/;

my $sth = $dbh->prepare($sql);

$sth->execute();

my $imagename;
my $bottom_depth;
my $vehicle_depth;
my $speed;
my $cruise_id;
my $timestamp;

# Bind Perl variables to columns:
my $rv = $sth->bind_columns(\$imagename, \$timestamp, \$bottom_depth, \$vehicle_depth, \$cruise_id);
 
my $c = 1;
my @names = ();

while ($sth->fetch) {
	
    print "$c $imagename\t$vehicle_depth\t$bottom_depth\t$timestamp\n";
	$c++;
	push @names, $imagename;
}

$dbh->disconnect();

exit;
