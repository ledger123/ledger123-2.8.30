# bp 2014/11 - include this into .pl and .pm files
# then add carp("message"); warn("no good"; die("too late"); messages
# messages will be written to carp.log or the web screen
use CGI::Carp qw(carpout);
open (LOG, ">> $userspath/carp.log") or
  die ("unable to open carp.log");

carpout(LOG);

