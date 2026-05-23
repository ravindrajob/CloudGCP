################################################################
# Titre: GCP DataSecurity - Cloud KMS & CMEK
# Auteur: Ravindra JOB | v1.3
# Update: 23/05/2026
################################################################

# Sécurisation des données At-Rest via Customer Managed Encryption Keys (CMEK)
# Chiffre GCS, BigQuery, et GCE

resource "google_kms_key_ring" "lab_keyring" {
  name     = "kr-sec-lab-${var.random_suffix}"
  location = var.region
  project  = var.project_id
}

resource "google_kms_crypto_key" "lab_cmek" {
  name            = "key-cmek-lab"
  key_ring        = google_kms_key_ring.lab_keyring.id
  rotation_period = "2592000s" # Rotation tous les 30 jours (Expertise Sécurité)

  lifecycle {
    prevent_destroy = true
  }
}

# Autoriser le Service Agent Storage à utiliser cette clé
resource "google_kms_crypto_key_iam_member" "storage_cmek" {
  crypto_key_id = google_kms_crypto_key.lab_cmek.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${var.project_number}@gs-project-accounts.iam.gserviceaccount.com"
}
