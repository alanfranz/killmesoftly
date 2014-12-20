.PHONY: all test

all: kmsn.standalone kmsp.standalone

kmsn.standalone: kmsn kms_functions
	sed -f replace.sed kmsn > kmsn.standalone
	chmod +x kmsn.standalone

kmsp.standalone: kmsp kms_functions
	sed -f replace.sed kmsp > kmsp.standalone
	chmod +x kmsp.standalone

test: all
	cd test ; make distclean test

