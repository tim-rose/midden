#!/bin/sh
#
# MIDDEN --Bootstrap for the midden shell library.
#
# Contents:
# resolve_path() --Find a file in a path-specific way.
# require()      --load some files once-only.
# match()        --Test if a string matches a pattern.
#
# Remarks:
# This bootstrap code just defines enough stuff to load the rest via require().
#
midden_version="VERSION"
unset CDPATH			# not needed, and causes junk on stdout

#
# resolve_path() --Find a file in a path-specific way.
#
# Parameters:
# path	--the path to search (optional, default: $PATH )
# file	--the file (possibly with glob characters?)
#
resolve_path()
{
    local path=''		# REVISIT: honour absolute paths...

    if [ $# -eq 2 ]; then
	path="$1"
	shift
    else
	path=$PATH
    fi

    local IFS=: dir='' target=''

    for dir in $path; do
	for target in $dir/$1; do	# handle globs
    	    if [ -e "$target" ]; then
		echo "$target"
		true; return	# success: found at $dir
	    fi
	done
    done
    false; return		# failure: no such file in path
}

#
# require() --load some files once-only.
#
# Remarks:
# the variable "shl_loaded" is used to track whether a file is already loaded.
#
require()
{
    local library=$1; shift
    local library_path='' status=0
    local require_path=${MIDDENPATH:-$PATH}:/usr/local/lib/sh:/usr/lib/sh

    shl_loaded=${shl_loaded:-:}

    if ! match "$shl_loaded" "*:$library:*"; then
	on_load() { :; }
	if library_path=$(resolve_path "$require_path" "$library.shl"); then
	    if . "$library_path"; then
		shl_loaded="$shl_loaded$library:"
	    fi
	else
	    status=$?
	    printf 'error: cannot load library file "%s"\n' "$library" >&2
	fi
	on_load "$@"
    fi
    return $status
}

#
# match() --Test if a string matches a pattern.
#
# Parameters:
# string	--the string to test
# pattern	--the target pattern to match against
#
# Returns:
# Success: true; Failure: false
#
match()
{
    local string="$1"
    local pattern="$2"

    case "$string" in
    $pattern) true; return;;
    esac
    false; return
}

require midden
