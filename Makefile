.ONESHELL:
SHELL := /bin/bash
.SHELLFLAGS := -o pipefail -euc

DOCKER_IMAGE_TAG = 'dbt-local'
WORKING_DIR = 'dbt_example'

##############################
# Docker
##############################
# build Docker image
.PHONY: docker/build
docker/build:
	@echo "\n== docker/build\n"
	docker build -t $(DOCKER_IMAGE_TAG) .

# run Docker image mounting the current directory
.PHONY: docker/run
docker/run:
	@echo "\n== docker/run\n"
	docker run -it --rm \
		--mount src="$$(pwd)",target=/workspaces,type=bind \
		--mount src="${HOME}/.config/gcloud",target=/root/.config/gcloud,type=bind \
		-w /workspaces/$(WORKING_DIR) \
		--entrypoint /bin/bash \
		$(DOCKER_IMAGE_TAG)

.PHONY: docker/dbt
docker/dbt:
	@echo "\n== docker/dbt\n"
	docker run -it --rm \
		--mount src="$$(pwd)",target=/workspaces,type=bind \
		--mount src="${HOME}/.config/gcloud",target=/root/.config/gcloud,type=bind \
		-w /workspaces/$(WORKING_DIR) \
		--env GCP_DEV_PROJECT=${GCP_DEV_PROJECT} \
		--entrypoint dbt \
		$(DOCKER_IMAGE_TAG) \
		$(ARGS)

##############################
# gcloud
##############################
# Setup gcloud projet config and authenticate to Google Cloud API
.PHONY: gcloud/setup
gcloud/setup:
	@echo "\n== gcloud/setup\n"
	gcloud config set account ${GCP_ACCOUNT}
	gcloud config set project ${GCP_DEV_PROJECT}
	gcloud auth login

.PHONY: gcloud/activate
gcloud/activate:
	@echo "\n== gcloud/login\n"
	gcloud config configurations activate ${GCP_CONFIG_NAME}
	gcloud config configurations list
