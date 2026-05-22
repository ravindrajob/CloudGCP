# Couche 00 : Organization Policies (Hardening)

Cette couche constitue le "Garde-fou" racine de la Landing Zone. Elle applique des contraintes strictes au niveau du projet/organisation pour empêcher toute configuration non sécurisée, même accidentelle.

## Bonnes Pratiques Appliquées

### 🛡️ Identité & IAM (CNCF & CAF)
- **Workload Identity Federation (WIF) :** La création de clés de Service Account (JSON) est désactivée. Nous imposons l'authentification par jeton de courte durée. (Source : *CNCF Cloud Native Security Whitepaper*).
- **Domaines Autorisés :** Seuls les membres de l'organisation `ravindra-job.com` peuvent être ajoutés aux projets. (Source : *CAF Identity Pillar*).

### 🌐 Réseau & Exposition (CAF)
- **Zero Public IP :** Les instances ne peuvent pas avoir d'adresse IP externe. L'accès s'effectue via IAP ou VPN. (Source : *CAF Infrastructure Pillar*).
- **No Default Network :** Désactivation de la création automatique du réseau `default`.

### ⚡ Serverless (CNCF)
- **Private Run Only :** Interdiction de déployer des services Cloud Run accessibles à `allUsers`.
