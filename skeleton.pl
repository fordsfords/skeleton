#!/usr/bin/env perl
# skeleton.pl
#
# This code and its documentation is Copyright 2011-2021 Steven Ford
# and licensed "public domain" style under Creative Commons "CC0":
#   http://creativecommons.org/publicdomain/zero/1.0/
# To the extent possible under law, the contributors to this project have
# waived all copyright and related or neighboring rights to this work.
# In other words, you can use this code for any purpose without any
# restrictions.  This work is published from: United States.  The project home
# is https://github.com/fordsfords/skeleton

use strict;
use warnings;
use Getopt::Std;
use File::Basename;
use Carp;

# globals
my $tool = basename($0);
my $usage_str = "$tool [-h] [-o out_file] [file ...]";

# process options.
use vars qw($opt_h $opt_o);
getopts('ho:') || usage();

if (defined($opt_h)) {
  help();  # if -h had a value, it would be in $opt_h
}

my $out_fd;
if (defined($opt_o)) {
  open($out_fd, ">", $opt_o) or die("Error opening '$opt_o': $!");
} else {
  $out_fd = *STDOUT;
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
  print $out_fd "??? File: $ARGV, line: $.: '$_'\n";
} continue {  # This continue clause makes "$." give line number within file.
  close ARGV if eof;
}

# All done.
exit(0);


# End of main program, start subroutines.


sub mycroak {
  my ($msg) = @_;

  # Print input file name and line number.
  croak("Error, input_file:line=$ARGV:$., $msg");
}  # mycroak


sub assrt {
  my ($assertion, $msg) = @_;

  if (! ($assertion)) {
    if (defined($msg)) {
      mycroak("Assertion failed, $msg");
    } else {
      mycroak("Assertion failed");
    }
  }
}  # assrt


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
    -o out_file - output file (default: STDOUT).
    file ... - zero or more input files.  If omitted, inputs from stdin.

__EOF__

  exit(0);
}  # help
