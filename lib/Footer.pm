#!/usr/bin/perl

package Footer;


sub print_foot {
  print <<HTML;
<div class="container">
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
}


1
