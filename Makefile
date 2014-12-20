all: kmsn.standalone kmsp.standalone

kmsn.standalone: kmsn kms_functions
	sed -f replace.sed kmsn > kmsn.standalone

kmsp.standalone: kmsp kms_functions
	sed -f replace.sed kmsp > kmsp.standalone

