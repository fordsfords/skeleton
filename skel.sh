#!/bin/sh
# skeleton.sh - ??? put brief description here.
#   Note: in this skeletal file, pay special attention 
#   to "???" and make changes as necessary.

# Can call usage with an optional error message
# See TOOL_USAGE below
usage() {
  if [ "$1" != "" ]; then echo "$TOOL: $1" 1>&2; echo "" 1>&2; fi

  echo $TOOL_USAGE 1>&2; echo "" 1>&2
  exit 1
}

# Can call help with an optional message
help() {
  if [ "$1" != "" ]; then echo "$TOOL: $1"; echo ""; fi

  cat <<__EOF__
$TOOL_USAGE
    Give overview of what command does
Where:
    -h - help (prints this help file)
    <in_file> - name of input file.

__EOF__

  exit $EXIT_STAT
}  # help


IWD=`/bin/pwd`                    # remember initial working directory

TOOL=`basename $0`
TOOL_USAGE="Usage: ??? $TOOL [-h] <in_file>"
# Find dir where tool is stored (useful for finding related files)
TOOLROOT=`basename $TOOL .sh`     # strip off ".sh" (if any)
TOOLDIR=`dirname $0`
# Make sure TOOLDIR is a full path name (not relative)
cd $TOOLDIR; TOOLDIR=`/bin/pwd`; cd $IWD

# Assume success
EXIT_STAT=0

# Option processing

while getopts "h" OPTION  # ???
do
  case $OPTION in
    h) help ;;
    \?) usage ;;
  esac
done
shift `expr $OPTIND - 1`  # Make $1 the first positional param after options

# uncomment this line if positional parameter is required
# if [ "$1" = "" ]; then usage "Missing in_file"; fi
# uncomment this line if there are no positional parameters
# if [ "$1" != "" ]; then usage "Unrecognized parameter '$1'"; fi

##############################################################################
# MAIN CODE
##############################################################################

exit $EXIT_STAT
