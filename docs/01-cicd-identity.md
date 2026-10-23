# Identita CI/CD

## Service Principal

| Campo | Valore |
|---|---|
| Nome | sp-aiops-cicd-dev |
| App ID | d388e067-f327-49b8-80c3-053a46dcf027 |
| Principal ID | 4116e3fb-cb4b-4179-860e-2eb4bfdd2951 |
| Tenant ID | 43d04a32-4ce3-492a-9d6e-ba61b3e6882d |
| Scadenza secret | 2027-10-23 |
| Ruolo | Contributor |
| Scope | /subscriptions/f4a32007-b8c2-4aee-9dc0-1421a27e36ad |

## GitHub Secrets

Configurati a livello di repository:

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `AZURE_CLIENT_SECRET`

## Prerequisiti dev locale (Windows, SSL inspection)

La rete aziendale (Zscaler / Fortinet) intercetta TLS. Git e gh devono
usare lo store certificati di Windows:

    git config --global http.sslBackend schannel
    git config --global --unset-all http.sslCAInfo

Se git usa OpenSSL (default di Git for Windows), il clone fallisce con
`unable to get local issuer certificate`.

## Rotazione

1. `az ad sp credential reset --id <APP_ID> --years 1`
2. Aggiornare `AZURE_CLIENT_SECRET` con `gh secret set`
3. Verificare i workflow in `dev`
4. Annotare la nuova scadenza in questo documento

## Hardening futuro (post-MVP)

- Migrazione a OIDC federato GitHub -> Azure (elimina `AZURE_CLIENT_SECRET`)
- Restringimento del ruolo `Contributor` ai soli RG della Data Platform

