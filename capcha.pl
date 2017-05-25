#!/usr/bin/perl
use strict; use warnings; 
select STDOUT; $| = 1;

  my $session_dir='/home/huck/monks-sessions';  # must exist and be writeable by www userid 
  my $expires='+1m';


  use CGI;

  use CGI::Session;

  my $session; 

  my $cgi = CGI->new;

  my $tssid  = $cgi->param('tssid');

  my $sessiona1=undef; 
  my $sessiona3={Directory=>$session_dir}; 

  unless ($tssid){ 
      new_capcha('');
      } # no tssid 
  else { 
      $session = CGI::Session->load($sessiona1, $tssid, $sessiona3);
      if ( $session->is_expired )    { 
          $session->delete(); 
          $session->flush();
          new_capcha('Try again: took too long');
          } 
      elsif ( $session->is_empty )   { 
          $session->delete(); 
          $session->flush();
          new_capcha('Try Again:Session not found');
          } 
      else { 
          my $oldanswer=$session->param('answer');
          my $useranswer= $cgi->param('useranswer');
          if (uc($oldanswer) ne uc($useranswer)) { 
              $session->delete(); 
              $session->flush();
              new_capcha('Try Again:didnt Match');
              } 
          } 
      } 
# the only way it can get here is if answer is right 
      print $cgi->header(); 
          print <<EndgoodHTML;
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>My Capcha</title></head>
<body>
You won
</body></html>
EndgoodHTML
  CGI::Session->find($sessiona1 ,sub {} ,$sessiona3); # clean expired sessions 

exit; 

sub new_capcha{ 
  my $reason=shift; 
  $session = CGI::Session->new($sessiona1, undef,$sessiona3);
  my @chars = ("A".."Z", "a".."z");
  my $answer;
  $answer .= $chars[rand @chars] for 0..4;
  $session->expires($expires);
  $session->param('answer',$answer);
  $session->flush(); 
  $tssid= $session->id; 
  print "Content-type:text/html\n\n";
  print <<EndHTML;
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>My Capcha</title></head>
<body background="http://www.astrologybythesea.com/images/bg_coastR.jpg">
<!-- <p><u><font size="5" color="#0000FF">My Capcha</font></u></p> -->
<form action="/monks-bin/capcha.pl" method="post">
<table width="100%" border="0">
<center>
<h5>AntiBot Verifiication</H><br />
$reason 
<div>
<font size="2">$answer</font></div>
<!-- Now get users input -->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="text" size="8" maxlength="8" name="useranswer" value="">
<input type="hidden" name="tssid" value="$tssid">
<input type="submit" name="verify" value="Verify"><br />&nbsp;&nbsp;&nbsp;Type the above characters
</h5></center></table></form></body></html>
EndHTML
exit; 
} # newcapcha 