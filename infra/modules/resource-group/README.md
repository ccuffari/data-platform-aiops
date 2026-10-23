# Modulo resource-group

Wrapper minimale su `azurerm_resource_group` per uniformare naming e tag.

## Input

| Nome | Tipo | Obbligatorio | Descrizione |
|---|---|---|---|
| `name` | `string` | sì | Nome del RG |
| `location` | `string` | sì | Azure region |
| `tags` | `map(string)` | no | Tag da applicare |

## Output

| Nome | Descrizione |
|---|---|
| `id` | Resource ID |
| `name` | Nome del RG |
| `location` | Region |
