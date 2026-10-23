# Data Platform AIOps

Piattaforma dati su Azure con ingestion batch (Storage -> ADF -> SQL Server)
e layer AIOps human-in-the-loop basato su DeepSeek.

## Struttura

- `infra/` - Terraform (moduli + ambienti dev/test/prod)
- `adf/` - artefatti Data Factory
- `src/` - codice Azure Functions (orchestratore AIOps)
- `docs/` - architettura, runbook, ADR
- `.github/workflows/` - CI/CD

## Quickstart

1. Configurare SP e GitHub Secrets -> `docs/01-cicd-identity.md`
2. Struttura repo -> `scripts/scaffold_repo.py`
3. Terraform -> `infra/environments/dev`

## Prerequisiti dev (Windows + SSL inspection)

Se git o gh falliscono con "x509: certificate signed by unknown authority":

    git config --global http.sslBackend schannel
    git config --global --unset-all http.sslCAInfo

## Documentazione

Vedi `docs/`.
