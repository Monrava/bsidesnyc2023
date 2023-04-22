resource "google_container_cluster" "bsides-gke-cluster" {
  name                        = "bsides-gke-cluster"
  location                    = var.zone
  # Remeber to specify VPC.
  network                     = var.vpc
  remove_default_node_pool    = true
  enable_intranode_visibility = false
  initial_node_count          = 1

  #Configure node.
  node_config {
    preemptible     = true
    machine_type    = var.compute_engine_type
#    tags            = ["bsides-https-access-rule", "bsides-ssh-access-rule"]
    tags            = [google_compute_firewall.bsides-access-rule.name]

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.bsides-gke-sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      team = var.team_name
    }
  }
}
#################################################################################
provider "kubernetes" {
  config_path = "~/.kube/config"
}
#################################################################################
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name              = "bsides-gke-node-pool"
  location          = var.zone
  cluster           = google_container_cluster.bsides-gke-cluster.id
  node_count        = 1

  node_config {
    preemptible     = true
    machine_type    = var.compute_engine_type
    tags            = [google_compute_firewall.bsides-access-rule.name]
    

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.bsides-gke-sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    labels = {
      team = var.team_name
    }
  }
}
