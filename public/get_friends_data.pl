#!/usr/bin/perl

use CGI qw(:standard);
use LWP::UserAgent; # install Mozilla::CA module to enable SSL calls
use JSON;
use Date::Horoscope;
use Date::Manip;
use Data::Dumper;
use strict;
use warnings;


my $access_token = param('access_token');

my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->env_proxy;

my $response = $ua->get("https://graph.facebook.com/me?fields=friends.fields(birthday,gender)&access_token=$access_token");

print header(-type => "application/json", -charset => "utf-8");
if ($response->is_success) {
  my %data = %{ decode_json($response->decoded_content) };
  foreach (@{ $data{'friends'}{'data'} }) {
    my $birthday = $_->{'birthday'};
    if ($birthday) {
      $birthday =~ /^(\d\d)\/(\d\d)(?:\/\d\d\d\d)?/i;
      my $month = $1;
      my $day   = $2;
      $_->{'zodiac_name'} = Date::Horoscope::locate("$month-$day");
    } else {
      $_->{'zodiac_name'} = 'none';
    }
  }
  print encode_json(\%data);
}
else {
  print $response->decoded_content;
}
