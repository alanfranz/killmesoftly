prefix = /usr/local
bindir = $(prefix)/bin
objdir = obj
INSTALLCMD = install -c

.PHONY: all test install clean

# Define source files and mapping to obj/ directory
SRCFILES = kmsn kmsp
OBJFILES = $(addprefix $(objdir)/,$(SRCFILES))

# create obj/ directory and use sed to generate a "standalone" kms* script
$(objdir)/%: % kms_functions
	mkdir -p $(@D)
	sed -f replace.sed $< > $@
	chmod +x $@

all: $(OBJFILES)

clean:
	rm -rf $(objdir)/

test: all
	cd test ; make distclean test

install: all
	$(INSTALLCMD) -d $(bindir)
	$(INSTALLCMD) obj/* $(bindir)
