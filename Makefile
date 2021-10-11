.DEFAULT_GOAL: help
SHELL := /bin/bash

PROJECTNAME := "fury-kubernetes-logging"
VERSION := $(shell (git for-each-ref refs/tags --sort=-taggerdate --format='%(refname)' --count=1 | sed -Ee 's/^refs\/tags\/v|-.*//'))

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command to run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

.PHONY: version
## version: lists the latest version of tool
version:
	@echo v$(VERSION)

SEMVER_TYPES := major minor patch
BUMP_TARGETS := $(addprefix bump-,$(SEMVER_TYPES))
.PHONY: $(BUMP_TARGETS)
## bump-major: Bumps the module up by a major version
## bump-minor: Bumps the module up by a minor version
## bump-patch: Bumps the module up by a patch version
$(BUMP_TARGETS): check-bump2version
	$(eval bump_type := $(strip $(word 2,$(subst -, ,$@))))
	@echo "Making a $(bump_type) tag"
	@bump2version --current-version $(VERSION) $(bump_type)

check-variable-%: # detection of undefined variables.
	@[[ "${${*}}" ]] || (echo '*** Please define variable `${*}` ***' && exit 1)

check-%: # detection of required software.
	@which ${*} > /dev/null || (echo '*** Please install `${*}` ***' && exit 1)

requirements: check-docker
	@docker build --no-cache --pull --target requirements -f build/builder/Dockerfile -t ${PROJECTNAME}:local-requirements .

## add-license: Add license headers in all files in the project
add-license: requirements
	@docker run --rm -v ${ROOT_DIR}:/app -w /app ${PROJECTNAME}:local-requirements addlicense -c "SIGHUP s.r.l" -v -l bsd .
	@$(MAKE) clean-requirements

## check-label: Check if labels are present in all kustomization files
check-label: check-docker
	@docker build --no-cache --pull --target checklabel -f build/builder/Dockerfile -t ${PROJECTNAME}:checklabel .

## lint: Run the policeman over the repository
lint: check-docker
	@docker build --no-cache --pull --target linter -f build/builder/Dockerfile -t ${PROJECTNAME}:local-lint .
	@$(MAKE) clean-lint

## deploy-all: Deploys all the components in the logging module (with curator-s3 and elasticsearch-triple)
deploy-all: deploy-curator-s3 deploy-elasticsearch-triple deploy-fluentd deploy-kibana deploy-cerebro

## deploy-curator: Deploys the `curator` component in the cluster
deploy-curator: check-kustomize check-kubectl
	@kustomize build katalog/curator | kubectl apply -f-

## deploy-curator-s3: Deploys the `curator-s3` component in the cluster
deploy-curator-s3: check-kustomize check-kubectl
	@kustomize build katalog/curator-s3 | kubectl apply -f-

## deploy-elasticsearch-single: Deploys the `elasticsearch-single` component in the cluster
deploy-elasticsearch-single: check-kustomize check-kubectl
	@kustomize build katalog/elasticsearch-single | kubectl apply -f-

## deploy-elasticsearch-triple: Deploys the `elasticsearch-triple` component in the cluster
deploy-elasticsearch-triple: check-kustomize check-kubectl
	@kustomize build katalog/elasticsearch-triple | kubectl apply -f-

## clean-%: Clean the container image resulting from another target. make build clean-build
clean-%:
	@docker rmi -f ${PROJECTNAME}:local-${*}
