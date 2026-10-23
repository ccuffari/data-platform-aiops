# Modulo keyvault

Azure Key Vault con RBAC abilitato. Contiene i segreti della piattaforma
(es. `deepseek-api-key`), letti da Function/ADF via Managed Identity.

## Modello di sicurezza (MVP)

- **RBAC** (`enable_rbac_authorization = true`): niente access policy legacy.
  I permessi si gestiscono con `az role assignment create`.
- **Public network**: `default_action = "Allow"` per consentire l'upload manuale
  dei segreti. Hardening con Private Endpoint previsto in Step 9.
- **Soft delete**: 7 giorni in dev/test, 90 in prod.
- **Purge protection**: `false` in dev/test (permette purge immediato in caso
  di recreate), `true` in prod (irreversibile).

## Input

| Nome | Tipo | Obbligatorio | Default |
|---|---|---|---|
| `resource_group_name` | `string` | sì | - |
| `location` | `string` | sì | - |
| `env` | `string` | sì | - |
| `workload` | `string` | no | `aiops` |
| `region_code` | `string` | no | `weu` |
| `tenant_id` | `string` | sì | - |
| `purge_protection_enabled` | `bool` | no | `false` |
| `soft_delete_retention_days` | `number` | no | `7` |
| `tags` | `map(string)` | no | `{}` |

## Output

| Nome | Descrizione |
|---|---|
| `id` | Key Vault resource ID |
| `name` | Nome del Key Vault |
| `vault_uri` | URI per accedere ai segreti |
| `resource_group_name` | RG di appartenenza |

## Upload di un segreto (una-tantum, manuale)

Vedi `docs/06-secrets.md`.
