# bsidesnyc2023
Demo setup for BSidesNYC2023

## Description
  This repository sets up a GKE cluster, forensic GCE, cloud storage bucket and associated IAM roles and permissions in a default GCP project.
  You can then create an AVML container with the tools to conduct a memory dump and also an attacker container with a few demo scripts.

## Terraform:
  This sections explains how to setup your Terraform environment to create the needed resources.
  ### Install Terraform:
   https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started
  ### Instantiate: 
  ```bash
  $ terraform init
  ```
  
  ### Update environment:
  Modify variables.tf for all terraform folders to reflect your GCP environment.    
  Variables to add: 
  ```bash
  var.pid
  var.installation_user
  var.installation_path
  ```

## Create virtual environment and install dependencies
```bash
$ python3 -m venv .venv
$ source .venv/bin/activate
(.venv)$ pip3 install -r requirements.txt
```
## Authenticate to GCP
```bash
$ gcloud auth application-default login
```
### Activate GCP ssh key permissions: 
```bash
$ ssh-add ~/.ssh/google_compute_engine
```

## Add permissions 
### (Unless already assinged to IAM principle):
Add the following permissions to your gcloud principle in your GCP project.
```  	
Project IAM Admin				
Service Account Admin
Service Account Token Creator
```
## Enable billing acccount
### (Unless active):
Check your CPU limitations based on the resources you want to create:
  https://cloud.google.com/billing/docs/how-to/modify-project

## Enable GCP project services:
  https://cloud.google.com/migrate/containers/docs/config-dev-env
  https://console.cloud.google.com/apis/dashboard?project=bsidesnyc2023
```bash
$ gcloud services enable servicemanagement.googleapis.com servicecontrol.googleapis.com cloudresourcemanager.googleapis.com compute.googleapis.com container.googleapis.com containerregistry.googleapis.com cloudbuild.googleapis.com
```
## Create GCR images:
```bash
$ export gcp_project=YOUR_GCP_PROJECT_NAME
$ export zone=ZONE

$ docker build -t gcr.io/$gcp_project/avml_image:latest -f image_files/avml/Dockerfile .

$ docker build -t gcr.io/$gcp_project/attacker_image:latest  -f image_files/attacker/Dockerfile .
```
## Push GCR images:
```bash
$ docker push  gcr.io/$gcp_project/avml_image:latest  
$ docker push  gcr.io/$gcp_project/attacker_image:latest 
```
## Create Terraform GKE cluster, resources and instance:
```bash
$ cd ./bsidesnyc2023/terraform_bsides
$ terraform apply -lock=true -auto-approve
$ terraform output  >> terraform_resources.conf
```

## Access resources:
```bash
$ gcloud container clusters get-credentials bsides-gke-cluster --zone $zone --project $gcp_project
$ kubectl exec --stdin --tty pod-node-affinity-bsides-attacker-pod --namespace default -- /bin/bash  
```
Run:
```bash
$ ./actions.sh 
```
And other commands you want and then exit the shell.
When you log back in, you should see the bash history updated by typing:
```bash
$ history
```

## Run script: 
python3 memory_collection.py --gke_node_name GKE_NODE_NAME
E.g.
```bash
$ python3 memory_collection_bsides.py --gke_node_name gke-bsides-gke-clust-bsides-gke-node--f72013e9-jm9c
```
  
## Access forensic compute engine:
Once the script finishes, access the AVML instance here.
```bash
$ gcloud compute ssh "avml-instance" --tunnel-through-iap
```
