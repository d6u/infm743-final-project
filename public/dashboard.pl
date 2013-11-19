#!/usr/bin/perl

use CGI qw(:standard);
use LWP::UserAgent; # install Mozilla::CA module to enable SSL calls
use JSON;
use Data::Dumper;
use strict;
use warnings;


my $access_token = param('access_token');


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
<body ng-app="horoscope-app">
<!--[if lt IE 7]>
  <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
<![endif]-->
<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">INFM743 Development of Horoscope Application</a>
    </div>
  </div>
</div>

<div class="container">
  <h1>Horoscope Statistics</h1>

  <div class="row">
    <div class="col-sm-12">
      <form class="form-horizontal" role="form">
        <label class="checkbox-inline">
          <input type="radio" value="both" ng-model="options.gender"> Both
        </label>
        <label class="checkbox-inline">
          <input type="radio" value="male" ng-model="options.gender"> Boys
        </label>
        <label class="checkbox-inline">
          <input type="radio" value="female" ng-model="options.gender"> Girls
        </label>
      </form>

      <svg horoscope-count-bar-chart class="chart"></svg>
    </div>
  </div>

  <hr>

  <footer>
    <p>&copy; INFM743 Final Project 2013</p>
  </footer>
</div> <!-- /container -->

<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/d3.v3.min.js"></script>
<script src="js/lodash-2.3.0.compat.min.js"></script>
<script src="js/console-save.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/angular-animate.min.js"></script>
<script src="js/angular-sanitize.min.js"></script>
<script>var \$access_token = '$access_token';</script>
<script src="js/main.js"></script>

<script>
  var _gaq=[['_setAccount','UA-XXXXX-X'],['_trackPageview']];
  (function(d,t){var g=d.createElement(t),s=d.getElementsByTagName(t)[0];
  g.src='//www.google-analytics.com/ga.js';
  s.parentNode.insertBefore(g,s)}(document,'script'));
</script>
</body>
</html>
HTML
