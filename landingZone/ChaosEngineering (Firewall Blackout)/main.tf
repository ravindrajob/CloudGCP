################################################################
# Titre: ChaosEngineering (Firewall Blackout)
# Description : Simulation de panne réseau régionale via Firewall "Deny-All"
# Auteur: Ravindra JOB | v1.3
# Update: 22/05/2026
################################################################

# 1. Règle de Chaos (Priority 0 - Imparable)
# Référence CAF : Test de résilience et de bascule automatique
resource "google_compute_firewall" "chaos_blackout" {
  name    = "lab-gcp-chaos-firewall-blackout"
  network = var.vpc_id
  project = var.project_id

  # Priorité absolue pour écraser toutes les autres règles (Deny All)
  priority = 0

  deny {
    protocol = "all"
  }

  # Simulation sur une plage IP / Région spécifique
  source_ranges = ["10.1.0.0/16"] # Spoke Prod
  description   = "CHAOS TEST: Simulate regional network partition"
}
