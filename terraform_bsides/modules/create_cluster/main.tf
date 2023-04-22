#################################################################################
# All roles to be added to the GKE service account
variable "roles_to_grant_to_service_account" {
  # Description: These are the roles we want to grant to service account: bsides-automation-nonprod-sa
  description = "IAM roles to grant to the service account"
  type        = list(string)
  # The below roles are all the permissions that we want the service account to have.
  default = [
    "roles/compute.imageUser",
    "roles/artifactregistry.reader", # Needed to query the GCR repo
    "roles/compute.viewer", # Needed to query the instance disk 
    "roles/storage.objectViewer", # Needed to view objects in GCS bucket 
    "roles/storage.objectCreator", # Needed to upload AVML file to GCS bucket
  ]
}
# Your cluster need a service account attached if you want it to be able to pull images in GCR
resource "google_service_account" "bsides-gke-sa" {
  account_id = var.gke_service_account_name
  display_name = "Service Account: bsides-gke-sa"
  description = "A service account for gke setup"
}

# Assign role bindings for all IAM roles
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member
resource "google_project_iam_member" "roles_to_grant_to_service_account_gke" {
  # Description: Creates IAM bindings (IAM Policy) for all roles related to bsides-automation-nonprod-sa
  # to have in our IR project: bsides-automation-nonprod
  project  = var.pid
  member   = "serviceAccount:${google_service_account.bsides-gke-sa.email}"
  for_each = toset(var.roles_to_grant_to_service_account)
  role     = each.value
}
#################################################################################
#data "google_client_config" "provider" {}
#################################################################################
# Define provider
provider "google" {
  project = var.pid
  region  = var.region
  zone    = var.zone
}
#################################################################################
# Define outputs for the other config
#################################################################################
output "gke_cluster_name" {
  value = google_container_cluster.bsides-gke-cluster.name
  #sensitive = true
}

output "primary_preemptible_nodes" {
  value = google_container_node_pool.primary_preemptible_nodes.instance_group_urls
}
