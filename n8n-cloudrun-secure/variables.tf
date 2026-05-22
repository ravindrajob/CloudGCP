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
