################################################################
# Titre: Documentation Architecture Sécurité (Defense in Depth)
# Description : Guide de la stratégie Zéro Trust et protection L7
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 26/11/2025 [v1.0 | RJ]
################################################################

# Stratégie de Sécurité : Defense in Depth

L'infrastructure applique une stratégie multicouche inspirée du modèle de la **CNCF** et du pilier Sécurité du **CAF**.

## 🛡️ Firewall Policies Hiérarchiques (ZTNA)
Nous appliquons le principe du **Zéro Trust Network Architecture (ZTNA)**.
- **Default Action** : Deny All Ingress & Deny All Egress.
- **Règles de Dossier** : Les politiques sont appliquées au niveau Folder pour garantir qu'aucun projet "Shadow IT" n'échappe au contrôle central.

## 🔒 Protection des Services (L7)
- **Cloud Armor (WAF)** : Protection des applications web contre les injections SQL, XSS et attaques DDoS L7.
- **Managed SSL** : Certificats TLS automatiques gérés par Google pour garantir un chiffrement de bout en bout.

## 👤 Sécurité des Charges (Workload Security)
- **Secret Manager** : Interdiction formelle du stockage de secrets dans le code ou les variables Terraform non chiffrées.
- **Cloud Run Security** : Interdiction de l'invocation publique `allUsers`. Seuls les flux authentifiés ou via LB sont autorisés.

## 🧬 Intégrité logicielle (Binary Authorization)
*En projet pour la v2.0* : Mise en œuvre de Binary Authorization pour garantir que seules les images Docker signées et vérifiées par la CI/CD peuvent être déployées dans le datacenter.

---
*Vision sécuritaire intransigeante portée par Ravindra JOB.*
