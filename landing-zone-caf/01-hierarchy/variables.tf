variable "org_id" {
  type = string
}

variable "random_suffix" {
  description = "Suffixe pour garantir l'unicité des Project IDs"
  type        = string
  default     = "expert"
}
