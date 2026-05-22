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

variable "db_private_ip" {
  description = "Adresse IP interne de Cloud SQL"
  type        = string
}

variable "vpc_connector_id" {
  description = "ID du VPC Access Connector"
  type        = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
