(function(window, $, angular, $access_token, undefined) {


// Init Angular App
//
var app = angular.module('horoscope-app', []);


// Set Default Values
//
app.run(function($rootScope) {
  $rootScope.gender = 'both';
});


// Draw bar chart
app.directive('horoscopeCountBarChart', function() {
  return {
    controller: function() {

    },
    link: function(scope, element, attrs) {
      var margin = {top: 20, right: 30, bottom: 30, left: 40},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

      var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

      var y = d3.scale.linear()
        .range([height, 0]);

      var chart = d3.select(".chart")
        .attr("width" , width  + margin.left + margin.right)
        .attr("height", height + margin.top  + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      var xAxis = d3.svg.axis()
        .scale(x)
        .orient("bottom");

      var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left");

      d3.json('/get_friends_data.json', function(error, json) {
      // d3.json('/get_friends_data.pl?access_token=' + $access_token, function(error, json) {
      //   console.save(json);
        var horoscopes  = [];
        var friendsData = json['friends']['data'];

        for (var i = friendsData.length - 1; i >= 0; i--) {
          var name = friendsData[i]['zodiac_name'];
          var theHoroscope = _.find(horoscopes, {name: name});
          if (theHoroscope) {
            theHoroscope['count']++;
          } else {
            horoscopes.push({name: name, count: 1});
          }
        };

        x.domain(horoscopes.map(function(d) { return d.name }));
        y.domain([0, d3.max(horoscopes, function(d) { return d.count; })]);

        chart.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

        chart.append("g")
          .attr("class", "y axis")
          .call(yAxis);

        chart.selectAll(".bar")
          .data(horoscopes)
          .enter().append("rect")
          .attr("class", "bar")
          .attr("x", function(d) { return x(d.name); })
          .attr("y", function(d) { return y(d.count); })
          .attr("height", function(d) { return height - y(d.count); })
          .attr("width", x.rangeBand());
      });
    } // END link function
  } // END return {}
});


})(window, window.jQuery, window.angular, $access_token);
