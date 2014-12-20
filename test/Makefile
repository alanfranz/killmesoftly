# this requires GNU Make on OSX as well!
.PHONY: test testkmsn testkmsp distclean

SHELL := /bin/bash

test: testkmsn testkmsp
	
testkmsn: testenv
	@testenv/bin/hardtokill -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/asd1 -c "import time; time.sleep(120)"&
	@testenv/bin/asd2 -c "import time; time.sleep(120)"&
	@testenv/bin/asd3 -c "import time; time.sleep(120)"&
	@sleep 1
	@echo -e "Will now try killing five processes. The first should fail because of nonmatching name, the second should die with SIGKILL, the other three should die instantly:\n"
	@../kmsn notexisting hardtokill asd1 asd2 asd3
	@echo

testkmsp: testenv 
	@rm -f hardtokill.pid 1.pid 2.pid 3.pid exited.pid
	@ { testenv/bin/python -u -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)" & echo $$! > hardtokill.pid; }
	@ { testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 1.pid; }
	@ { testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 2.pid; }
	@ { testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 3.pid; }
	@ { testenv/bin/python -u -c "pass" & echo $$! > exited.pid; }
	@ sleep 2
	@echo -e "Will now try killing five processes. The first should fail because of nonexisting pid, the second should die with SIGKILL, the other three should die instantly:\n"
	@../kmsp $(shell cat exited.pid) $(shell cat hardtokill.pid)  $(shell cat 1.pid) $(shell cat 2.pid) $(shell cat 3.pid)
	@echo


distclean:
	@rm -rf testenv *.pid

testenv:
	virtualenv testenv
	cp testenv/bin/python testenv/bin/hardtokill
	cp testenv/bin/python testenv/bin/asd1
	cp testenv/bin/python testenv/bin/asd2
	cp testenv/bin/python testenv/bin/asd3

