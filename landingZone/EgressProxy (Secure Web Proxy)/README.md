################################################################
# Titre: EgressProxy (Secure Web Proxy) - README
# Description : Pourquoi filtrer la sortie via Envoy
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################
# EgressProxy (GCP Secure Web Proxy)
💡 Rôle : Contrôler granulairement ce qui SORT du datacenter Cloud vers Internet.
## Pourquoi Envoy ?
Nous utilisons Envoy pour son inspection sémantique. Contrairement à une IP, un domaine (FQDN) est beaucoup plus fiable pour authentifier une destination de confiance (ex: github.com).
## Hardening
- Whitelist exhaustive : Tout ce qui n'est pas dans la liste est bloqué (Deny by default).
- Proxy-only subnet : Isolation réseau des instances de filtrage.
