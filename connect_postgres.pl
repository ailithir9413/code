# Apr 4 2017
# Barry McClintock

use strict;
use warnings;
use DBI;

my $dbname 	= 'habcam';  
my $host 		= '.69.38';  
my $port 		= 10221;  
my $username 	= '';  
my $password 	= '';  



my $dbh = DBI->connect("dbi:Pg:dbname=habcam;host=$host;port=$port",
		$username,
		$password,
			{	AutoCommit=>0,
				RaiseError=>1,
				PrintError=>0
			});
print "2+2=",$dbh->selectrow_array("SELECT 2+2"),"\n";






my $sql = qq(SELECT * from $dbname);

my $sth = $dbh->prepare($sql);  

$sth->execute();

my @row = $sth->fetchrow_array();

print "$row[0]\t$row[1]\t$row[2]\n";

# while (my @row = $sth->fetchrow_array) {  
#   print "$row[0]\t$row[1]\t$row[2]\n";
# }

$sth->finish()
