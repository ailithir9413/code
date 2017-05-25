use IO::Prompt 'prompt';
my $resp = prompt("Foo? ", -yn);

use Term::ReadLine;
my $term = Term::ReadLine->new;
my $line = $term->readline("Bar? ");