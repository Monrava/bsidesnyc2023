# Output for module avml_resources
output "gcp_project" {
  value = module.avml_resources.gcp_project
}

output "zone" {
  value = module.avml_resources.zone
}

output "gcp_instance" {
  value = module.avml_resources.gcp_instance
}

output "gcp_instance_avml_sa" {
  value = module.avml_resources.gcp_instance_avml_sa
}

output "gcp_avml_bucket" {
  value = module.avml_resources.gcp_avml_bucket
}

output "volatility_script" {
  value = module.avml_resources.volatility_script
}

# Output for module gke_cluster
output "gke_cluster_name" {
  value = module.gke_cluster.gke_cluster_name
}


# # Output for module gke_resources
# output "pod_name_avml" {
#   value = module.gke_resources.pod_name_avml
# }

# output "pod_namespace_avml" {
#   value = module.gke_resources.pod_namespace_avml
# }

# output "pod_name_att" {
#   value = module.gke_resources.pod_name_att
# }

# output "pod_namespace_att" {
#   value = module.gke_resources.pod_namespace_att
# }
