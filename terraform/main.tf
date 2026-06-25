resource "kind_cluster" "default" {
  name           = var.cluster_name
  wait_for_ready = true
}
