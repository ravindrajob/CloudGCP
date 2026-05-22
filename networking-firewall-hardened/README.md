################################################################
# Titre: GCP Hardened Firewall Policies - Documentation
# Description : Guide sur l'implémentation Zéro Trust sur GCP
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 24/11/2025 [v1.0 | RJ]
################################################################

# Networking Firewall Hardened (Zéro Trust)

💡 **Philosophie : Deny by Default**
Cette implémentation réseau suit le principe du **Zéro Trust**. Aucune confiance n'est accordée aux flux par défaut, qu'ils soient entrants ou sortants. Nous utilisons les **Global Network Firewall Policies** pour centraliser et verrouiller le trafic de manière immuable.

## Bonnes Pratiques Appliquées

### 🛡️ Sécurité Réseau (CAF & CNCF)
- **Deny All Ingress/Egress :** Deux règles de priorité basse bloquent l'intégralité du trafic. Cela empêche toute communication non autorisée et réduit drastiquement les risques d'exfiltration de données.
- **Identity-Aware Proxy (IAP) :** L'accès administratif (SSH/RDP) est uniquement autorisé via les plages IP de Google IAP. Cela permet de gérer ses serveurs sans jamais leur attribuer d'adresse IP publique. *(Source: CAF Security Pillar)*.
- **Micro-segmentation :** Seuls les flux explicitement nécessaires au fonctionnement du Lab (Monitoring SRE, ICMP interne) sont ouverts.

## Architecture du Module
1.  **Global Firewall Policy** : La règle maîtresse rattachée au VPC.
2.  **Ruleset Hardened** : 
    - Priority 65535: Ingress Deny all.
    - Priority 65534: Egress Deny all.
    - Priority 1000: IAP Management.
3.  **VPC Association** : Application dynamique de la politique sur le réseau de démonstration.

---
*Architecture conçue avec une rigueur paranoïaque par Ravindra JOB.*
