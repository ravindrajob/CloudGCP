################################################################
# Titre: Landing Zone Factory (Vending Machine)
# Description : Usine de création de Projets GCP (Cloud Foundation)
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

# Création industrialisée de Projets GCP attachés au bon Folder
resource "google_project" "new_landing_zone" {
  name            = "lz-${var.environment}-${var.business_unit}"
  project_id      = "lz-${var.environment}-${var.business_unit}-${var.random_suffix}"
  folder_id       = var.target_folder_id
  billing_account = var.billing_account_id

  auto_create_network = false # On gère le réseau manuellement (Shared VPC / NCC)

  labels = {
    environment   = var.environment
    business_unit = var.business_unit
    cost_center   = var.cost_center
  }
}

# Activation automatique des APIs vitales
resource "google_project_service" "core_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ])

  project            = google_project.new_landing_zone.project_id
  service            = each.key
  disable_on_destroy = false
}
