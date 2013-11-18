(function(window, $, angular, $access_token, undefined) {


// Init Angular App
//
var app = angular.module('horoscope-app', []);


// Set Default Values
//
app.run(function($rootScope) {
  $rootScope.options = {
    gender: 'both'
  };
});


// Draw bar chart
app.directive('horoscopeCountBarChart', function($rootScope) {
  return {
    controller: function($scope, $element) {

      var margin = {top: 20, right: 30, bottom: 30, left: 40},
        width = 960 - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

      var x = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);

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

      var horoscopes       = [];
      var horoscopesMale   = [];
      var horoscopesFemale = [];

      // d3.json('/get_friends_data.json', function(error, json) {
      d3.json('/get_friends_data.pl?access_token=' + $access_token, function(error, json) {
        var friendsData = json['friends']['data'];

        for (var i = friendsData.length - 1; i >= 0; i--) {
          var friend = friendsData[i];
          var name   = friend['zodiac_name'];
          var gender = friend['gender'];

          if (name != 'none') {
            var theHoroscope       = _.find(horoscopes      , {name: name});
            var theMaleHoroscope   = _.find(horoscopesMale  , {name: name});
            var theFemaleHoroscope = _.find(horoscopesFemale, {name: name});

            if (theHoroscope) {
              theHoroscope['count']++;
            } else {
              horoscopes.push({name: name, count: 1});
            }

            if (gender == 'male') {
              if (theMaleHoroscope) {
                theMaleHoroscope['count']++;
              } else {
                horoscopesMale.push({name: name, count: 1});
              }
            }
            else if (gender == 'female') {
              if (theFemaleHoroscope) {
                theFemaleHoroscope['count']++;
              } else {
                horoscopesFemale.push({name: name, count: 1});
              }
            }
          }
        };

        chart.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")");

        chart.append("g")
          .attr("class", "y axis");

        drawChart();
      });


      function drawChart() {
        switch ($scope.options.gender) {
          case 'both':
            data = horoscopes;
            break;
          case 'male':
            data = horoscopesMale;
            break;
          case 'female':
            data = horoscopesFemale;
            break;
        }

        x.domain(data.map(function(d) { return d.name }));

        var x0 = x.domain(
          data
          .sort(function(a, b) { return b.count - a.count;})
          .map(function(d) { return d.name; })
        ).copy();

        y.domain([0, d3.max(data, function(d) { return d.count; })]);

        chart.select("g.x.axis").call(xAxis);

        var bars = chart.selectAll(".bar").data(data);

        bars.enter().append("rect");
        bars.exit().remove();

        bars.attr("class", "bar")
        .classed("male", function() {
          return $scope.options.gender === 'male';
        })
        .classed("female", function() {
          return $scope.options.gender === 'female';
        })
        .attr("x", function(d) { return x0(d.name); })
        .attr("width", x.rangeBand());

        // --- Animation ---
        //
        var transition = chart.transition();

        transition.selectAll(".bar")
        .attr("y", function(d) { return y(d.count); })
        .attr("height", function(d) { return height - y(d.count); })
        .attr("fill", function() {
          switch ($scope.options.gender) {
            case 'both':
              return '#656D78';
              break;
            case 'male':
              return '#4A89DC';
              break;
            case 'female':
              return '#D770AD';
              break;
          }
        });

        transition.select("g.y.axis").call(yAxis);
        transition.select("g.x.axis").call(xAxis);
      }

      $scope.$watch('options.gender', function() {
        drawChart();
      });

    }, // END controller function
    link: function(scope, element, attrs) {

    } // END link function
  } // END return {}
}); // END directive horoscopeCountBarChart


})(window, window.jQuery, window.angular, $access_token);
