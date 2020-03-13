#!/bin/sh
PATH=../:$PATH
. midden
require log
require perf

perf 10 info 'the %s %s %s' quick brown fox 
