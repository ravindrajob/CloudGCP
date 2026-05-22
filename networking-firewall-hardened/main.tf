################################################################
# Titre: GCP Hardened Firewall Policies (Zéro Trust)
# Description : Implémentation d'une architecture réseau "Deny by Default"
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 24/11/2025 [v1.0 | RJ]
################################################################

# 1. Politique de Pare-feu Réseau Globale (Global Network Firewall Policy)
# Référence CAF : Sécurité réseau centralisée et immuable.
resource "google_compute_network_firewall_policy" "hardened_policy" {
  name        = "lab-gcp-hardened-fw-policy"
  description = "Politique Zéro Trust - Deny by Default"
  project     = var.project_id
}

# ------------------------------------------------------------------------------
# RÈGLES DE SÉCURITÉ "DENY ALL" (SOCLE ZÉRO TRUST)
# ------------------------------------------------------------------------------

# 2. Deny All Ingress (Entrant)
resource "google_compute_network_firewall_policy_rule" "deny_all_ingress" {
  firewall_policy = google_compute_network_firewall_policy.hardened_policy.name
  priority        = 65535 # Priorité la plus basse
  action          = "deny"
  direction       = "INGRESS"
  match {
    src_ip_ranges = ["0.0.0.0/0"]
  }
  description     = "Zéro Trust Foundation: Global Deny all Ingress"
  project         = var.project_id
}

# 3. Deny All Egress (Sortant)
resource "google_compute_network_firewall_policy_rule" "deny_all_egress" {
  firewall_policy = google_compute_network_firewall_policy.hardened_policy.name
  priority        = 65534
  action          = "deny"
  direction       = "EGRESS"
  match {
    dest_ip_ranges = ["0.0.0.0/0"]
  }
  description     = "OPSEC: Global Deny all Egress to prevent exfiltration"
  project         = var.project_id
}

# ------------------------------------------------------------------------------
# FLUX AUTORISÉS (MICRO-SEGMENTATION)
# ------------------------------------------------------------------------------

# 4. Autoriser l'accès de gestion via IAP (Identity-Aware Proxy)
# Permet de se connecter en SSH sans IP publique.
resource "google_compute_network_firewall_policy_rule" "allow_iap" {
  firewall_policy = google_compute_network_firewall_policy.hardened_policy.name
  priority        = 1000
  action          = "allow"
  direction       = "INGRESS"
  match {
    src_ip_ranges = ["35.235.240.0/20"] # Plage IP fixe de Google IAP
    layer4_configs {
      ip_protocol = "tcp"
      ports       = ["22", "3389"]
    }
  }
  description     = "CAF Best Practice: Secure management access via IAP"
  project         = var.project_id
}

# 5. Flux Monitoring SRE (Prometheus / Blackbox)
resource "google_compute_network_firewall_policy_rule" "allow_monitoring" {
  firewall_policy = google_compute_network_firewall_policy.hardened_policy.name
  priority        = 1100
  action          = "allow"
  direction       = "INGRESS"
  match {
    src_ip_ranges = ["10.100.0.0/24"] # Transit/SRE Subnet
    layer4_configs {
      ip_protocol = "tcp"
    }
  }
  description     = "SRE Ops: Allow internal monitoring probes"
  project         = var.project_id
}

# 6. Autoriser le trafic ICMP Interne (Diagnostic)
resource "google_compute_network_firewall_policy_rule" "allow_internal_icmp" {
  firewall_policy = google_compute_network_firewall_policy.hardened_policy.name
  priority        = 2000
  action          = "allow"
  direction       = "INGRESS"
  match {
    src_ip_ranges = ["10.0.0.0/8"] # Réseau interne uniquement
    layer4_configs {
      ip_protocol = "icmp"
    }
  }
  description     = "Diagnostic: Allow internal ICMP"
  project         = var.project_id
}

# ------------------------------------------------------------------------------
# ASSOCIATION AU VPC
# ------------------------------------------------------------------------------

resource "google_compute_network_firewall_policy_association" "vpc_assoc" {
  name              = "hardened-policy-association"
  attachment_target = var.vpc_id
  firewall_policy   = google_compute_network_firewall_policy.hardened_policy.name
  project           = var.project_id
}
