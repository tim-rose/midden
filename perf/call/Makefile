#
# perf --Performance tests for various sh(1) commands
#
language = sh
SH_SRC = command-call.sh empty-call.sh function-call.sh \
    inline-call.sh

include makeshift.mk

test: test-loop
test-loop: $(SH_TRG)
	-for test in $(SH_TRG); do ./$$test; done 
