(function(window, $, angular, $access_token, undefined) {


// Init Angular App
//
var app = angular.module('horoscope-app', []);


// Set Default Values
//
app.run(function($rootScope) {
  $rootScope.options = {
    gender: 'both',
    sunburst: 'gender'
  };
});


// Count horoscope frequencies for each gender group
//
app.factory('countHoroscopes', function() {
  return function(rawData) {
    var both = [], male = [], female = [], unknown = [];
    var data, gender;
    for (var i = rawData.length - 1; i >= 0; i--) {
      data = _.find(both, {name: rawData[i].zodiac_name});
      if (data) {
        data.count++;
      } else {
        both.push({name: rawData[i].zodiac_name, count: 1});
      }
      switch (rawData[i].gender) {
        case 'male':
          gender = male;
          break;
        case 'female':
          gender = female;
          break;
        default:
          gender = unknown;
          break;
      }
      data = _.find(gender, {name: rawData[i].zodiac_name});
      if (data) {
        data.count++;
      } else {
        gender.push({name: rawData[i].zodiac_name, count: 1});
      }
    };
    return {both: both, male: male, female: female, unknown: unknown};
  };
});


// Draw bar chart
app.directive('horoscopeCountBarChart', function($rootScope) {
  return {
    controller: function($scope, $element, countHoroscopes) {

      var margin = {top: 20, right: 30, bottom: 30, left: 40},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

      var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .2);

      var y = d3.scale.linear()
        .range([height, 0]);

      var chart = d3.select($element[0])
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

      chart.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")");

      chart.append("g")
        .attr("class", "y axis");


      // Query Data
      //
      d3.json('/console.json', function(error, json) {
      // d3.json('/get_friends_data.pl?access_token=' + $access_token, function(error, json) {

        $scope.horoscopesCount = countHoroscopes(json['friends']['data']);
        $scope.$watch('options.gender', determineChartGender);
        $scope.$apply();
      });


      function determineChartGender(gender) {
        drawChart($scope.horoscopesCount[gender]);
      }


      function drawChart(data) {

        x.domain(data.map(function(d) { return d.name }));

        var x0 = x.domain(
          data
          .sort(function(a, b) { return b.count - a.count; })
          .map(function(d) { return d.name; })
        ).copy();

        y.domain([0, d3.max(data, function(d) { return d.count; })]);

        chart.select("g.x.axis").call(xAxis);

        var bars = chart.selectAll(".bar")
          .data(data, function(d) { return d.name; });

        bars.enter().append("rect");

        bars.exit().remove();

        bars.attr("class", "bar")
        .attr("width", x.rangeBand());

        // --- Animation ---
        //
        var transition = chart.transition().duration(500);

        transition.selectAll(".bar")
        .attr("y", function(d) { return y(d.count); })
        .attr("height", function(d) { return height - y(d.count); })
        .delay(function(d, i) { return i * 200; })
        .attr("fill", function() {
          switch ($scope.options.gender) {
            case 'both':   return '#656D78';
            case 'male':   return '#4A89DC';
            case 'female': return '#D770AD';
          }
        })
        .attr("x", function(d) { return x0(d.name); });

        transition.select("g.y.axis").call(yAxis);
        transition.select("g.x.axis").call(xAxis);
      }

    }, // END controller function
    link: function(scope, element, attrs) {

    } // END link function
  } // END return {}
}); // END directive horoscopeCountBarChart


})(window, window.jQuery, window.angular, $access_token);
