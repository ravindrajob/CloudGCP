################################################################
# Titre: GCP AISecurity - Vertex AI via Private Service Connect
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Zéro Trust : L'accès à Vertex AI et aux Google APIs doit rester dans le VPC
# via Private Service Connect (PSC)

resource "google_compute_global_address" "psc_ai_ip" {
  name         = "ip-psc-vertex-ai"
  project      = var.project_id
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = var.vpc_id
  address      = "10.200.0.50"
}

resource "google_compute_global_forwarding_rule" "psc_ai_rule" {
  name                  = "fwd-psc-vertex-ai"
  project               = var.project_id
  target                = "all-apis"
  network               = var.vpc_id
  ip_address            = google_compute_global_address.psc_ai_ip.id
  load_balancing_scheme = ""
}

# (Optionnel) API Gateway pour limiter l'utilisation du LLM (A2A rate limiting)
