################################################################
# Titre: GCP Hardened Firewall Policies - Variables
# Description : Variables pour le module de sécurité réseau
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 24/11/2025 [v1.0 | RJ]
################################################################

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "vpc_id" {
  description = "Self-link du VPC pour l'association de la politique"
  type        = string
}
