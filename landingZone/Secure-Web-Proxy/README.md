################################################################
# Titre: GCP Secure Web Proxy - Documentation
# Description : Guide sur l'inspection sémantique L7 (Envoy Powered)
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 25/11/2025 [v1.0 | RJ]
################################################################

# Secure Web Proxy (SWP) - Envoy Powered

💡 **Philosophie : Explicit Proxy & L7 Inspection**
Pour transformer une Landing Zone en un véritable Datacenter Cloud, le filtrage L3/L4 (IP/Ports) ne suffit plus. Cette couche implémente le **Cloud Secure Web Proxy (SWP)** de Google, un service managé basé sur **Envoy** qui permet d'inspecter et d'autoriser le trafic sortant (Egress) en fonction des noms de domaine (FQDN).

## Bonnes Pratiques Appliquées

### 🛡️ Contrôle Granulaire (CNCF & CAF)
- **FQDN Filtering :** Au lieu d'ouvrir le port 443 vers tout Internet, nous restreignons les flux sortants à une **Whitelist** stricte (ex: github.com, googleapis.com, *.ravindra-job.com).
- **Zéro Trust Egress :** Le proxy agit comme un point de passage obligatoire pour toutes les instances privées n'ayant pas d'adresse IP publique. (Source : *CNCF Zéro Trust Network Architecture*).

### 🏛️ Architecture Cloud Native
- **Envoy Engine :** Le proxy utilise la puissance sémantique d'Envoy pour faire correspondre les requêtes HTTP/HTTPS à des politiques de sécurité complexes sans gérer de serveurs proxy manuellement.
- **Proxy-Only Subnet :** Conformément à l'architecture GCP, un sous-réseau dédié (`REGIONAL_MANAGED_PROXY`) est réservé pour héberger les instances Envoy de manière isolée.

## Architecture du Module
1.  **URL Lists** : Définition des cibles autorisées.
2.  **Gateway Security Policy** : Règle de décision sémantique.
3.  **Managed Gateway** : Le service Cloud SWP rattaché au VPC de transit.

---
