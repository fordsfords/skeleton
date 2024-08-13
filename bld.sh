#!/bin/sh
# bld.sh

for F in *.md; do :
  if egrep "<!-- mdtoc-start -->" $F >/dev/null; then :
    # Update doc table of contents (see https://github.com/fordsfords/mdtoc).
    if which mdtoc.pl >/dev/null 2>&1; then LANG=C mdtoc.pl -b "" $F;
    elif [ -x ../mdtoc/mdtoc.pl ]; then LANG=C ../mdtoc/mdtoc.pl -b "" $F;
    else echo "FYI: mdtoc.pl not found; Skipping doc build"; echo ""; fi
  fi
done

rm -f skeleton

echo "Building code"

gcc -Wall -g -o skeleton -pthread skeleton.c cprt.c; if [ $? -ne 0 ]; then exit 1; fi

echo "flake8 skeleton.py"
flake8 skeleton.py; if [ $? -ne 0 ]; then exit 1; fi

echo "pylint skeleton.py"
pylint -sn -r n skeleton.py; if [ $? -ne 0 ]; then exit 1; fi

echo mypy --check-untyped-defs skeleton.py
mypy --check-untyped-defs --no-error-summary skeleton.py

echo "flake8 skeleton_c.py"
flake8 skeleton_c.py; if [ $? -ne 0 ]; then exit 1; fi

echo "pylint skeleton_c.py"
pylint -sn -r n skeleton_c.py; if [ $? -ne 0 ]; then exit 1; fi

echo mypy --check-untyped-defs skeleton_c.py
mypy --check-untyped-defs --no-error-summary skeleton_c.py

echo "Build OK"
