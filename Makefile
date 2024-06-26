#
# Makefile --Build rules for midden, the heap of shell fragments.
#
package-type = rpm deb
language = sh nroff

SHL_SRC = bash.shl cgi.shl config.shl daemon.shl debian.shl \
    getopt.shl log.shl midden.shl number.shl string.shl tty.shl \
    unicode.shl unit.shl wordy.shl
SH_SRC = midden.sh
MAN1_SRC = midden.1

include makeshift.mk package.mk

install:	install-all install-man
uninstall:	uninstall-all uninstall-man

#
# Disable performance tests, they're not interesting.
#
test@perf:;
