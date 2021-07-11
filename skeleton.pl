#!/usr/bin/env perl -w
# skeleton.pl
# Copyright 2011 Steve Ford (sford@geeky-boy.com) and made available under the
#   Steve Ford's "standard disclaimer, policy, and copyright" notice.  See
#   http://www.geeky-boy.com/steve/standard.html for details.  It means you
#   can do pretty much anything you want with it, including making your own
#   money, but you can't blame me for anything bad that happens.

use strict;
use Getopt::Std;

# globals
my $tool = "skeleton.pl";
my $usage_str = "$tool [-h] [<file>...]";

# process options.
use vars qw($opt_h);
getopts('h') || usage();  # if -h had a value, it would be "h:"

if (defined($opt_h)) {
  help();  # if -h had a value, it would be in $opt_h
}

# Main loop; read each line in each file.
while (<>) {
  chomp;  # remove trailing \n

  # glue continuation lines and strip comments, leading/trailing spaces, and blank lines.
  if (s/\\$//) {
    $_ .= <>;
    redo unless eof();
  }
  s/#.*$//;  s/\s+$//;  s/^\s+//;
  next if (/^\s*$/);

  # do rest of work.
}

# All done.
exit(0);


# End of main program, start subroutines.


sub usage {
  my($err_str) = @_;

  if (defined $err_str) {
    print STDERR "$tool: $err_str\n\n";
  }
  print STDERR "Usage: $usage_str\n\n";

  exit(1);
}  # usage


sub help {
  my($err_str) = @_;

  if (defined $err_str) {
    print "$tool: $err_str\n\n";
  }
  print <<__EOF__;
Usage: $usage_str
Where:
    -h - help
    <file>... - zero or more input files.  If omitted, inputs from stdin.

__EOF__

  exit(0);
}  # help
