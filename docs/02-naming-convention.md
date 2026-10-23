# Naming convention Azure

Riferimento: [Microsoft CAF - Resource abbreviations](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations).

## Pattern

    <abbreviazione-tipo>-<workload>-<env>-<region>-<nnn>

- **workload**: `aiops` (nome stabile della piattaforma)
- **env**: `dev` | `test` | `prod`
- **region**: `weu` (West Europe), `itn` (Italy North)
- **nnn**: `001`, `002`, ... per istanze multiple

## Eccezioni

| Risorsa | Regola |
|---|---|
| Storage Account | No dash, solo lowercase + cifre, max 24 char, globalmente univoco |
| SQL Server | No dash prima di `sql-` (usa `sql-...`), globalmente univoco su `.database.windows.net` |
| Key Vault | Max 24 char, globalmente univoco su `.vault.azure.net` |

## Tabella abbreviazioni

| Tipo Azure | Abbrev. | Esempio dev |
|---|---|---|
| Resource Group | `rg` | `rg-aiops-dev-weu-001` |
| Storage Account | `st` | `staiopsdevweu001` |
| Data Factory | `adf` | `adf-aiops-dev-weu-001` |
| SQL Server | `sql` | `sql-aiops-dev-weu-001` |
| SQL Database | `sqldb` | `sqldb-aiops-dev-weu-001` |
| Function App | `func` | `func-aiops-dev-weu-001` |
| App Service Plan | `asp` | `asp-aiops-dev-weu-001` |
| Key Vault | `kv` | `kv-aiops-dev-weu-001` |
| Log Analytics Workspace | `log` | `log-aiops-dev-weu-001` |
| Application Insights | `appi` | `appi-aiops-dev-weu-001` |
| Virtual Network | `vnet` | `vnet-aiops-dev-weu-001` |
| Subnet | `snet` | `snet-aiops-dev-weu-001` |
| NAT Gateway | `nat` | `nat-aiops-dev-weu-001` |
| Private Endpoint | `pep` | `pep-aiops-dev-weu-001` |
| Logic App | `la` | `la-aiops-dev-weu-001` |
| Managed Identity | `id` | `id-aiops-dev-weu-001` |

## Storage Account: stato Terraform

Il backend Terraform usa una **Storage Account dedicata** fuori dagli ambienti:

| Campo | Valore |
|---|---|
| Resource Group | `rg-tfstate-aiops-weu-001` |
| Storage Account | `sttfstateaiopsweu<NNNN>` (suffisso random per unicità) |
| Container | `tfstate` |
| Blob naming | `<env>.data-platform-aiops.tfstate` |

## Tag obbligatori

Ogni risorsa (via `azurerm`) deve avere questi tag:

| Tag | Valore | Note |
|---|---|---|
| `env` | `dev` / `test` / `prod` | ambiente |
| `workload` | `aiops` | piattaforma |
| `owner` | email o team | responsabile |
| `costCenter` | codice interno | per chargeback |
| `dataClassification` | `public` / `internal` / `confidential` | sensibilità dati |
| `managedBy` | `terraform` | convenzione |
