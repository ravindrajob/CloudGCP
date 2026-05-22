################################################################
# Titre: variables.tf
# Description : Composant technique du Lab de Simulation
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
variable "org_id" {
  type = string
}

variable "target_folder_id" {
  description = "ID du dossier parent pour appliquer la politique"
  type        = string
}
