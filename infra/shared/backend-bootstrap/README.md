# Backend bootstrap

Crea la Storage Account che ospita lo state Terraform di tutti gli ambienti.

**Si applica una sola volta**, con lo user interattivo (non con il SP), perché
crea anche la role assignment che il SP userà in CI.

## Uso

    cd infra/shared/backend-bootstrap
    terraform init
    terraform apply -auto-approve
    terraform output -json backend_config

Copiare i valori di `backend_config` nei `backend.tf` di `dev`, `test`, `prod`.

## State

Lo state di questo modulo è **locale** (`terraform.tfstate`).
Non committarlo. È nel `.gitignore` via `*.tfstate`.
Se perdi lo state, il bootstrap si ricrea in 2 minuti cambiando il nome della SA
(o importando le risorse esistenti).
