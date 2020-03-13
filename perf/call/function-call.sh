#!/bin/sh
PATH=../:$PATH
. midden
require perf

nop() { :; }

perf 10 nop
