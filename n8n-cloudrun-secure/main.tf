################################################################
# Titre: N8N on Cloud Run (Secure Private DB Access)
# Description : Déploiement Cloud Native de N8N pour le Lab
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# ==============================================================================
# Terraform : N8N on Cloud Run (Secure Private DB Access)
# Description : Déploiement Cloud Native de N8N pour le Lab
# ==============================================================================

resource "google_cloud_run_service" "n8n_app" {
  name     = "n8n-lab-app"
  location = var.region

  template {
    spec {
      containers {
        image = "n8nio/n8n:latest"
        ports {
          container_port = 5678
        }
        env {
          name  = "DB_TYPE"
          value = "postgresdb"
        }
        env {
          name  = "DB_POSTGRESDB_HOST"
          value = var.db_private_ip
        }
        env {
          name  = "DB_POSTGRESDB_USER"
          value = "n8n_admin"
        }
        # En prod, utiliser Secret Manager
        env {
          name  = "DB_POSTGRESDB_PASSWORD"
          value = var.db_password
        }
      }
    }

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_id
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Autoriser l'accès public au service via le Load Balancer (ou directement pour le Lab)
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.n8n_app.location
  project  = google_cloud_run_service.n8n_app.project
  service  = google_cloud_run_service.n8n_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
