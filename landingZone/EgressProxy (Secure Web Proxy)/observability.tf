################################################################
# Titre: Egress Proxy (SWP) - Observability
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# En GCP, l'observabilité du Secure Web Proxy s'active via TLS inspection et 
# les Cloud Audit Logs. Ce fichier simule l'activation des logs d'accès.

resource "google_project_iam_audit_config" "swp_audit" {
  project = var.project_id
  service = "networksecurity.googleapis.com"

  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
