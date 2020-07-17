# Midden

Midden is a library of shell functions that extends "Bourne-like" shells
into something a bit more useful for general programming.  Although it
works fine with **bash**, the original motivation for writing midden was
to see how much could be done in smaller, simpler shells (e.g. **dash**),
which see deployment in embedded or constrained systems.

Midden is composed of a core set of functions, and some optional modules
for specific things such as:

 * processing command-line options
 * logging to stderr, file or syslog
 * loading configuration from ".ini" files
 * running as a daemon.

## Requirements

Most of the code is written to the POSIX.1 standard, so any
POSIX-compliant shell should work fine.  There are a few features that are
non-POSIX (e.g. the use of "caller" in *log.shl*), which only work
when running under **bash**, but fallback to a stub for shells that
don't support these features.

## Installation

If you have [**devikt**](https://github.com/tim-rose/makeshift) installed:

```sh
$ make install
```

But midden is simply a bunch of shell code, so you can also install it by
hand fairly easily too:

```sh
$ prefix=/usr/local
$ for file in *.sh;  do install -D -m 755 $file $prefix/bin/${file%.sh}
$ for file in *.shl; do install -D -m 644 $file $prefix/lib/sh/$file
$ for file in *.1;   do install -D -m 644 $file $prefix/share/man/man1/$file
```

(Assuming you have */usr/local/bin* in your `PATH`.)

## Getting Started

Midden deploys in two main pieces:

 * a "midden" bootstrap script that loads the core midden library
 * a library of shell scripts that implement various midden functions.

To use midden in your scripts, you must *source* it into your script.
Because the `PATH` variable is used to locate sourced scripts, all that's
needed is:

```sh
. midden
```

(Note that "source" is a *bash* command, and isn't available in all POSIX
shells.)

The "midden" script is quite small; it really only defines the *require*
function, which it then uses to load in the rest of the midden core
functions, defined in *midden.shl*.

*Require* is a smarter variant of shell file sourcing:

 * it searches for files in `MIDDENPATH`, if it's defined
 * it only includes files once.

## Environment

TBD.
