#!/usr/bin/env pwsh
# Approva il pending deployment del workflow terraform-apply per il run più recente.
# Uso: .\scripts\approve-prod.ps1
#      .\scripts\approve-prod.ps1 -RunId 1234567890
#      .\scripts\approve-prod.ps1 -RunId 1234567890 -Reject

param(
    [string]$RunId,
    [switch]$Reject
)

$ErrorActionPreference = "Stop"

if (-not $RunId) {
    $RunId = gh run list --workflow=terraform-apply.yml --limit 1 --json databaseId --jq '.[0].databaseId'
    if (-not $RunId) { throw "Nessun run trovato per terraform-apply" }
}

Write-Host "Run: $RunId"

$pending = gh api "repos/ccuffari/data-platform-aiops/actions/runs/$RunId/pending_deployments" | ConvertFrom-Json
if (-not $pending -or $pending.Count -eq 0) {
    Write-Host "Nessun pending deployment." -ForegroundColor Yellow
    gh run view $RunId --json status,conclusion,jobs --jq '{status: .status, conclusion: .conclusion, jobs: [.jobs[] | {name, status, conclusion}]}'
    return
}

# [long] perche' gli environment ID GitHub superano Int32.MaxValue
$envIds = @($pending | ForEach-Object { [long]$_.environment.id })
Write-Host "Environments pending: $($envIds -join ', ')"

$state = if ($Reject) { "rejected" } else { "approved" }
$comment = if ($Reject) { "Rejected via CLI" } else { "Approved via CLI" }
$idsJson = '[' + ($envIds -join ',') + ']'
$body = '{"environment_ids":' + $idsJson + ',"state":"' + $state + '","comment":"' + $comment + '"}'

$body | gh api -X POST "repos/ccuffari/data-platform-aiops/actions/runs/$RunId/pending_deployments" --input -
Write-Host "Deployment $state. Attendi il completamento." -ForegroundColor Green
