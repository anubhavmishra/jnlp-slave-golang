BUILD_ID := $(shell git rev-parse --short HEAD 2>/dev/null || echo no-commit-id)
IMAGE_NAME := anubhavmishra/jnlp-slave-golang

.DEFAULT_GOAL := help
help: ## Show available targets
	@cat Makefile* | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-docker: ## Build the docker image
	docker build -t $(IMAGE_NAME):$(BUILD_ID) .
	docker tag $(IMAGE_NAME):$(BUILD_ID) $(IMAGE_NAME):latest

push: ## Push the docker image to docker hub with tags 'latest' & 'BUILD_ID'
	docker push $(IMAGE_NAME):$(BUILD_ID)
	docker push $(IMAGE_NAME):latest