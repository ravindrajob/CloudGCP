################################################################
# Titre: GCP Organization Policies (Hardened CNCF/CAF)
# Description : Verrouillage des vecteurs d'attaque au niveau racine
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# ==============================================================================
# Terraform : GCP Organization Policies (Hardened CNCF/CAF)
# Description : Verrouillage des vecteurs d'attaque au niveau racine
# Référence : Google Cloud Adoption Framework (CAF) - Security Foundation
# Référence : CNCF Cloud Native Identity & Security
# ==============================================================================

# 1. Interdire la création de réseaux VPC par défaut (CAF: Infrastructure Foundation)
# Évite d'avoir des réseaux "default" avec des règles firewall permissives.
resource "google_project_organization_policy" "no_default_network" {
  project    = var.project_id
  constraint = "compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}

# 2. Désactiver la création de clés de Service Accounts (CNCF: Cloud Native Identity)
# Impose l'usage du Workload Identity Federation (WIF) et évite les fuites de fichiers JSON.
resource "google_project_organization_policy" "disable_sa_keys" {
  project    = var.project_id
  constraint = "iam.disableServiceAccountKeyCreation"

  boolean_policy {
    enforced = true
  }
}

# 3. Restriction de l'IAM au domaine d'organisation (CAF: Identity Management)
# Empêche l'ajout d'identités externes (ex: @gmail.com) aux rôles IAM.
resource "google_project_organization_policy" "allowed_domains" {
  project    = var.project_id
  constraint = "iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      values = ["principalSet://iam.googleapis.com/organizations/${var.org_id}"]
    }
  }
}

# 4. Interdiction des IPs publiques sur les instances (CAF: Network Security)
# Force le passage par des bastions, IAP ou Cloud NAT centralisés (Hub).
resource "google_project_organization_policy" "no_external_ips" {
  project    = var.project_id
  constraint = "compute.restrictExternalIp"

  boolean_policy {
    enforced = true
  }
}

# 5. Blocage de l'accès public Cloud Run (CNCF: Serverless Security)
# Interdiction de l'invocation allUsers (non authentifiée).
resource "google_project_organization_policy" "no_public_run" {
  project    = var.project_id
  constraint = "run.allowedBinaryAuthorizationPolicies" # Placeholder pour illustrer le verrouillage CNCF

  boolean_policy {
    enforced = true
  }
}
