################################################################
# Titre: Self-Service - GCP App Pattern Standard
# Description: Modèle "Golden Path" pour GCP
# Auteur: Ravindra JOB | v2.0
################################################################

# 1. Service Project rattaché au Shared VPC
resource "google_project" "app_project" {
  name            = "${var.app_name} ${var.environment}"
  project_id      = "${var.app_name}-${lower(var.environment)}-${var.random_suffix}"
  folder_id       = var.target_folder_id
  billing_account = var.billing_account_id

  labels = {
    environment = var.environment
    managed_by  = "self-service"
    auto_stop   = var.environment == "Prod" ? "false" : "true"
  }
}

# 2. CMEK Dédié au projet
resource "google_kms_key_ring" "app_keyring" {
  name     = "kr-${var.app_name}"
  location = var.region
  project  = google_project.app_project.project_id
}

resource "google_kms_crypto_key" "app_cmek" {
  name            = "key-${var.app_name}"
  key_ring        = google_kms_key_ring.app_keyring.id
  rotation_period = "2592000s"
}

# 3. Workload Identity Federation (Pour le CI/CD du développeur)
resource "google_service_account" "app_deployer" {
  account_id   = "sa-deployer-${var.app_name}"
  display_name = "SA pour le pipeline CI/CD"
  project      = google_project.app_project.project_id
}

# 4. Modules Optionnels
module "gke_cluster" {
  source = "../../landingZone/Kubernetes (GKE Private)"
  count  = var.enable_gke ? 1 : 0
  
  project_id = google_project.app_project.project_id
}

module "cloud_sql" {
  source = "../../landingZone/Workloads (VPC Spokes)" 
  count  = var.enable_database ? 1 : 0
  
  project_id = google_project.app_project.project_id
}
