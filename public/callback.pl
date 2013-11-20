#!/usr/bin/perl

use CGI qw(:standard);
use LWP::UserAgent; # install Mozilla::CA module to enable SSL calls
use JSON;
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


# Check callback status
#
my $code = param('code');
my $error_message;

if ($code) {
# Authorization Successful
  my $ua = LWP::UserAgent->new;
  $ua->timeout(10);
  $ua->env_proxy;

  my $response = $ua->get("https://graph.facebook.com/oauth/access_token?client_id=$client_id&redirect_uri=$callback_url&client_secret=$client_secret&code=$code");

  if ($response->is_success) {
    my %results      = &decode_www_form($response->decoded_content);
    my $access_token = $results{'access_token'};
    print redirect(-url => $hostname."/dashboard.pl?access_token=$access_token");
  }
  else {
    my %hash = %{ decode_json($response->decoded_content) };
    $error_message = $hash{'error'}{'message'};
  }
}
else {
# Authorization Failed
  $error_message = param('error_description');
}


if ($error_message) {
  &print_error_html($error_message);
}


# decode string:
#   access_token={access-token}&expires={seconds-til-expiration}
#
sub decode_www_form {
  my %hash = ();
  my @pairs = split('&', $_[0]);
  foreach (@pairs) {
    my @array = split('=', $_);
    $hash{$array[0]} = $array[1];
  }
  return %hash;
}


sub print_error_html {
  my $error_message = $_[0];
  print header(-charset => "utf-8");
  &Header::print_head('INFM743 Development of "Horoscope" Application', '/');
  print <<HTML;
<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
  <div class="container">
    <h1>Error: $error_message</h1>
    <p>Please try again.</p>
    <p><a class="btn btn-primary btn-lg" href="https://www.facebook.com/dialog/oauth?client_id=$client_id&redirect_uri=$callback_url">Login with Facebook &raquo;</a></p>
  </div>
</div>
HTML
  &Footer::print_foot();
}
