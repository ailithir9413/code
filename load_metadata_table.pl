# load metatdata table May 3 2017 Barry McClntock

use strict;
use warnings;

require util_routines;

my ($sql, $sth, $dbh) = q{};
my $counter = 0;

# my $dbh = util_routines::connect_to_oracle($table);

load_image_metadata();


exit;



sub load_image_metadata {
	my $table = 'imagemetadata_1';
	my $file = "c:\\users\\barry.mcclintock\\work\\data\\image_metadata.csv";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	
	while(<$FH>) {
		chomp;
		my (
			$imagename,
			$lat, 
			$lon        , 
			$head       , 
			$roll       , 
			$pitch      , 
			$alt1       , 
			$alt2       , 
			$sonar_alt  , 
			$bot_alt    , 
			$alt_smo    , 
			$t          , 
			$p          , 
			$s          , 
			$bottom_depth, 
			$t2         , 
			$p2         , 
			$o2         , 
			$s2         , 
			$backscatter, 
			$chlorophyll, 
			$cdom       , 
			$thegeom    ,
			$camera     ,
			$fov_v2     , 
			$fov_v4     , 
			$mm_px_v2   , 
			$mm_px_v4   , 
			$cruise_id  ,     
			$timestamp  , 
			$fov        , 
			$mm_px      , 
			$alt        , 
			$speed      , 
			$depth      , 
			$vehicle_depth, 
			$therm,
			$internal_ph,
			$external_ph, 
			$ss)  = split(',' => $_);
		
		$counter++;
		print "$counter: $imagename\t$timestamp\t$bottom_depth\n";
		
	
		$sql = qq{INSERT INTO $table VALUES (
			$imagename,
			$lat		, 
			$lon        , 
			$head       , 
			$roll       , 
			$pitch      , 
			$alt1       , 
			$alt2       , 
			$sonar_alt  , 
			$bot_alt    , 
			$alt_smo    , 
			$t          , 
			$p          , 
			$s          , 
			$bottom_depth, 
			$t2         , 
			$p2         , 
			$o2         , 
			$s2         , 
			$backscatter, 
			$chlorophyll, 
			$cdom       , 
			$thegeom    ,
			$camera     ,
			$fov_v2     , 
			$fov_v4     , 
			$mm_px_v2   , 
			$mm_px_v4   , 
			$cruise_id  ,     
			$timestamp  , 
			$fov        , 
			$mm_px      , 
			$alt        , 
			$speed      , 
			$depth      , 
			$vehicle_depth, 
			$therm,
			$internal_ph,
			$external_ph, 
			$ss};
			
		$sth = $$dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		}	
	close($FH);
	}

sub load_facets {
	my $file = "c:\\users\\barry.mcclintock\\work\\data\\facets.csv";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	my $table = 'facets_1';
	while(<$FH>) {
		chomp;
		my ($facet_id, $facet_name, $scope_id, $deprecated )= split(',' => $_);
		$sql = qq{INSERT INTO $table VALUES ($facet_id, $facet_name, $scope_id, $deprecated};
		$sth = $$dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		}	
	close($FH);
}
												
												
											