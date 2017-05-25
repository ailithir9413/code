#!/usr/bin/perl -w
#
#  Simple jQuery example to demonstrate:
#
#      CGI (Perl) + HTML + CSS + Javascript/jQuery + Ajax
#
#  2013-08-21 golux
##

###############
## Libraries ##
###############
use strict;
use warnings;
use CGI qw{ :standard };
use CGI::Carp qw{ fatalsToBrowser };


##################
## User-defined ##
##################
my $jquery = "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js";
my $max    = 625;
my $ncols  = 25;


##################
## Main program ##
##################
server_side_ajax();
print_page_header();
print_html_head_section();
print_html_body_section();


#################
## Subroutines ##
#################
sub print_page_header {
    # Print the HTML header (don't forget TWO newlines!)
    print "Content-type:  text/html\n\n";
}


sub print_html_head_section {
    # Include stylesheet 'pm.css', jQuery library,
    # and javascript 'pm.js' in the <head> of the HTML.
    ##
    print "<head>\n";
    print "<link rel='stylesheet' type='text/css' href='pm.css'>\n";
    print "<script src='$jquery'  type='text/javascript'></script>\n";
    print "<script src='pm.js'    type='text/javascript'></script>\n";
    print "</head>\n";
}


sub print_html_body_section {
    # Create HTML body and show values from 1 - $max ($ncols per row)
    print "<body>\n";
    print "<center>\n";
    print "<h1>Click any number to see its factors</h1>\n";
    print qq{
        <input type="button" value="Server info" onclick="ajax_info()">
        <span id="info"></span><hr>
    };

    print qq{<div id="result"></div><br>\n};
    print "<table width='50%'>";
    for (my $i = 0; $i < $max; $i++) {
        (0 == $i % $ncols) and print "<tr>\n";
        my $num = $i + 1;
        my $onclick = qq{onclick="show_factors($num)"};
        print qq{<td id="N$num" class="normal data" $onclick>$num\n};
    }
    print "</table>";
    print "</center>\n";
    print "</body>\n";
}


sub server_side_ajax {
    my $mode = param('mode') || "";
    ($mode eq 'info') or return;

    # If we get here, it's because we were called with 'mode=info'
    # in the HTML request (via the ajax function 'ajax_info()').
    ##
    print "Content-type:  text/html\n\n";  # Never forget the header!
    my $ltime = localtime();
    print "Server local time is $ltime";
    exit;
}