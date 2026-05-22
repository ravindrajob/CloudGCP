variable "region" {
  default = "europe-west1"
}

variable "cloud_run_service_name" {
  description = "Nom du service Cloud Run à exposer"
  type        = string
}
