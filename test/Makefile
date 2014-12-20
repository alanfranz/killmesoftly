.PHONY: test testkmsn testkmsp clean distclean

SHELL := /bin/bash

test: testkmsn testkmsp
	@testenv/bin/python -c "import os; print os.getpid(); import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/python -c "import os; print os.getpid(); import time; time.sleep(120)"&
	@testenv/bin/python -c "import os; print os.getpid(); import time; time.sleep(120)"&
	@testenv/bin/python -c "import os; print os.getpid(); import time; time.sleep(120)"&

testkmsn: testenv
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('hardtokill'); import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd1'); import time; time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd2'); import time; time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd3'); import time; time.sleep(120)"&
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
	@ while ! [[ -e exited.pid && -e hardtokill.pid && -e 1.pid && -e 2.pid && -e 3.pid ]]; do \
		sleep 0.5 ; \
	done; 
	@echo -e "Will now try killing five processes. The first should fail because of nonexisting pid, the second should die with SIGKILL, the other three should die instantly:\n"
	@../kmsp $(shell cat exited.pid) $(shell cat hardtokill.pid)  $(shell cat 1.pid) $(shell cat 2.pid) $(shell cat 3.pid)
	@echo


distclean: clean
	@rm -rf testenv *.pid

testenv:
	virtualenv testenv
	testenv/bin/pip install setproctitle

