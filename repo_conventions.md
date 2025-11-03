# repo_conventions.md

This document describes my general conventions when creating C-oriented git repositories.

My most of my repos are small.
I generally don't have subdirectories to organize the files.

Most of my repos are either stand-alone programs, or are sub-systems
intended to be included in programs. For example:

* [hmap](https://github.com/fordsfords/hmap) - hash map subsystem.
  * `hmap.c`, `hmap.h` - subsystem implementation.
  * `hmap_test.c` - test program to exercise the subsystem.
  * `bld.sh` - build script for both doc and code.
  * `tst.sh` - self-test script for code.
* [lsim](https://github.com/fordsfords/lsim) - logic simulator program.
  * `lsim*.c`, `lsim*.h` - program implementation.
  * `hmap.c`, `hmap.h` - lsim uses the `hmap` subsystem. Those files are simply checked into the `lsim` repo.
  * `bld.sh` - build script for both doc and code.
  * `tst.sh` - self-test script for program.

Almost all of my repos also have `README.md`, which leverages a table-of-contents generator
available here: https://github.com/fordsfords/mdtoc
The TOC generator is invoked by the `bld.sh` script.

All C content that I write is licensed CC0. This is referred to in the `README.md` file,
each `.c` and `.h` file, and in the `LICENSE.txt` file.

For subsystems, I try to make the subsystem name a short single word (e.g. my hash map is named `hmap`).
The repo name and the main files all use that name. The APIs start with the name. For example,
the `hmap` subsystem is in a repo named `hmap` and has files `hmap.c` annd `hmap.h`. An example API function
is `hmap_create()`.

When I write tools that have potentially reusable code, I try to put the reusable parts into
separate repos as subsystems. The hmap repo is an example; it was written in support of the
`lsim` program, but was spun into a separate repo.

However, C does not have a commonly-used package management system like many other languages do.
So there is no standard way for the `lsim` program to "pull in" the `hmap` subsystem.
I solve this by simply adding copies of the `hmap.c` and `hmap.h` files to the `lsim` repo.
This is easy, but doesn't automatically update if bugs are found and fixed in the `hmap` repo.

