################################################################
# Titre: Connectivity (Cloud Interconnect) - README
# Description : Pourquoi privatiser la liaison hybride sur GCP
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 22/05/2026 [v1.0 | RJ]
################################################################

# Connectivity (GCP Cloud Interconnect)

💡 **Rôle du composant :** 
Fournir une extension privée et physique du datacenter On-Premise vers le réseau global de Google Cloud.

## Pourquoi ce choix technique ?
**Cloud Interconnect** est la solution de référence pour les entreprises exigeant un SLA de disponibilité élevé et un débit constant. Elle permet d'étendre le réseau local dans le Cloud de manière transparente via le routage BGP.

## Hardening spécifique (vs Standard)
- **Dedicated Interconnect :** Isolation physique totale du trafic par rapport aux autres clients Google.
- **NCC Attachment :** L'interconnexion est rattachée au **Network Connectivity Center (NCC)**, ce qui permet au Hub central de propager dynamiquement les routes On-Premise vers tous les Spokes VPC.
- **Private Service Connect :** Couplage avec PSC pour consommer les API Google (ex: Vertex AI) directement via la liaison Interconnect sans jamais sortir par une gateway Internet.

---
Adoption industrialisée du CAF avec surcouche de sécurité et intégration des pratiques CNCF.
