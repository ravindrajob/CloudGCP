################################################################
# Titre: GCP ZeroTrust - Identity-Aware Proxy (IAP)
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Règle de Firewall autorisant uniquement les IP de Google IAP (35.235.240.0/20)
# Cela permet le SSH/RDP sécurisé sans IP publique.

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "fw-allow-iap-ssh-rdp"
  network = var.vpc_id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-enabled"]
  
  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Binding IAM : Qui a le droit de passer par l'IAP ?
resource "google_project_iam_member" "iap_tunnel_user" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "group:secops-admins@ravindra-job.com"
}
