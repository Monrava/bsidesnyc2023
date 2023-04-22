#################################################################################
# Resources to be shared from other config
#################################################################################
# Data object from the other config and remote state: create_cluster
data "terraform_remote_state" "create_cluster" {
  backend = "local"
  config = {
    #path = "../create_cluster/terraform.tfstate"
    path = "../../terraform.tfstate"
  }
}

# Data object of the cluster that we'll use to apply the kubernetes provider config
data "google_container_cluster" "zeroday_cluster" {
  name      = data.terraform_remote_state.create_cluster.outputs.gke_cluster_name
  #name      = module.create_cluster.output.gke_cluster_name.value
  location  = var.zone
  project   = var.pid
}

# Data object of the google cloud provider that we'll use to apply the kubernetes provider config
data "google_client_config" "default" {
}

# Resulting config of: data "google_client_config" and data "google_container_cluster"
provider "kubernetes" {
  host                      = "https://${data.google_container_cluster.zeroday_cluster.endpoint}"
  token                     = data.google_client_config.default.access_token
  cluster_ca_certificate    = base64decode(
    data.google_container_cluster.zeroday_cluster.master_auth[0].cluster_ca_certificate
    )
}

#################################################################################
# Define outputs for the other config
#################################################################################
output "pod_name_avml" {
  value = kubernetes_pod.pod_node_affinity_memory_dump.metadata[0].name
}

output "pod_namespace_avml" {
  value = kubernetes_namespace.namespace_bsidesnyc2023_mem_dump.metadata[0].name
}

output "pod_name_att" {
  value = kubernetes_pod.pod_node_affinity_attacker_pod.metadata[0].name
}

output "pod_namespace_att" {
  value = "default"
}
