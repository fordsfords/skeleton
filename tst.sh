#!/bin/sh
# tst.sh - generic test script
#   Tip: script -c ./tst.sh tst.log

SINGLE_T="0"  # Do all tests
if [ -n "$1" ]; then SINGLE_T="$1"; fi

F="tst.sh"  # Could also use `basename $0`
B="./tst"   # Executable under test.

TEST() {
  techo "Test $T [$F:${BASH_LINENO[0]}]: $1" >$B.$T.log
  cat $B.$T.log
}  # TEST

ASSRT() {
  eval "test $1"

  if [ $? -ne 0 ]; then
    echo "ASSRT ERROR, Test $T [$F:${BASH_LINENO[0]}]: not true: '$1'" | tee -a $B.$T.log
    exit 1
  fi
}  # ASSRT


T=1
if [ "$SINGLE_T" -eq 0 -o "$SINGLE_T" -eq "$T" ]; then :
  TEST "Description of test."
  # Change data files, environment, etc. for this test case.
  # Run program. Include command-line options, etc.
  $B 2>&1 | tee -a $B.$T.log
  ST=${PIPESTATUS[0]}; ASSRT "$ST -eq 0"  # Make sure program exited with good status.
  # Extract some outputs and make sure they are in range.
  RATE=`sed <$B.$T.log -n 's/.*result_rate=\([0-9]*\).*/\1/p'`; ASSRT "$RATE -gt 10000 -a $RATE -lt 99999"
fi

# T=2
# ...
