#!/usr/bin/perl

use CGI qw(:standard);
use Data::Dumper;
use strict;
use warnings;


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
print <<HTML;
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title></title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width">

  <link rel="stylesheet" href="css/bootstrap.min.css">
  <style>
    body {
      padding-top: 50px;
      padding-bottom: 20px;
    }
  </style>
  <link rel="stylesheet" href="css/bootstrap-theme.min.css">
  <link rel="stylesheet" href="css/main.css">

  <script src="js/modernizr-2.6.2-respond-1.1.0.min.js"></script>
</head>
<body>
<!--[if lt IE 7]>
  <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="/">INFM743 Development of Horoscope Application</a>
    </div>
  </div>
</div>

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
  <div class="container">
    <h1>Hello, Horoscope!</h1>
    <p>This web application will help you organize your Facebook friends based on their horoscope. You can also discover some interesting information about them.</p>
    <p><a class="btn btn-primary btn-lg" href="https://www.facebook.com/dialog/oauth?client_id=$client_id&redirect_uri=$callback_url&scope=friends_birthday">Login with Facebook &raquo;</a></p>
  </div>
</div>

<div class="container">

  <hr>

  <footer>
    <p>&copy; INFM743 Final Project 2013</p>
  </footer>
</div> <!-- /container -->

<script>
  var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
  (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
  g.src='//www.google-analytics.com/ga.js';
  s.parentNode.insertBefore(g,s)}(document,'script'));
</script>
</body>
</html>
HTML
