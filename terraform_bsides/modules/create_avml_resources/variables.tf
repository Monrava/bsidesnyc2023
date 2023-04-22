variable "new_service_account_name" {
   type        = string
   description = "New service account name."
   default = "tf-avml-sa"
}

variable "pid" {
   type        = string
   description = "GCP project."
   default = "bsidesnyc2023"
}

variable "region" {
   type        = string
   description = "GCP region where resources are created."
   default = "us-west1"
}

variable "zone" {
   type        = string
   description = "GCP zone in the var.region where resources are created."
   default = "us-west1-a"
}

variable "vpc" {
   type        = string
   description = "GCP project VPC."
   default = "default"
}

variable "base_image" {
   type        = string
   description = "Base image for compute engines."
   default = "debian-cloud/debian-10"
}

variable "disk_size" {
   type         = string
   description  = "Base image for compute engines."
   default      = "500"
}

variable "installation_path" {
   type        = string
   description = "Base image for compute engines."
   #default = "ENTER_YOUR_INSTALLATION_PATH_HERE"
}

variable "machine_type" {
   type        = string
   description = "Base image for compute engines."
   #default = "e2-standard-32"
   default = "e2-standard-8"
}

variable "installation_script" {
   type        = string
   description = "Base image for compute engines."
   default = "install_dependencies.sh"
}

variable "installation_script_bucket_path" {
   type        = string
   description = "The path to where installation scripts are stored in the."
   default = "avml_instance_scripts"
}

variable "installation_user" {
   type        = string
   description = "The path to where installation scripts are stored in the."
   #default = "ENTER_YOUR_USERNAME_HERE"
}

variable "volatility_script" {
   type        = string
   description = "The path to where installation scripts are stored in the."
   default = "volatility_commands.sh"
}