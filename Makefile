.PHONY: test

testenv:
	virtualenv testenv
	testenv/bin/pip install setproctitle

test: testenv
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('hardtokill'); import time; import signal; signal.signal(signal.SIGTERM, lambda x,y: time.sleep(120)); time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd1'); import time; time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd2'); import time; time.sleep(120)"&
	@testenv/bin/python -c "from setproctitle import setproctitle; setproctitle('asd3'); import time; time.sleep(120)"&
	@sleep 1
	@echo "Will now try killing five processes. The first should fail because of nonmatching name, the second should die with SIGKILL, the other three should die instantly"
	@./kmsn notexisting hardtokill asd1 asd2 asd3
