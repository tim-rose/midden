SH_SRC = log-echo.sh log-log-unprinted.sh log-log.sh log-printf.sh
language = sh
include devkit.mk

test: test-loop
test-loop: $(SHELL_TRG)
	for test in $(SHELL_TRG); do ./$$test; done 
	true
