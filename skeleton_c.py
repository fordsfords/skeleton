#!/usr/bin/env python3
"""
skeleton.py - Skeletal example.
"""

import sys
import argparse
import fileinput
import re


class Config:
    """
    Static class holding config info.
    """

    _args = None

    @staticmethod
    def parse_args():
        """ Parse command-line. """
        if Config._args is not None:
            raise RuntimeError("Arguments have already been parsed.")

        parser = argparse.ArgumentParser(
            description="Demo script to show when argparse displays help.",
            epilog="This text appears at the end of the help message."
        )
        parser.add_argument('-n', '--name', help="Name")
        parser.add_argument('-i', '--id', type=int, help="Numeric ID")
        parser.add_argument('-q', '--quiet', action='store_true',
                            help="Numeric ID")
        parser.add_argument('files', nargs='*',
                            help="Input files (use - for stdin)")

        Config._args = parser.parse_args()

    @staticmethod
    def args():
        """ Return argparse args object. """
        if Config._args is None:
            raise RuntimeError("Arguments have not been parsed.")
        return Config._args


def process_line(line) -> None:
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

    Config.parse_args()

    if not Config.args().quiet:
        print(f"Name: {Config.args().name}")
        print(f"ID: {Config.args().id}")

    # Similar to Perl's 'while (<>) {' diamond operator.
    with fileinput.input(files=Config.args().files) as file_input:
        for line in file_input:
            process_line(line.strip())


if __name__ == "__main__":
    main()
