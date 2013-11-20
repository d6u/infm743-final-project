#!/usr/bin/perl

package Footer;


sub print_foot {
  my $hostname     = $_[0];
  my $access_token = $_[1];

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
HTML
  if ($hostname eq "http://infm743-final-project.daiwei.lu") {
    print <<HTML;
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
  ga('create', 'UA-45837894-2', 'daiwei.lu');
  ga('send', 'pageview');
</script>
HTML
  }
  print <<HTML;

</body>
</html>
HTML
}


1
