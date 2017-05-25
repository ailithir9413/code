use CGI qw(:standard);

$regfile = '../public_html/perl/registrations.tsv';

print header;

if(param()) {
    $name = param('name');
    $email = param('email');
    $food = param('food');
    if(ok()) {
    open(REG,">>$regfile") or fail();
    print REG "$name\t$email\t$food\n";
    close(REG);
    print <<END;
<title>Thank you!</title>
<h1>Thank you!</h1>
<p>Your fake registration to Virtual Nonsense Party
has been recorded as follows:</p>
<p>Name: $name</p>
<p>E-mail: $email</p>
<p>Food preference: $food</p>
END
    exit; } }

%labels = (
  '' => 'Food preference (select one):',
  'Fish sticks' => 'Fish sticks',
  'Falafel' => 'Falafel',
  'no food' => 'None (i.e., will not eat)' );

print start_form, 'Fake registration to virtual party',br,
  'Name: ', textfield('name'), br,
  'E-mail: ', textfield('email'), br,
  radio_group(-name=>'food', -values=>\%labels, -linebreak=>'true',
              -default=>''),
  submit, end_form;

sub fail {
   print "<title>Error</title>",
   "<p>Error: cannot record your registration!</p>";
   exit; }

sub ok() {
    $fine = 1;
    if(!$name) { print 'Your name is required!', br; $fine = 0; }
    if(!$email) { print 'Your E-mail address is required!', br; $fine = 0; }
    elsif(!($email =~ m/\@/))
       { print 'An E-mail address must contain the @ character!', br;
         $fine = 0; }
    if(!$food) { print 'A food preference (even if none) is required!',
       br; $fine = 0; }
    if(!$fine) { print 'Please fix the data and resubmit', hr; }
    return $fine; }