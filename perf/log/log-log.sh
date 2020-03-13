#!/bin/sh
PATH=../:$PATH
. midden
require log
require perf

perf 10 notice 'the %s %s %s' quick brown fox 
