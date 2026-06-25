# gitops-platform-lab

A local, zero-cost GitOps Kubernetes platform — provisioned with Terraform, run with Argo CD.

**Status:** work in progress (building in phases)

## What it is

Terraform bootstraps a local `kind` cluster and Argo CD; Argo CD then syncs the rest
(a Go demo API plus Prometheus/Grafana observability) from this repo. CI validates
everything on every push. The whole thing runs in Docker on a laptop.

## Quickstart

    make up      # build the cluster + platform
    make down    # tear it all down

More detail lands in the final polish phase.
