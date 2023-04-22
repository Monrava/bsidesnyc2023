variable "pid" {
   type        = string
   description = "GCP project."
   default = "bsidesnyc2023"
}

variable "zone" {
   type        = string
   description = "GCP zone in the var.region where resources are created."
   default = "us-west1-a"
}
