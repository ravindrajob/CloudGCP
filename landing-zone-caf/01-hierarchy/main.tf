# ==============================================================================
# Terraform : GCP Resource Hierarchy (CAF Principles)
# Description : Découpage logique des environnements via Folders et Projets
# Référence : Google CAF - Resource Hierarchy & Isolation
# ==============================================================================

# 1. Structure de Dossiers (CAF: Governance & Isolation)
resource "google_folder" "common" {
  display_name = "Common-Infrastructure"
  parent       = "organizations/${var.org_id}"
}

resource "google_folder" "workloads" {
  display_name = "Workloads"
  parent       = "organizations/${var.org_id}"
}

# 2. Projets de Core Services (CAF: Operations Pillar)

# Projet Hub (Connectivité Centralisée)
resource "google_project" "hub_project" {
  name       = "lab-gcp-net-hub"
  project_id = "lab-gcp-net-hub-${var.random_suffix}"
  folder_id  = google_folder.common.name
}

# Projet Logging (Centralisation des logs d'audit)
resource "google_project" "logging_project" {
  name       = "lab-gcp-logging"
  project_id = "lab-gcp-logging-${var.random_suffix}"
  folder_id  = google_folder.common.name
}

# Projet Monitoring (Supervision centralisée SRE)
resource "google_project" "monitoring_project" {
  name       = "lab-gcp-monitoring"
  project_id = "lab-gcp-monitoring-${var.random_suffix}"
  folder_id  = google_folder.common.name
}

# 3. Projets Workloads (Spokes)
resource "google_project" "prod_project" {
  name       = "lab-gcp-prod"
  project_id = "lab-gcp-prod-${var.random_suffix}"
  folder_id  = google_folder.workloads.name
}
