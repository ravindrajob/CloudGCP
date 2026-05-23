################################################################
# Titre: Self-Service - GCP App Pattern Standard
# Description: Variables d'entrée pour GCP
# Auteur: Ravindra JOB | v2.0
################################################################

variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "shutdown_schedule" {
  description = "CRON format (ex: '0 20 * * *')"
  type        = string
  default     = "0 20 * * *"
}

variable "target_folder_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "region" {
  type = string
  default = "europe-west1"
}

variable "random_suffix" {
  type = string
  default = "abcd"
}

variable "enable_gke" {
  type    = bool
  default = false
}

variable "enable_database" {
  type    = bool
  default = false
}
