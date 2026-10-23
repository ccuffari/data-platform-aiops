# Modulo storage

Storage Account per ingestion batch, con 3 container:
`landing` (arrivo file), `quarantine` (file errati), `archive` (processati).

## Input

| Nome | Tipo | Obbligatorio | Default |
|---|---|---|---|
| `resource_group_name` | `string` | sì | - |
| `location` | `string` | sì | - |
| `env` | `string` | sì | - |
| `workload` | `string` | no | `aiops` |
| `region_code` | `string` | no | `weu` |
| `tags` | `map(string)` | no | `{}` |

## Output

| Nome | Descrizione |
|---|---|
| `id` | Storage Account resource ID |
| `name` | Storage Account name |
| `primary_blob_endpoint` | Blob endpoint |
| `container_landing` | Nome container `landing` |
| `container_quarantine` | Nome container `quarantine` |
| `container_archive` | Nome container `archive` |
