subdir = text
DATA_SRC = plural.txt

include devkit.mk

install: $(DATA_SRC:%=$(datadir)/%)
uninstall: uninstall-data
uninstall-data:
	$(RM) $(DATA_SRC:%=$(datadir)/%)
	$(RMDIR) -p $(datadir) 2>/dev/null ||:
