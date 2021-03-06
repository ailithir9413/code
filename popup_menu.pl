
#
#  PROGRAM:	popup_menu.cgi
#
#  PURPOSE:	Demonstrate (1) how to create a popup_menu form and
#		(2) how to determine the value selected by the user.
#
#  Created by alvin alexander, devdaily.com.
#

#-----------------------------------#
#  1. Create a new Perl CGI object  #
#-----------------------------------#

use CGI;
$query = new CGI;

#----------------------------------#
#  2. Print the doctype statement  #
#----------------------------------#

print $query->header;


#----------------------------------------------------#
#  3. Start the HTML doc, and give the page a title  #

print $query->start_html('My popup_menu.cgi program');

my @arr = qw(pasta hamburger salad pierogi chicken_cutlet);
if (!$query->param) {
	print $query->start_form;
	print $query->h4('Select a dinner entree:');
	print $query->popup_menu(-name=>'entrees',
				 -values=>[@arr],
				 -default=>'Veggies');
}

my @arr = qw(cheese_cake cannoli apple_pie);
if (!$query->param) {

	print $query->start_form;
	print $query->h3('Select a desert entree:');
	print $query->popup_menu(-name=>'deserts',
				 -values=>[@arr],
				 -default=>'Veggies');
}
print $query->end_form;

print $query->end_html;