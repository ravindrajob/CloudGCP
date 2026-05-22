################################################################
# Titre: GCP Secure Web Proxy - Variables
# Description : Variables pour le filtrage L7 Envoy
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 25/11/2025 [v1.0 | RJ]
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

variable "vpc_id" {
  description = "Self-link du VPC network"
  type        = string
}

variable "proxy_ip" {
  description = "Adresse IP interne réservée pour le proxy"
  type        = string
}
