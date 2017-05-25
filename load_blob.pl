

# 5-15-2017 copy jpb to/from a database Barry McClintock

use strict;
use warnings;
use util_routines;
use DBI;

my $file_name		= "blob.jpg";
my $file_dir		= "c:\\users\\barry.mcclintock\\work\\";
my $my_picture_file = "$file_dir$file_name";
my $dbname = "a.dat";

my $dbh = util_routines::connect_to_sqlite($dbname);

create_my_blob();

open (my $MYFILE,'<', $my_picture_file)  or die "Cannot open file....$!";
my $data;
{
	local $/;
	binmode $MYFILE;
	$data = <$MYFILE>;
	close $MYFILE;
}
$data =~ s/^\s+//g;
$data =~ s/\s+$//g;

# -----------------------------------------------------------------
# insert image into table
# -----------------------------------------------------------------
my $sql = "INSERT INTO my_blob VALUES (?,?,?)";
my $sth = $dbh->prepare($sql) or die; 
$sth->execute(1, $file_name, $data) or die;

# -----------------------------------------------------------------
# insert into  imto image_list table
# -----------------------------------------------------------------
util_routines::load_imagelist( $dbh, $file_name, 1);

# -----------------------------------------------------------------
# retrieve image from table
# -----------------------------------------------------------------
$sql = "SELECT image FROM my_blob WHERE image_name = '$file_name'";
$sth = $dbh->prepare($sql) or die;
$sth->execute() or die;

my $ref = $sth->fetchrow_hashref;
my $newdata = $$ref{'image'};

$newdata =~ s/^\s+//g;
$newdata =~ s/\s+$//g;

open (my $OUTPUT, '>', "output_blob.jpg") or die "$!\n";
binmode $OUTPUT;	
print $OUTPUT $newdata;
close $OUTPUT;

$sth->finish;
$dbh->disconnect;
exit;

# ------------------------------------------------------------------
sub create_my_blob {
	$dbh->do('drop table my_blob');
	my $sql = qq/create table my_blob (
				idmode_id	numbeer,
				image_name	text,
				image 		blob
				)/;
	$dbh->do($sql) or die "\n\n$DBI::errstr";
	print "Created my_blob\n";
	return;
}
__END__