.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

.PHONY: test
test: clean
	@echo "\n== test\n"
	dbt test

.PHONY: run
run: clean
	@echo "\n== run\n"
	dbt run

.PHONY: clean
clean:
	@echo "\n== clean\n"
	dbt clean
