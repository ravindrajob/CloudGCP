################################################################
# Titre: AI Agent Security Gateway (A2A) - Variables
# Description : Définition des variables pour le module A2A
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 15/10/2025 [v1.0 | RJ]
################################################################

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west1"
}
