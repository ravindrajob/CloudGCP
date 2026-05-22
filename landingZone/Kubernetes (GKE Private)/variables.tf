################################################################
# Titre: GKE Module - Variables
# Description : Paramétrage du cluster Kubernetes Hardened
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

variable "project_id" { type = string }
variable "region" { default = "europe-west1" }
variable "network_id" { type = string }
variable "subnetwork_id" { type = string }
variable "admin_cidr" { 
  description = "Plage IP autorisée à administrer le cluster"
  default     = "0.0.0.0/0" # À restreindre en prod
}
variable "service_account_email" { type = string }
