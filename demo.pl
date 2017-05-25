use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin;
 
use construct_options; 

my @lookup_array = qw(assignment biotic bottom_type sediment);

my @options = ();
my $counter	= 0;
for(@lookup_array) {
	$options[$counter++] = construct_options::get_options($_);
	}

my $image = 'brendan.jpg';																						
my $bottom_message = "--$image-- Brendan at Sussex";
 

# HERE document which constructs the HTML
my $message = <<"END_MESSAGE";
<!DOCTYPE html>

<html>
<head>
<title>Annotator Tool</title>

<style type="text/css">
.dropbtn {
    background-color: white;
    color: #4CAF50;
	color: whitr
    padding: 8px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown_0{
    position: absolute;
    top: 10px;
    right: 40px;
    display: inline-block;
}

.dropdown_1{
    position: absolute;
    top: 35px;
    right: 40px;
    display: inline-block;
}

.dropdown_2{
    position: absolute;
    top: 60px;
    right: 40px;
    display: inline-block;
}
.dropdown_3{
    position: absolute;
    top: 85px;
    right: 40px;
    display: inline-block;
}

.dropdown_4{
    position: absolute;
    top: 110px;
    right: 40px;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: white}

.dropdown_0:hover .dropdown-content {
    display: block;
}
.dropdown_0:hover .dropbtn {
    background-color: white;
}

.dropdown_1:hover .dropdown-content {
    display: block;
}
.dropdown_1:hover .dropbtn {
    background-color: white;
}

.dropdown_2:hover .dropdown-content {
    display: block;
}
.dropdown_2:hover .dropbtn {
    background-color: white;
}

.dropdown_3:hover .dropdown-content {
    display: block;
}
.dropdown_3:hover .dropbtn {
    background-color: white;
}

.dropdown_4:hover .dropdown-content {
    display: block;
}
.dropdown_4:hover .dropbtn {
    background-color: white;
}

#bottom {
	position: fixed;
	bottom:  0;
	left: 0;
	width: 100%;
	text-align: center;
	padding:  5px;
	border-top: 3px solid blue;
	background-color: #cccccc;
	padding-bottom: 2em;
	}
	
.tb5 {
	position: absolute;
	color: #4CAF50;
    top: 110px;
	font-size: 14pt;
	right: 40px;
    display: inline-block;
	height: 197px
	border-color: 3px #4CAF50;
	}
	
input[type=submit] {
	 position: absolute;
    top: 700px;
    right: 20px;
    border: 1px solid #f44c0e;
    color: #fff;
    background: tomato;
    padding: 10px 20px;
    border-radius: 3px;
}
input[type=submit]:hover {
    background: #f44c0e;
}

</style>
</head>

<body>

<IMG SRC="$image" WIDTH=1000 HEIGHT=1000>



<div class="dropdown_0">
	<button class="dropbtn" type="button">Assignment</button>
	<div class="dropdown-content">
	<FORM ACTION = "a.pl" METHOD = "get">
	<select name="assignment" >
		$options[0]
		<option selected="selected" value="cruise">Cruise 1</option>
	</select>
</div>
</div>

<div class="dropdown_1">
  <button class="dropbtn" type="button">Biotic</button>
  <div class="dropdown-content">
<select name="Biotic" >
	<!-- constructed options -->
	$options[1]
	<option selected="selected" value="Big_Fish!">BIG FISH!</option>
</select>
</div>
</div>

<div class="dropdown_2">
  <button class="dropbtn" type="button">Bottom Type</button>
  <div class="dropdown-content">
<select name="bottom_type" >
	<!-- constructed options -->
	$options[2]
	<option selected="selected" value="Sand">Sand</option>
</select>
</div>
</div>
 

<div class="dropdown_3">
  <button class="dropbtn" type="button">Sediment</button>
  <div class="dropdown-content">
<select name="sediment" >
	<!-- constructed options -->
	$options[3]
	<option selected="selected" value="None">None</option>
</select>
</div>
</div>

<div class="tb5">
	Notes: 
	<input type="text" name="image_notes" value=""/>
</div>

<input type="submit" value="Submit"/>

</form>


<div id="bottom">
<strong>$bottom_message</strong>
</div>

</body>
</html>
END_MESSAGE

print $message;

__DATA__

<!-- <FORM ACTION = "a.pl" METHOD = "get">
	Enter Your Name:
     <INPUT TYPE = "text" NAME = "student"> <BR>
     Select Your Grade Level: 
     <SELECT NAME = "grade"> 
     <OPTION SELECTED > 12
     <OPTION> 11
     <OPTION> 10
     <OPTION> 9
     </SELECT>
	<BR>
-->
<h3>entrees:</h3><select name="entrees" >
<option value="pasta">pasta</option>
<option value="hamburger">hamburger</option>
<option value="salad">salad</option>
<option value="pierogi">pierogi</option>
<option value="chicken_cutlet">chicken_cutlet</option>
<option selected="selected" value="Veggies">Veggies</option>
</select>

__END__