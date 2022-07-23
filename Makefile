.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

# Setup gcloud projet config and authenticate to Google Cloud API
.PHONY: gcloud/setup
gcloud/setup:
	@echo "\n== gcloud/setup\n"
	gcloud config set account ${GCP_ACCOUNT}
	gcloud config set project ${GCP_DEV_PROJECT}
	gcloud auth login
