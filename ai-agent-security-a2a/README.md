################################################################
# Titre: AI Agent Security Gateway (A2A) - Documentation
# Description : Documentation technique du module de sécurisation des agents IA
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 15/10/2025 [v1.0 | RJ]
################################################################

# AI Agent Security Gateway (A2A)

💡 **Philosophie : Action-to-Action Security**
Dans un monde où les agents IA disposent d'une autonomie croissante, la sécurisation des "Actions" (A2A) est primordiale. Ce module implémente une gateway de sécurité (Proxy) qui s'interpose entre l'agent et le LLM (Vertex AI).

## Fonctionnalités du Lab
- **Interception des Prompts :** Analyse sémantique pour détecter les injections de prompts avant qu'elles n'atteignent le modèle.
- **Identity Hardening :** Utilisation de Service Accounts isolés sans aucune clé JSON statique (WIF-ready).
- **Secret Management :** Les clés LLM sont stockées dans Google Secret Manager et injectées au runtime.
- **Audit Log Centralisé :** Chaque action de l'agent est tracée et vérifiée par la gateway de sécurité.

## Architecture
1.  **Cloud Run v2** : Héberge le proxy de sécurité "Paranoïaque".
2.  **Secret Manager** : Centralise les credentials.
3.  **IAM Policy** : Applique le principe du moindre privilège sur l'API Vertex AI.

---
*Code conçu et partagé par Ravindra JOB pour évangéliser la sécurité des systèmes autonomes.*
