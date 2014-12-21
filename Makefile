PREFIX = /usr/local
BINDIR = $(PREFIX)/bin
OBJDIR = obj
INSTALLCMD = install -c

.PHONY: all test install clean

# Define source files and mapping to obj/ directory
SRCFILES = kmsn kmsp
OBJFILES = $(addprefix $(OBJDIR)/,$(SRCFILES))

# create obj/ directory and use sed to generate a "standalone" kms* script
$(OBJDIR)/%: % kms_functions
	mkdir -p $(@D)
	sed -f replace.sed $< > $@
	chmod +x $@

all: $(OBJFILES)

clean:
	rm -rf $(OBJDIR)

test: all
	cd test ; make distclean test

install: all
	$(INSTALLCMD) -d $(BINDIR)
	$(INSTALLCMD) obj/* $(BINDIR)
