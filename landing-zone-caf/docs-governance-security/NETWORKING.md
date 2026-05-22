################################################################
# Titre: Documentation Architecture Réseau (Hub & Spoke / NCC)
# Description : Guide de la topologie réseau moderne et sécurisée
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 15/09/2025 [v1.0 | RJ] Initial topology design
# Update: 22/11/2025 [v1.1 | RJ] IAP Force & SWP Envoy integration
################################################################

# Architecture Réseau : Modern Hub & Spoke

La Landing Zone utilise une topologie réseau centrée sur le **Network Connectivity Center (NCC)**, permettant un routage dynamique et une segmentation granulaire.

## 🏗️ Topologie NCC
Au lieu des peerings VPC traditionnels (limités et complexes), nous utilisons le **NCC Hub** comme cerveau central du routage.
- **Hub VPC** : Point de transit centralisé pour la connectivité hybride et Internet.
- **VPC Spokes** : Réseaux applicatifs isolés rattachés dynamiquement via des `google_network_connectivity_spoke`.

## 🛡️ Accès Administratif : IAP Force (Zéro Trust)
Conformément aux principes du **Zéro Trust**, cette architecture bannit l'usage des bastions traditionnels ou des IPs publiques pour l'administration.

### Pourquoi Identity-Aware Proxy (IAP) ?
1. **Zéro Surface d'Attaque** : Les instances n'ont aucune IP publique. Le port 22 n'est pas exposé sur Internet.
2. **Identité Forte** : L'accès est conditionné à l'authentification IAM et non plus à la simple possession d'une clé SSH.
3. **Contrôle Contextuel** : IAP permet d'ajouter des conditions sur l'état de l'appareil (Context-Aware Access).

### Implémentation
- **Plage IP IAP** : `35.235.240.0/20` autorisée dans les Firewall Policies.
- **IAM** : Les administrateurs doivent posséder le rôle `roles/iap.tunnelResourceAccessor`.

## 🌐 Egress Control (Secure Web Proxy)
Tout trafic sortant du datacenter cloud vers Internet est inspecté par un proxy explicite **Envoy-powered** (GCP Secure Web Proxy). Le filtrage se fait par nom de domaine (FQDN Whitelisting).

---
*Architecture réseau experte validée par Ravindra JOB.*
