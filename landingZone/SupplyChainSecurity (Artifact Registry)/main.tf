################################################################
# Titre: Supply Chain Security (Artifact Registry)
# Description : Registre KMS, scan de vulnérabilités auto
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

resource "google_artifact_registry_repository" "secure_repo" {
  location      = "europe-west1"
  repository_id = "lab-secure-docker-repo"
  description   = "Registre Docker Sécurisé avec KMS"
  format        = "DOCKER"

  kms_key_name = var.kms_key_name
}

# Activation de l'API de Container Scanning
resource "google_project_service" "container_scanning" {
  project = var.project_id
  service = "containerscanning.googleapis.com"
}
