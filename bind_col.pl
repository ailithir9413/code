
use DBI;


my $dbfile = "a.dat";
my $dbh = DBI->connect("dbi:SQLite:dbname=$dbfile","","");



__DATA__

$dbh->{RaiseError} = 1; # do this, or check every call for errors
$sth = $dbh->prepare(q{ SELECT region, sales FROM sales_by_region });
$sth->execute;
my ($region, $sales);
 
# Bind Perl variables to columns:
$rv = $sth->bind_columns(\$region, \$sales);
 
# you can also use Perl's \(...) syntax (see perlref docs):
#     $sth->bind_columns(\($region, $sales));
 
# Column binding is the most efficient way to fetch data
while ($sth->fetch) {
    print "$region: $sales\n";
}