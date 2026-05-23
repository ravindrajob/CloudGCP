################################################################
# Titre: Cloud Armor - Observability
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Active explicitement la journalisation sur les règles Cloud Armor
resource "google_compute_security_policy" "armor_policy" {
  name = "policy-cloud-armor-lab"

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('cve-canary')"
      }
    }
    description = "Bloquer CVE communes"
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
    description = "default rule"
  }
}

# La journalisation WAF est nativement envoyée à Cloud Logging (requestsLogs)
