#!/bin/sh
PATH=../:$PATH
. midden
require log
require perf

perf 10 echo 'the' quick brown fox 
