################################################################
# Titre: GCP Cloud Secure Web Proxy (SWP - Envoy Powered)
# Description : Proxy explicite pour le contrôle granulaire des flux sortants (Egress)
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 25/11/2025 [v1.0 | RJ]
################################################################

# 1. Subnet Dédié pour le Proxy (CAF: Network Security)
# GCP requiert un subnet spécifique avec le rôle REGIONAL_MANAGED_PROXY pour Envoy.
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "lab-gcp-proxy-only-subnet"
  ip_cidr_range = "10.129.0.0/23"
  region        = var.region
  network       = var.vpc_id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  project       = var.project_id
}

# 2. Liste d'URLs Autorisées (Whitelist)
# Contrairement à un firewall L3/L4, on filtre ici sur les FQDN (L7).
resource "google_network_security_url_lists" "allowed_urls" {
  name        = "lab-gcp-allowed-urls"
  description = "Whitelists des domaines autorisés pour le Lab"
  project     = var.project_id
  location    = var.region
  values      = [
    "*.ravindra-job.com",
    "github.com",
    "*.githubusercontent.com",
    "*.googleapis.com"
  ]
}

# 3. Politique de Sécurité du Gateway
resource "google_network_security_gateway_security_policy" "swp_policy" {
  name        = "lab-gcp-swp-policy"
  project     = var.project_id
  location    = var.region
  description = "Politique Egress paranoïaque : Deny by default"
}

# 4. Règle d'autorisation basée sur la Whitelist
resource "google_network_security_gateway_security_policy_rule" "allow_whitelist" {
  name                    = "allow-whitelist-rule"
  project                 = var.project_id
  location                = var.region
  gateway_security_policy = google_network_security_gateway_security_policy.swp_policy.name
  priority                = 1000
  enabled                 = true
  description             = "Autoriser uniquement les domaines de la whitelist"
  
  # Condition sémantique
  session_matcher = "host() == url_lists.allowed_urls"
  basic_profile   = "ALLOW"
}

# 5. Instance du Gateway (Le Proxy Envoy Managé)
resource "google_network_services_gateway" "swp_gateway" {
  name     = "lab-gcp-secure-web-proxy"
  project  = var.project_id
  location = var.region
  type     = "SECURE_WEB_PROXY"
  
  addresses = [var.proxy_ip]
  ports     = [443]
  scope     = "global-egress-scope" # Signal pour le filtrage sortant global
  
  network         = var.vpc_id
  subnetwork      = google_compute_subnetwork.proxy_subnet.id
  gateway_security_policy = google_network_security_gateway_security_policy.swp_policy.id
  
  delete_contents_on_destroy = true
}
