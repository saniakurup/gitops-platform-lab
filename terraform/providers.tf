provider "kind" {}

# The Helm provider talks to the cluster the kind resource created,
# using its exported credentials (known in state after Phase 1).
provider "helm" {
  kubernetes = {
    host                   = kind_cluster.default.endpoint
    client_certificate     = kind_cluster.default.client_certificate
    client_key             = kind_cluster.default.client_key
    cluster_ca_certificate = kind_cluster.default.cluster_ca_certificate
  }
}
