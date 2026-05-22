################################################################
# Titre: variables.tf
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west1"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}
