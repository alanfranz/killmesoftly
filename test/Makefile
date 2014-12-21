# this requires GNU Make on OSX as well!
.PHONY: test testkmsn testkmsp distclean clean testkmsn.standalone testkmsp.standalone

SHELL := /bin/bash

test: testkmsn testkmsn.standalone testkmsp testkmsp.standalone
	
testkmsn: testenv
	@rm -f kmsn*.out
	@testenv/bin/hardtokill -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/asd1 -c "import time; time.sleep(120)"&
	@testenv/bin/asd2 -c "import time; time.sleep(120)"&
	@testenv/bin/asd3 -c "import time; time.sleep(120)"&
	@sleep 1

	@echo -e "Will now try killing five processes. The first should fail because of nonmatching name, the second should die with SIGKILL, the other three should die instantly:\n"
	@../kmsn notexisting hardtokill asd1 asd2 asd3 | tee kmsn.out
	@sed --regexp-extended -e 's/[0-9]+/X/g' kmsn.out > kmsn.sedded.out
	@diff -u kmsn.sedded.out kmsn.expected
	@echo

testkmsn.standalone: testenv
	@rm -f kmsn*.out
	@testenv/bin/hardtokill -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/asd1 -c "import time; time.sleep(120)"&
	@testenv/bin/asd2 -c "import time; time.sleep(120)"&
	@testenv/bin/asd3 -c "import time; time.sleep(120)"&
	@sleep 1
	@echo -e "Will now try killing five processes. The first should fail because of nonmatching name, the second should die with SIGKILL, the other three should die instantly:\n"
	@../obj/kmsn notexisting hardtokill asd1 asd2 asd3 | tee kmsn.standalone.out
	@sed --regexp-extended -e 's/[0-9]+/X/g' kmsn.standalone.out > kmsn.standalone.sedded.out
	@diff -u kmsn.standalone.sedded.out kmsn.expected
	@echo

testkmsp: testenv
	@rm -f *.pid kmsp*.out
	@{ testenv/bin/python -u -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)" & echo $$! > hardtokill.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 1.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 2.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 3.pid; }
	@{ testenv/bin/python -u -c "pass" & echo $$! > exited.pid; }
	@sleep 2
	@echo -e "Will now try killing five processes. The first should fail because of nonexisting pid, the second should die with SIGKILL, the other three should die instantly:\n"
	@cat exited.pid hardtokill.pid 1.pid 2.pid 3.pid | xargs ../kmsp | tee kmsp.out
	@sed --regexp-extended -e 's/[0-9]+/X/g' kmsp.out > kmsp.sedded.out
	@diff -u kmsp.sedded.out kmsp.expected
	@echo

testkmsp.standalone: testenv
	@rm -f *.pid kmsp*.out
	@{ testenv/bin/python -u -c "import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)" & echo $$! > hardtokill.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 1.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 2.pid; }
	@{ testenv/bin/python -u -c "import time; time.sleep(120)" & echo $$! > 3.pid; }
	@{ testenv/bin/python -u -c "pass" & echo $$! > exited.pid; }
	@sleep 2
	@echo -e "Will now try killing five processes. The first should fail because of nonexisting pid, the second should die with SIGKILL, the other three should die instantly:\n"
	@cat exited.pid hardtokill.pid 1.pid 2.pid 3.pid | xargs ../obj/kmsp | tee kmsp.standalone.out
	@sed --regexp-extended -e 's/[0-9]+/X/g' kmsp.standalone.out > kmsp.standalone.sedded.out
	@diff -u kmsp.standalone.sedded.out kmsp.expected
	@echo


distclean:
	@rm -rf testenv *.pid *.out

testenv:
	virtualenv testenv
	cp testenv/bin/python testenv/bin/hardtokill
	cp testenv/bin/python testenv/bin/asd1
	cp testenv/bin/python testenv/bin/asd2
	cp testenv/bin/python testenv/bin/asd3

