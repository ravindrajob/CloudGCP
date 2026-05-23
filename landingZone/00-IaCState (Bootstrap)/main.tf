################################################################
# Titre: IaC State Security (Bootstrap)
# Description : Backend Terraform verrouillé sur GCS
# Auteur: Ravindra JOB | v2.0
# Update: 23/05/2026
################################################################

resource "google_kms_crypto_key" "tfstate_key" {
  name            = "tfstate-key-lab"
  key_ring        = var.kms_key_ring_id
  rotation_period = "2592000s"
}

resource "google_storage_bucket" "terraform_state" {
  name          = "tfstate-lab-${var.random_suffix}"
  location      = "EU" # Multi-région européenne
  force_destroy = false

  uniform_bucket_level_access = true
  
  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.tfstate_key.id
  }

  # Protection contre la suppression accidentelle
  lifecycle {
    prevent_destroy = true
  }
}
