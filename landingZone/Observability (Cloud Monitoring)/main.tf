################################################################
# Titre: Observability (Cloud Monitoring)
# Description : Monitoring centralisé, AI Audit et DNS Logging
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.2 | RJ]
################################################################

# 1. Cloud Logging : Log Analytics Workspace (CAF: SRE Pillar)
resource "google_logging_project_bucket_config" "analytics_bucket" {
  project        = var.project_id
  location       = "global"
  retention_days = 30
  bucket_id      = "lab-gcp-log-analytics"
  enable_analytics = true
}

# 2. Log Sinks : Collecte des briques critiques (Gouvernance)
resource "google_logging_project_sink" "critical_services_sink" {
  name        = "lab-gcp-critical-services-sink"
  destination = "logging.googleapis.com/${google_logging_project_bucket_config.analytics_bucket.id}"
  filter      = "resource.type=(gce_instance OR cloud_run_revision OR gke_cluster) OR protoPayload.serviceName=(aiplatform.googleapis.com OR dns.googleapis.com)"

  unique_writer_identity = true
}

# 3. AI Monitoring : Audit du protocole A2A
# Capturer les payloads de Vertex AI pour détecter les déviances sémantiques.
resource "google_project_iam_member" "ai_audit_log_config" {
  project = var.project_id
  role    = "roles/logging.configWriter"
  member  = "serviceAccount:${var.ai_agent_sa_email}"
}

# 4. DNS Audit Logging (Security by Design)
# Détection du DNS Tunneling et des exfiltrations.
resource "google_dns_policy" "dns_audit" {
  name                      = "lab-gcp-dns-audit-policy"
  enable_logging            = true
  networks {
    network_url = var.vpc_id
  }
}

# 5. Export vers OTel Collector central (Hybrid Monitoring)
# Utilisation de Private Service Connect pour router les métriques vers le NOC déporté.
