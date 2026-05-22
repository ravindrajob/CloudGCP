################################################################
# Titre: variables.tf
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
variable "region" {
  default = "europe-west1"
}

variable "cloud_run_service_name" {
  description = "Nom du service Cloud Run à exposer"
  type        = string
}
