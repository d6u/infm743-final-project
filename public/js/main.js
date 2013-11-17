(function(window, $, $access_token, undefined) {

  d3.json('/get_friends_data.pl?access_token='+$access_token, function(error, json) {
    console.log(json);
  });

})(window, window.jQuery, $access_token);
