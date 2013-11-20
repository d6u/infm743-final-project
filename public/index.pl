#!/usr/bin/perl

use CGI qw(:standard);
use Data::Dumper;
use strict;
use warnings;

use lib "./../lib";
use Header;
use Footer;


my $hostname = url(-base => 1);
my $client_id;
my $client_secret;
if ($hostname eq "http://infm743-final-project.daiwei.lu") {
  $client_id = "419408698184741";
  $client_secret = "d1ee4108afeef0952efcb6828d0da592";
} else {
  $client_id = "542093092547558";
  $client_secret = "8607b56d7bff32aa0a28118b3411bdf3";
}
my $callback_url = "$hostname"."/callback.pl";


print header(-charset => "utf-8");
&Header::print_head('INFM743 Development of "Horoscope" Application', '/');
print <<HTML;
<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
  <div class="container">
    <h1>Hello, Horoscope!</h1>
    <p>This web application will help you organize your Facebook friends based on their horoscope. You can also discover some interesting information about them.</p>
    <p><a class="btn btn-primary btn-lg" href="https://www.facebook.com/dialog/oauth?client_id=$client_id&redirect_uri=$callback_url&scope=friends_birthday">Login with Facebook &raquo;</a></p>
  </div>
</div>
HTML
&Footer::print_foot($hostname);
