#!/usr/bin/env bash
# skeleton.sh - ??? put brief description here.
#   Note: in this skeletal file, pay special attention 
#   to "???" and make changes as necessary.
#
# This code and its documentation is Copyright 2002-2021 Steven Ford
# and licensed "public domain" style under Creative Commons "CC0":
#   http://creativecommons.org/publicdomain/zero/1.0/
# To the extent possible under law, the contributors to this project have
# waived all copyright and related or neighboring rights to this work.
# In other words, you can use this code for any purpose without any
# restrictions.  This work is published from: United States.  The project home
# is https://github.com/fordsfords/skeleton

# Another interesting skeleton for daemons: https://github.com/fordsfords/exampled

# Can call usage with an optional error message
# See TOOL_USAGE below
usage() {
  if [[ -n "$1" ]]; then echo "$TOOL: $1" 1>&2; echo "" 1>&2; fi

  echo "$TOOL_USAGE" 1>&2; echo "" 1>&2

  if (( RM_TMP )); then rm -f $TMP_FILE*; fi
  exit 1
}

# Can call help with an optional message
help() {
  if [[ -n "$1" ]]; then echo "$TOOL: $1"; echo ""; fi

  cat <<__EOF__
$TOOL_USAGE
    Give overview of what command does
Where:
    -h - help (prints this help file)
    -t <tmp_file> - For debugging purposes.  Temp files are normally named
        and deleted automatically.  The "-t" option allows the user to specify
        a different name for temp files (various name extensions might be
        appended).  It also prevents the temp files from being deleted.
    <in_file> - name of input file.

__EOF__

  if (( RM_TMP )); then rm -f $TMP_FILE*; fi
  exit $EXIT_STAT
}  # help


TOOL=$(basename "$0")
TOOL_USAGE="Usage: ??? $TOOL [-h] [-t <tmp_file>] <in_file>"
# Find dir where tool is stored (useful for finding related files)
TOOLROOT=$(basename "$TOOL" .sh)     # strip off ".sh" (if any)
TOOLDIR=$(realpath "$(dirname "$0")")

# Assume success
EXIT_STAT=0

# Option processing

TMP_FILE="/tmp/${TOOL}_$$_tmp"    # default value for -t
RM_TMP=1     # This flag tells the script to remove temp files before exit

while getopts "ht:" OPTION  # ???
do
  case $OPTION in
    h) help ;;
    t) TMP_FILE=$OPTARG
       # If user supplies own temp file name, don't delete
       RM_TMP=0 ;;
    \?) usage ;;
  esac
done
shift $((OPTIND - 1))  # Make $1 the first positional param after options

# uncomment this line if positional parameter is required
# if [[ -z "$1" ]]; then usage "Missing in_file"; fi
# uncomment this line if there are no positional parameters
# if [[ -n "$1" ]]; then usage "Unrecognized parameter '$1'"; fi

# Make sure TMP_FILE is a full path name (not relative)
TMP_FILE=$(realpath -m "$TMP_FILE")

# If the user hits control-C, clean up the temp file (if desired)
trap "if (( RM_TMP )); then rm -f $TMP_FILE*; fi; exit 1" HUP INT QUIT TERM

##############################################################################
# MAIN CODE
##############################################################################

# All done, clean up the temp file (if necessary)
if (( RM_TMP )); then rm -f $TMP_FILE*; fi

exit $EXIT_STAT


##############################################################################
# Useful Code Fragments
##############################################################################


RUNNING_PIDS=""
kill_pids()
{
  if [[ -n "$RUNNING_PIDS" ]]; then :
    if [[ "$EXIT_STAT" -ne 0 ]]; then echo "kill_pids, $(date): killing $RUNNING_PIDS"; fi
    kill $RUNNING_PIDS 2>&1   ### | egrep -v "No such process"
  fi
}


trap "echo \"INTERRUPT, $(date)\" >&2; kill_pids; exit 1" HUP INT QUIT TERM
trap "SAMPLE=1" USR1


tcpdump -i en0 -w skeleton.pcap &
TCPDUMP_PID="$!"; echo "fyi, $(date): TCPDUMP_PID=$TCPDUMP_PID"; RUNNING_PIDS="$RUNNING_PIDS $TCPDUMP_PID"


NUM_GOODS=$(egrep "^Good: daemon started" tst.log | wc -l); ASSRT "$NUM_GOODS -eq 1"
