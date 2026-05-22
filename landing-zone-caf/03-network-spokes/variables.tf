variable "prod_project_id" {
  type = string
}

variable "hub_project_id" {
  type = string
}

variable "ncc_hub_id" {
  description = "ID du Hub NCC central (Layer 02)"
  type        = string
}

variable "region" {
  default = "europe-west1"
}
