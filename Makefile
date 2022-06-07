.DEFAULT_GOAL: help
SHELL := /bin/bash

PROJECTNAME := "fury-kubernetes-logging"

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command to run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

check-%: # detection of required software.
	@which ${*} > /dev/null || (echo '*** Please install `${*}` ***' && exit 1)

license-requirements: check-docker
	@docker build --no-cache --pull --target add-license-requirement -f build/builder/Dockerfile -t ${PROJECTNAME}:local-license-requirements .

## add-license: Add license headers in all files in the project
add-license: license-requirements
	@docker run --rm -v ${PWD}:/src -w /src ${PROJECTNAME}:local-license-requirements addlicense -c "SIGHUP s.r.l" -v -l bsd .

## check-license: Check license headers are in-place in all files in the project
check-license: check-docker
	@docker build --no-cache --pull --target check-license -f build/builder/Dockerfile -t ${PROJECTNAME}:local-license .

## lint: Run the policeman over the repository
lint: check-docker
	@docker build --no-cache --pull --target linter -f build/builder/Dockerfile -t ${PROJECTNAME}:local-lint .



