# Terraform bootstraps Argo CD; Argo CD then runs everything else from Git.
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.1.2"

  timeout = 600 # Argo CD has several components; give the first install room

  # Single-node local cluster: disable Dex SSO to keep it lean
  set = [
    {
      name  = "dex.enabled"
      value = "false"
    }
  ]
}
