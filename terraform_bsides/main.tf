module "avml_resources" {
    source  = "./modules/create_avml_resources"
}

module "gke_cluster" {
    source  = "./modules/create_cluster"
    #depends_on=[module.avml_resources]
}

# module "gke_resources" {
#     source  = "./modules/create_resources"
#     #vpc_id     = module.network.vpc_id 
#     #gke_name = var.gke_name
#     #gke_name = module.gke_cluster.gke_cluster_name.value
#     #depends_on=[module.gke_cluster.gke_cluster_name]
# }