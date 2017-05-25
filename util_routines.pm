	# Barry McClintock 3 May 2017

use strict;
use warnings;

package util_routines;

use DBI;

# -----------------------------------------------------------------
sub connect_to_oracle {
    my $driver   = "oracle";
    my $database = "heron";
    my $dsn      = "DBI:$driver:database=$database;sid=sh;port=1526";
    my $userid   = "bmcclint";
    my $password = "6720685_mag";
 
	my $dbh = DBI->connect("dbi:Oracle:host=heron;sid=sh;port=1526, $userid, $password");
 
    #my $dbh = DBI->connect( $dsn, $userid, $password ) or die $DBI::errstr;
	
	print "**** connected to Oracle/$database ****\n";
    return $dbh;
}

# -----------------------------------------------------------------
sub connect_to_sqlite {
	my $dbfile = shift;
	my $dbh = DBI->connect("dbi:SQLite:dbname=$dbfile","","") or die $DBI::errstr;
	
	print "**** connected to SQLite/$dbfile ****\n";
	return $dbh;
}

# -----------------------------------------------------------------
sub load_imagelist {
	my ($dbh, $image_name, $imagelist_id)	= @_;
	my $table				= 'imagelist';
	my $assignment_id		= 0;
	my $status				= 0;
	my $offset				= 0;
	
	my $sql = qq/INSERT INTO $table VALUES ('$image_name', '$assignment_id', 
					'$status', '$offset', '$imagelist_id' ) /;
	my $sth = $dbh->prepare($sql) or die "prepare: $sql: $DBI::errstr";
	$sth->execute() or die "execute: $sql: $DBI::errstr";
	
	print "$image_name and $imagelist_id inserted into imagelist table\n";
	
	return;
}

	
# -----------------------------------------------------------------
# -----------------------------------------------------------------
# -----------------------------------------------------------------
# -----------------------------------------------------------------	





1;
