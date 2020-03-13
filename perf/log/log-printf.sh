#!/bin/sh
PATH=../:$PATH
. midden
require log
require perf

perf 10 printf 'the %s %s %s\n' quick brown fox 
