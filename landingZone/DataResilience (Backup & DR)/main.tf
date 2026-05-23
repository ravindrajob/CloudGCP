################################################################
# Titre: Data Resilience (Backup & DR)
# Description : Cloud Storage avec rétention WORM
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

resource "google_storage_bucket" "immutable_backup" {
  name          = "bucket-immutable-backup-lab-${var.random_suffix}"
  location      = "EU"
  force_destroy = false

  uniform_bucket_level_access = true

  # Rétention inaltérable (WORM) d'un an
  retention_policy {
    retention_period = 31536000 # 365 jours en secondes
    is_locked        = true     # Le verrou ne peut plus être retiré
  }

  encryption {
    default_kms_key_name = var.kms_key_name
  }
}
