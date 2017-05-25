# load tables May 9 2017 Barry McClntock

use strict;
use warnings;

require util_routines;

my $counter = 0;
my ($sql, $sth);

my $dbfile	= "b.dat";
my $dbh 	= util_routines::connect_to_sqlite($dbfile);
# my $dbh 	= util_routines::connect_to_oracle($table);

my $data_dir = "c:\\users\\barry.mcclintock\\work\\data\\";

load_scopes();
load_idmodes();
load_facets();
load_assignments();
load_image_metadata(); 

# -----------------------------------------------------------------
sub load_scopes {
	my $table = 'scopes';
	print "loading $table\n";
	my $file = $data_dir . "scopes.csv";
	my $counter = 0;
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	
	while(<$FH>) {
		chomp;
		my ($scope_id, $scope_name, $deprecated) = split(',' => $_);
		$counter++;
		$scope_name ="'$scope_name'";
		
		my $sql = qq/INSERT INTO $table VALUES ($scope_id, $scope_name, $deprecated) /;
		my $sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		
		}
	print "loaded $counter records into $table\n";
	close($FH);
	return;
}

# -----------------------------------------------------------------
sub load_idmodes {
	my $table = 'idmodes';
	print "loading $table\n";
	my $file = $data_dir . "idmodes.csv";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	
	while(<$FH>) {
		chomp;
		my ($idmode_id, $idmode_name, $class_id, $deprecated) = split(',' => $_);
		
		$idmode_name = "'$idmode_name'";
		
		$sql = qq/INSERT INTO $table VALUES ($idmode_id, $idmode_name, $class_id, $deprecated) /;
		$sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		
		}
	close($FH);
	return;
}

# -----------------------------------------------------------------
sub load_image_metadata {
	my $table = 'metadata';
	print "loading $table\n";
	my $file = $data_dir . "image_metadata.csv";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	
	my $count = 0;
	
	while(<$FH>) {
		chomp;
		
		s/undef/' '/g;
		
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
							

			# print "$_\n";
			
			print "$count \n" if ($count++ %100 == 0);
							
			$imagename 	= "'$imagename'";
			$timestamp 	= "'$timestamp'";
			$camera		= "'$camera'";				
							
			$sql = qq/ INSERT INTO $table VALUES (
						$imagename,
						$lat, 
						$lon, 
						$head,
						$roll, 
						$pitch, 
						$alt1, 
						$alt2, 
						$sonar_alt, 
						$bot_alt, 
						$alt_smo, 
						$t, 
						$p, 
						$s, 
						$bottom_depth, 
						$t2, 
						$p2, 
						$o2, 
						$s2, 
						$backscatter, 
						$chlorophyll, 
						$cdom, 
						$thegeom,
						$camera,
						$fov_v2, 
						$fov_v4, 
						$mm_px_v2, 
						$mm_px_v4, 
						$cruise_id, 
						$timestamp, 
						$fov, 
						$mm_px, 
						$alt, 
						$speed, 
						$depth, 
						$vehicle_depth, 
						$therm,
						$internal_ph,
						$external_ph, 
						$ss) /;
					
		$sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		}	
	close($FH);
	return;
	}

# -----------------------------------------------------------------
sub load_facets {
	my $table = 'facets';
	my $file = $data_dir . "facets.csv";
	print "loading $table\n";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	
	while(<$FH>) {
		chomp;
		
		s/undef/' '/g;
		
		my ($facet_id, $facet_name, $scope_id, $deprecated )= split(',' => $_);
		
		$sql = qq/INSERT INTO $table VALUES ($facet_id, '$facet_name', $scope_id, $deprecated) /;
		$sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		}	
	close($FH);
	return;
}

# -----------------------------------------------------------------
sub load_assignments {

	return;

	my $file = $data_dir . "assignments.csv";
	open(my $FH,'<',$file) or die "can't open $file...$!\n";
	my $table = 'assignments';
	while(<$FH>) {
		chomp;
		
		s/undef/' '/g;
		
		my (
		$assignment_id,
		$idmode_id,
		$site_description,	
		$project_name,
		$priority,
		$initials,
		$idmodeid,
		$added_timestamp,
		$num_images,
		$comment,
		$status,
		$tracknum,
		$startimage,
		$stopimage,
		$subsample,
		$date, $time) = split(',' => $_);

		
		$sql = qq(INSERT INTO $table VALUES (
						'$assignment_id',
						'$idmode_id',
						'$site_description',	
						'$project_name',
						'$priority',
						'$initials',
						'$idmodeid',
						'$added_timestamp',
						'$num_images',
						'$comment',
						'$status',
						'$tracknum',
						'$startimage',
						'$stopimage',
						'$subsample',
						'$date',
						'$time') );
		$sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
		$sth->execute() or die "execute: $sql: $DBI::errstr";
		}
		close($FH);
		return;
}

# -----------------------------------------------------------------

__END__
											