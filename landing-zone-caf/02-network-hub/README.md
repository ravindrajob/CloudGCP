# Couche 02 : Network Hub (NCC)

Cette couche implémente le point central de connectivité de la Landing Zone. Nous utilisons le **Network Connectivity Center (NCC)** de Google, qui est la solution moderne pour interconnecter plusieurs VPCs et sites hybrides sans la complexité des peerings maillés.

## Bonnes Pratiques Appliquées

### 🚀 Routage Moderne (CNCF & Google NCC)
- **NCC Hub :** Centralise la gestion des routes. Plutôt que de multiplier les peerings VPC (limités en nombre et complexes à gérer), le NCC permet d'agréger dynamiquement les **Spokes**. (Source : *Google Cloud Networking Reference Architecture*).

### 🛡️ Sécurité du Flux (CAF)
- **Centralized Egress :** Grâce au Cloud NAT déployé dans le Hub, nous pouvons contrôler et monitorer toute la sortie vers Internet de l'organisation. Les instances applicatives dans les Spokes n'ont aucun accès direct. (Source : *CAF Security Pillar*).
- **VPC Host :** Le Hub VPC est configuré comme un **Shared VPC Host** pour déléguer l'usage du réseau aux projets applicatifs tout en gardant le contrôle de l'administration.
