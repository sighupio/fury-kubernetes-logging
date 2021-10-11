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

check-variable-%: # detection of undefined variables.
	@[[ "${${*}}" ]] || (echo '*** Please define variable `${*}` ***' && exit 1)

check-%: # detection of required software.
	@which ${*} > /dev/null || (echo '*** Please install `${*}` ***' && exit 1)

## lint: Run the policeman over the repository
lint: check-docker
	@docker run  --rm -v $(pwd):/app -w /app quay.io/sighup/policeman

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
