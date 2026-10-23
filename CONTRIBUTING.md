# Contributing

> **Nota (repo privato Free)**: la branch protection non è attiva.
> Il flusso PR + review è **disciplinare**, non enforced.
> I controlli CI girano su ogni push e sono la rete di sicurezza.
> Upgrade a GitHub Pro previsto prima del go-live in produzione.

## Flusso PR

1. Branch da `main`: `feature/<short-desc>` o `fix/<short-desc>`
2. Commit piccoli, messaggi chiari (Conventional Commits)
3. Aprire PR -> la CI esegue `terraform plan` sui 3 ambienti
4. Review obbligatoria (CODEOWNERS)
5. Merge su `main` -> apply automatico su `dev`/`test`, approvazione manuale su `prod`

## Convenzioni commit

- `feat:` nuova funzionalita
- `fix:` correzione
- `docs:` documentazione
- `infra:` modifiche Terraform
- `ci:` modifiche workflow

## Sicurezza

- Mai committare secret, `.env`, `local.settings.json`
- Le API key (DeepSeek) vivono solo in Key Vault

