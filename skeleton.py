#!/usr/bin/env python3
"""
skeleton.py - Skeletal example.
"""

import sys
import argparse
import fileinput
import re


def process_line(line):
    """
    Skeletal function.
    """

    if re.search(r'^quit$', line):
        sys.exit(0)

    match = re.search(r'^echo (.*)$', line)
    if match:
        print(match.group(1))
        return

    print(f'Error [{fileinput.filename()}:{fileinput.filelineno()}]'
          f' - bad command "{line}"')


def main() -> None:
    """
    Skeletal main.
    """
    parser = argparse.ArgumentParser(
        description="Demo script to show when argparse displays help.",
        epilog="This text appears at the end of the help message."
    )
    parser.add_argument('-n', '--name', help="Name")
    parser.add_argument('-i', '--id', type=int, help="Numeric ID")
    parser.add_argument('files', nargs='*',
                        help="Input files (use - for stdin)")

    args = parser.parse_args()

    print(f"Name: {args.name}")
    print(f"ID: {args.id}")

    # Similar to Perl's 'while (<>) {' diamond operator.
    with fileinput.input(files=args.files) as file_input:
        for line in file_input:
            process_line(line.strip())


if __name__ == "__main__":
    main()
