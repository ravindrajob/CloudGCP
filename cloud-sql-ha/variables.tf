variable "region" {
  default = "europe-west1"
}

variable "vpc_id" {
  description = "Self-link du VPC network"
  type        = string
}

variable "db_password" {
  description = "Mot de passe root de la DB (doit provenir d'un Secret Manager en prod)"
  type        = string
  sensitive   = true
}
