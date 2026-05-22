################################################################
# Titre: variables.tf
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "org_id" {
  description = "GCP Organization ID (pour restriction IAM)"
  type        = string
}
