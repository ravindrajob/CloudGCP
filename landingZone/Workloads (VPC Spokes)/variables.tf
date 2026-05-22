################################################################
# Titre: variables.tf
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
variable "prod_project_id" {
  type = string
}

variable "hub_project_id" {
  type = string
}

variable "ncc_hub_id" {
  description = "ID du Hub NCC central (Layer 02)"
  type        = string
}

variable "region" {
  default = "europe-west1"
}
