IMAGE   := go-api:0.1.0
CLUSTER := gitops-platform

.DEFAULT_GOAL := help

.PHONY: help build up down argo-password

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'

build: ## Build the go-api container image
	docker build -t $(IMAGE) app

up: build ## Create cluster + Argo CD, load image, bootstrap GitOps
	terraform -chdir=terraform init
	terraform -chdir=terraform apply -auto-approve
	kind load docker-image $(IMAGE) --name $(CLUSTER)
	kubectl apply -f gitops/root-app.yaml

down: ## Destroy the cluster and everything in it
	terraform -chdir=terraform destroy -auto-approve

argo-password: ## Print the Argo CD admin password
	@kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo
