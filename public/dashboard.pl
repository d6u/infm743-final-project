#!/usr/bin/perl

use CGI qw(:standard);
use strict;
use warnings;

use lib "./../lib";
use Header;
use Footer;


my $hostname     = url(-base => 1);
my $access_token = param('access_token');


print header(-charset => "utf-8");
&Header::print_head('INFM743 Development of "Horoscope" Application', '#');
print <<HTML;
<div class="container">
  <h1>Horoscope Statistics</h1>

  <div class="row">
    <div class="col-sm-12">
      <form class="form-horizontal" role="form">
        <div>
          <label class="checkbox-inline">
            <input type="radio" value="both" ng-model="options.gender"> Both
          </label>
          <label class="checkbox-inline">
            <input type="radio" value="male" ng-model="options.gender"> Boys
          </label>
          <label class="checkbox-inline">
            <input type="radio" value="female" ng-model="options.gender"> Girls
          </label>
        </div>

        <div>
          <label class="checkbox-inline">
            <input type="radio" value="count" ng-model="options.barSort"> Sort by Count
          </label>
          <label class="checkbox-inline">
            <input type="radio" value="zodiac" ng-model="options.barSort"> Sort by Zodiac Name
          </label>
        </div>
      </form>

      <svg horoscope-count-bar-chart class="chart"></svg>
    </div>

    <div class="col-sm-12">
      <form class="form-horizontal" role="form">
        <label class="checkbox-inline">
          <input type="radio" value="genders" ng-model="options.sunburst"> Gender first
        </label>
        <label class="checkbox-inline">
          <input type="radio" value="horoscopes" ng-model="options.sunburst"> Horoscope first
        </label>
      </form>

      <svg sunburst-chart class="chart-sunburst"></svg>
    </div>
  </div>
</div>
HTML
&Footer::print_foot($hostname, $access_token);
