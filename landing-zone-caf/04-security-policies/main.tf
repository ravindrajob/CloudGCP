# ==============================================================================
# Terraform : Hierarchical Firewall Policies (Zéro Trust)
# Description : Politiques de sécurité globales (Deny by Default)
# Référence : Google CAF - Network Security & Shared Policies
# Référence : CNCF - Zéro Trust Network Architecture (ZTNA)
# ==============================================================================

# 1. Politique de Pare-feu Hiérarchique (Appliquée au dossier racine du Lab)
resource "google_compute_organization_security_policy" "hardened_policy" {
  display_name = "lab-gcp-global-security-policy"
  parent       = "organizations/${var.org_id}"
  type         = "FIREWALL"
}

# 2. Règle "Deny All" Ingress (CNCF Zéro Trust)
# Bloque absolument tout par défaut.
resource "google_compute_organization_security_policy_rule" "deny_all" {
  policy_id      = google_compute_organization_security_policy.hardened_policy.id
  priority       = 2147483647 # Priorité la plus basse
  action         = "deny"
  direction      = "INGRESS"
  match {
    config {
      src_ip_ranges = ["0.0.0.0/0"]
    }
  }
  description    = "CNCF Compliance: Global Deny all Ingress"
}

# 3. Règle "Allow Monitoring" (CAF Operations)
# Autorise les sondes Prometheus/Blackbox internes (simulation).
resource "google_compute_organization_security_policy_rule" "allow_monitoring" {
  policy_id      = google_compute_organization_security_policy.hardened_policy.id
  priority       = 1000
  action         = "allow"
  direction      = "INGRESS"
  match {
    config {
      src_ip_ranges = ["10.100.0.0/24"] # Transit Subnet (Hub)
    }
  }
  description    = "CAF Pillar: Allow internal SRE monitoring from Hub"
}

# 4. Association au dossier racine (CAF: Governance)
resource "google_compute_organization_security_policy_association" "root_association" {
  name          = "lab-gcp-policy-association"
  attachment_id = var.target_folder_id
  policy_id     = google_compute_organization_security_policy.hardened_policy.id
}
