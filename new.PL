
use strict;

my @a;
my $last = 0;

while( <DATA> ) {
    m[(^[^A-Z]+)?([A-Z]+)] or next;
    my $l = length( $1//'' );
    if( @a and $l <= $last ) {
        print join "\t", @a;
        pop @a for 1 .. ($last-$l+3)/3;
    }
    push @a, $2;
    $last = $l;
}
print join "\t", @a;


__DATA__
A
|
|--B
|  |
|  |--C
|     |
|     |---PQR
|     |---XYZ
|--D
|  |
|  |---LMN
|---XYZ