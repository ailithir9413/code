# CREATE TABLEs for HABCAM May 10 2017 Barry McClintock


use strict;
use warnings;

use DBI;
use util_routines;

my $table = 'TESTDB';

# my $dbh = util_routines::connect_to_oracle();

my $dbfile = "b.dat";
my $dbh = util_routines::connect_to_sqlite($dbfile);

create_my_blob();
create_scopes();
create_geometry_columns();
create_web_service_image_metadata();
create_facets();
create_metadata();
create_idmodes();
create_annotations();
create_assignments();
create_classes();
create_geometry_columns();
#create_auth();				perhaps no longer using??
# create_coordinates();  	no specs 5-10-17
create_geography_columns();
create_imagelist();
create_spatial_ref_sys();

$dbh->disconnect();

exit();
			
# -----------------------------------------------------------------
sub create_my_blob {
	$dbh->do('DROP TABLE images');
	my $sql = qq/CREATE TABLE images (image blob not null)/;
	$dbh->do($sql) or die "\n\n$DBI::errstr";
	print "Created images \n";

	$sql = qq/DROP INDEX imagename_idx/;
	$dbh->do($sql) or die "$DBI::errstr";
	
	$sql = qq/CREATE INDEX imagename_idx ON images (image)/;
	$dbh->do($sql) or die "$DBI::errstr";
	print "\tCreated imagename_idx\n";
	return;
}

# -----------------------------------------------------------------
sub create_web_service_image_metadata {
	$dbh->do('DROP TABLE web_service_image_metadata');
	my $sql = qq/CREATE TABLE web_service_image_metadata (
		imagename			text not null,
		cruise_id			number,
		fov					text,
		lat					text,
		lon					text,
		alt					number,
		bottom_depth		number,
		vehicle_depth		number,
		camera				text,
		mm_pix				number,
		pitch				number,
		roll				number,
		heading				number,
		salinity			number,
		speed				number,
		temperature			number,
		turbidity			number,
		flourescence		number,
		cdom				number,
		thegeom				number,
		PRIMARY KEY (imagename)
		) /;
	
	$dbh->do($sql) or die "\n\n$DBI::errstr";
	print "Created web_service_image_metadata\n";
	return;
}

# -----------------------------------------------------------------
sub create_geometry_columns {
	$dbh->do('DROP TABLE geometry_columns');
	my $sql = qq/CREATE TABLE geometry_columns (
		f_table_catalog		text,
		f_table_schema		text,
		f_table_name		text,
		f_geometry_column	text,
		coord_dimension		text,
		sird				number,
		type				number		
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created geometry_columnst\n";
	return;
}

# -----------------------------------------------------------------
sub create_scopes {
	$dbh->do('DROP TABLE scopes');
	my $sql = qq/CREATE TABLE scopes (
		scope_id	number,
		scope_name	text,
		deprecated	boolean
		) /;
		
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created scopes\n";	
	return;
}

# -----------------------------------------------------------------
sub create_imagelist {
	$dbh->do('DROP TABLE imagelist');	
	my $sql = qq/CREATE TABLE imagelist (
		assignment_id	integer,
		imagename		text,
		status			number,
		offset			number,
		imagelist_id	number,
		PRIMARY KEY (assignment_id)
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created imagelist\n";
	return;
}

# -----------------------------------------------------------------
sub create_idmodes {
	$dbh->do('DROP TABLE idmodes');
	my $sql = qq/CREATE TABLE idmodes(
		idmode_id	number,
		idmode_name	text,
		class_id	number,	
		deprecated	boolean
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created idmodes\n";
	return;
}

# -----------------------------------------------------------------
sub create_classes {
	$dbh->do('DROP TABLE classes');
	my $sql = qq/CREATE TABLE classes (
		class_id	number,
		class_name	text,
		old_idcode	number,
		facet_id	number,		
		deprecated	boolean
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created classes\n";
	return;
}

# -----------------------------------------------------------------
sub create_assignments {
	$dbh->do('DROP TABLE assignments');
	my $sql = qq/CREATE TABLE assignments (
		assignment_id		number,
		idmode_id			number,
		site_description	text,
		project_name		text,
		priority			number,
		initials			text,
		idmodeid			number,
		added_timestamp		timestamp,
		num_images			number,
		comment				text,
		status				text,
		tracknum			number,
		startimage			text,
		stopimage			text,
		subsample			text,
		date				date,
		time				time,
		PRIMARY KEY (assignment_id)
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created assignments\n";
	return;
}

# -----------------------------------------------------------------
sub create_facets {
	$dbh->do('DROP TABLE facets');
	my $sql = qq/CREATE TABLE facets (
		facet_id	number,
		facet_name	text,
		scope_id	number,	
		deprecated	boolean
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	print "Created facets\n";
	return;
}

# ----------------------------------------------------------------
sub create_metadata {
	$dbh->do('DROP TABLE metadata');
    my $sql = qq/CREATE TABLE metadata (
		imagename  		varchar2(32) not null,
		lat        		number(20) , 
		lon        		number(20) , 
		head       		number(20) , 
		roll       		number(20) , 
		pitch      		number(20)l , 
		alt1       		number(20) , 
		alt2       		number(20) , 
		sonar_alt  		number(20) , 
		bot_alt    		number(20) , 
		alt_smo    		number(20) , 
		t          		number(20) , 
		p          		number(20) , 
		s          		number(20) , 
		bottom_depth	number(20) , 
		t2         		number(20) , 
		p2         		number(20) , 
		o2         		number(20) , 
		s2         		number(20) , 
		backscatter		number(20) , 
		chlorophyll		number(20) , 
		cdom       		varchar2(20)		 , 
		thegeom    		varchar2(20) 	 ,
		camera     		varchar2(20),
		fov_v2     		number(20) , 
		fov_v4     		number(20) , 
		mm_px_v2   		number(20) , 
		mm_px_v4   		number(20) , 
		cruise_id  		varchar2(20) 	 ,     
		timestamp  		varchar2(20)	 , 
		fov        		number(20) , 
		mm_px      		number(20) , 
		alt        		number(20) , 
		speed      		number(20) , 
		depth      		number(20) , 
		vehicle_depth	number(20) , 
		therm      		number(20)	,
		internal_ph		number(20) ,
		external_ph		number(20) , 
		ss				number(20),
		PRIMARY KEY (imagename)
		) /;

	$dbh->do($sql) or die "$DBI::errstr";
	
	$sql = qq/DROP INDEX imagename_idx/;
	$dbh->do($sql) or die "$DBI::errstr";
	
	$sql = qq/CREATE INDEX imagename_idx ON metadata (imagename)/;
	$dbh->do($sql) or die "$DBI::errstr";
	
	print "created metadata\n";
	print "\tcreated index imagename_idx\n";
	return;	
}

# ----------------------------------------------------------------
sub create_spatial_ref_sys {
	$dbh->do('DROP TABLE spatial_ref_sys');
	my $sql = qq/CREATE TABLE spatial_ref_sys (
		srid				number,
		auth_name			text,
		auth_srid			number,
		srtext				text,
		proj4text			text
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	return;
}

# ---------------------------------------------------------------
sub create_annotations {
	$dbh->do('DROP TABLE annotations');
	my $sql = qq/CREATE TABLE annotations (
		idmode_id			number
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	return;
}

# ---------------------------------------------------------------
sub create_geography_columns {
	$dbh->do('DROP TABLE geography_columns');
	my $sql = qq/CREATE TABLE geography_columns (
		idmode_id			number
		) /;
	
	$dbh->do($sql) or die "$DBI::errstr";
	return;
}
__END__





