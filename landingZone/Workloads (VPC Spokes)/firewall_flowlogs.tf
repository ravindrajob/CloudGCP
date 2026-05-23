################################################################
# Titre: Workloads - VPC Firewall Rules & Flow Logs
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# 1. VPC Flow Logs
resource "google_compute_subnetwork" "spoke_subnet" {
  name          = "snet-spoke-prod"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = var.vpc_id

  # Observability: Flow logs exportés vers Cloud Logging
  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# 2. Strict Firewall Rules (Micro-segmentation)
resource "google_compute_firewall" "allow_internal_web" {
  name    = "fw-allow-internal-web"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["10.0.0.0/8"]
  target_tags   = ["web-tier"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_web_to_db" {
  name    = "fw-allow-web-to-db"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_tags = ["web-tier"]
  target_tags = ["db-tier"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Deny by Default est géré nativement (implicit deny ingress)
