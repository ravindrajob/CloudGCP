################################################################
# Titre: Observability (Cloud Monitoring)
# Description : Monitoring centralisé, AI Audit et DNS Logging
# Auteur: Ravindra JOB | v1.3
# Update: 22/05/2026
################################################################

# Log Analytics Workspace (CAF: SRE Pillar)
resource "google_logging_project_bucket_config" "analytics_bucket" {
  project        = var.project_id
  location       = "global"
  retention_days = 30
  bucket_id      = "lab-gcp-log-analytics"
  enable_analytics = true
}

# Log Sinks pour les services critiques (Gouvernance)
resource "google_logging_project_sink" "critical_services_sink" {
  name        = "lab-gcp-critical-services-sink"
  destination = "logging.googleapis.com/${google_logging_project_bucket_config.analytics_bucket.id}"
  filter      = "resource.type=(gce_instance OR cloud_run_revision OR gke_cluster) OR protoPayload.serviceName=(aiplatform.googleapis.com OR dns.googleapis.com)"
  unique_writer_identity = true
}

# DNS Audit Logging (Security by Design)
resource "google_dns_policy" "dns_audit" {
  name                      = "lab-gcp-dns-audit-policy"
  enable_logging            = true
  networks {
    network_url = var.vpc_id
  }
  project = var.project_id
}
