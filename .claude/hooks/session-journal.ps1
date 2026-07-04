# Déclenché par le hook PostToolUse sur Write/Edit/NotebookEdit.
# Crée ou met à jour le fichier de session du jour dans .claude/sessions/.

$raw = [Console]::In.ReadToEnd()
if (-not $raw) { exit 0 }

try { $event = $raw | ConvertFrom-Json } catch { exit 0 }

$toolInput = $event.tool_input
$filePath  = $toolInput.file_path ?? $toolInput.notebook_path
if (-not $filePath) { exit 0 }

# Éviter la récursion sur les fichiers de session eux-mêmes
if ($filePath -replace '\\','/' -like "*/.claude/sessions/*") { exit 0 }

$now         = Get-Date
$dateStr     = $now.ToString('yyyy-MM-dd')
$timeStr     = $now.ToString('HH-mm')
$actionLabel = if ($event.tool_name -eq 'Write') { 'créé' } else { 'modifié' }

$sessionDir = ".claude/sessions"
if (-not (Test-Path $sessionDir)) {
    New-Item -ItemType Directory -Force $sessionDir | Out-Null
}

$existing = Get-ChildItem $sessionDir -Filter "${dateStr}_*.md" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

$row = "| ``$filePath`` | $actionLabel | — |"

if ($existing) {
    Add-Content -Path $existing.FullName -Value $row -Encoding UTF8
} else {
    $sessionFile = "$sessionDir/${dateStr}_${timeStr}_session.md"
    $content = @"
# Session du $dateStr — [À compléter]

## Contexte
[À compléter]

## Demandes effectuées
1. [À compléter]

## Modifications réalisées
| Fichier | Action | Description |
|---------|--------|-------------|
$row

## Ressources et références

## Prompt de reproduction
"@
    Set-Content -Path $sessionFile -Value $content -Encoding UTF8
}
