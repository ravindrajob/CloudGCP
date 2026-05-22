################################################################
# Titre: Global LB7 (HTTPS) & Cloud Armor WAF
# Description : Exposition sécurisée du domaine ravindra-job.com sur GCP
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# ==============================================================================
# Terraform : Global LB7 (HTTPS) & Cloud Armor WAF
# Description : Exposition sécurisée du domaine ravindra-job.com sur GCP
# ==============================================================================

# Adresse IP Globale
resource "google_compute_global_address" "lb_ip" {
  name = "lab-gcp-lb-ip"
}

# Cloud Armor Policy (WAF)
resource "google_compute_security_policy" "policy" {
  name = "lab-gcp-waf-policy"

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }
    description = "Bloquer SQL Injection"
  }

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Autoriser le reste du trafic par défaut"
  }
}

# Backend Service pour Cloud Run
resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = "lab-gcp-serverless-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.cloud_run_service_name
  }
}

resource "google_compute_backend_service" "backend" {
  name            = "lab-gcp-backend-n8n"
  protocol        = "HTTP"
  port_name       = "http"
  timeout_sec     = 30
  security_policy = google_compute_security_policy.policy.id

  backend {
    group = google_compute_region_network_endpoint_group.serverless_neg.id
  }
}

# URL Map & Proxy HTTPS
resource "google_compute_url_map" "url_map" {
  name            = "lab-gcp-url-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "lab-gcp-https-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.cert.id]
}

# Certificat SSL Managé par Google
resource "google_compute_managed_ssl_certificate" "cert" {
  name = "lab-gcp-cert"
  managed {
    domains = ["n8n.ravindra-job.com"]
  }
}

# Forwarding Rule
resource "google_compute_global_forwarding_rule" "https_rule" {
  name       = "lab-gcp-https-forwarding-rule"
  target     = google_compute_target_https_proxy.https_proxy.id
  port_range = "443"
  ip_address = google_compute_global_address.lb_ip.address
}
