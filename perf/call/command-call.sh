#!/bin/sh
PATH=../:$PATH
. midden
require perf

perf 10 /usr/bin/true
:
