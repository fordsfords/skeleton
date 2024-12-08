#!/usr/bin/env python3
"""
skeleton.py - Skeletal example.
"""

import sys
import argparse
import fileinput
import re
# from typing import TextIO, Dict, Any, List


# pylint: disable=R0903
class Main:
    """
    Main program.
    """

    def __init__(self) -> None:
        parser = argparse.ArgumentParser(
            description="Demo script to show when argparse displays help.",
            epilog="This text appears at the end of the help message.",
        )
        # Can use: default=blah, required=True
        parser.add_argument("-n", "--name", help="Name")
        parser.add_argument("-i", "--id", type=int, help="Numeric ID")
        # Can use: action='count', default=0
        parser.add_argument(
            "-q",
            "--quiet",
            action="store_true",
            help="suppress informational messages.",
        )
        parser.add_argument("files", nargs="*", help="Input files (use - for stdin)")

        self.args = parser.parse_args()

    def process_line(self, line: str) -> None:
        """
        Skeletal function.
        """

        if re.search(r"^quit$", line):
            sys.exit(0)

        match = re.search(r"^echo (.*)$", line)
        if match:
            if not self.args.quiet:
                print(match.group(1))
            return

        print(
            f"Error [{fileinput.filename()}:{fileinput.filelineno()}]"
            f' - bad command "{line}"'
        )

    def main(self) -> None:
        """Main."""

        if not self.args.quiet:
            for arg, value in vars(self.args).items():
                print(f"{arg}: {value}")

        # Similar to Perl's 'while (<>) {' diamond operator.
        with fileinput.input(files=self.args.files) as file_input:
            for line in file_input:
                # current_file = file_input.filename()
                # line_num = file_input.filelineno()  # line within current file
                self.process_line(line.strip())


if __name__ == "__main__":
    Main().main()
