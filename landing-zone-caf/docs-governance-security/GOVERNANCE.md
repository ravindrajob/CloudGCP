################################################################
# Titre: Documentation Gouvernance & Policies GCP
# Description : Guide des politiques d'organisation et justifications CAF
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 12/09/2025 [v1.0 | RJ] Initial creation
# Update: 20/11/2025 [v1.1 | RJ] Adding WIF & SA Key restrictions
################################################################

# Gouvernance de la Landing Zone

Cette section détaille les politiques d'organisation (Organization Policies) et les règles de gouvernance appliquées à l'ensemble du Lab de démonstration. Chaque règle est justifiée par les standards du **GCP Cloud Adoption Framework (CAF)**.

## 📋 Politiques d'Organisation (Org Policies)

| Politique | État | Justification Technique (CAF) |
| :--- | :--- | :--- |
| `iam.disableServiceAccountKeyCreation` | **Activé** | Sécurité de l'Identité : Élimine le risque de fuite de secrets statiques. Force l'usage de WIF ou des jetons éphémères. |
| `compute.restrictExternalIp` | **Activé** | Sécurité Réseau : Interdiction formelle des adresses IP publiques pour réduire la surface d'attaque. |
| `sql.restrictPublicIp` | **Activé** | Protection des Données : Les bases de données sont isolées et accessibles uniquement via le réseau interne. |
| `storage.publicAccessPrevention` | **Activé** | Prévention de la Fuite de Données (DLP) : Empêche l'exposition accidentelle de buckets sur Internet. |
| `iam.allowedPolicyMemberDomains` | **Activé** | Contrôle d'Accès : Limite l'administration aux comptes de l'organisation `ravindra-job.com`. |

## 🛡️ Gestion de l'Identité (WIF Force)

Dans cette Landing Zone, la création de clés de Service Account (fichiers JSON) est techniquement interdite. 
- **Workload Identity Federation (WIF)** : Utilisé pour les workflows GitHub Actions ou GitLab CI.
- **Service Account Impersonation** : Utilisé par les administrateurs pour les tâches manuelles ou scripts locaux.

## ⚖️ Conformité & Audit
Tous les journaux d'audit (Admin Activity, Data Access) sont centralisés dans le projet `lab-gcp-logging` via un **Log Sink** au niveau de l'organisation pour garantir l'immutabilité et la traçabilité.

---
*Gouvernance carrée et rigoureuse conçue par Ravindra JOB.*
