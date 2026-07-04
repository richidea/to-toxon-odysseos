# Déclenché par le hook PostToolUse sur Write/Edit/NotebookEdit (voir .claude/settings.json).
# Scanne les entités/DTO/controllers backend à la recherche de champs de données personnelles
# et journalise les avertissements dans le fichier de session du jour (section "Alertes RGPD").
# Appelable aussi en mode skill via -Files (utilisé par /rgpd-check sur le diff git courant).

param([string[]]$Files)

if (-not $Files) {
    $raw = [Console]::In.ReadToEnd()
    if (-not $raw) { exit 0 }
    try { $evt = $raw | ConvertFrom-Json } catch { exit 0 }
    $fp = $evt.tool_input.file_path ?? $evt.tool_input.notebook_path
    if (-not $fp) { exit 0 }
    $Files = @($fp)
}

$champsSensibles  = 'nom','prenom','dateNaissance','email','telephone','adresse','numeroLicence','licenceFFTA','photo'
$champsSante      = 'certificatMedical','donneeSante','pathologie','handicap','inaptitude'
$champsMotDePasse = 'motDePasse','password','mdp'

$patternEntityDto  = 'backend/src/.*/(entities|dto)/.*\.ts$'
$patternController = 'backend/src/.*\.controller\.ts$'

$cibles = $Files | Where-Object {
    $n = $_ -replace '\\','/'
    (Test-Path $_) -and ($n -match $patternEntityDto -or $n -match $patternController)
}
if (-not $cibles) { exit 0 }

$avertissements = @()

foreach ($fichier in $cibles) {
    $nomNormalise = $fichier -replace '\\','/'
    $contenu = Get-Content $fichier -Raw
    $lignes  = Get-Content $fichier

    foreach ($ligne in $lignes) {
        if ($ligne -notmatch ':') { continue }
        foreach ($champ in $champsSensibles) {
            if ($ligne -match "\b$champ\b") {
                $avertissements += "``$nomNormalise`` : champ sensible détecté (``$champ``)"
            }
        }
        foreach ($champ in $champsSante) {
            if ($ligne -match "\b$champ\b") {
                if ($contenu -notmatch '(RGPD|Art\.\s*9|@Sensible)') {
                    $avertissements += "``$nomNormalise`` : donnée de santé (``$champ``) sans traitement RGPD documenté (Art. 9) — exécuter /rgpd-check"
                }
                $avertissements += "``$nomNormalise`` : donnée de santé (``$champ``) détectée — vérifier si une AIPD est requise (CNIL) via /rgpd-check"
            }
        }
        foreach ($champ in $champsMotDePasse) {
            if ($ligne -match "\b$champ\b") {
                if ($contenu -notmatch '(?i)(bcrypt|argon2|scrypt)') {
                    $avertissements += "``$nomNormalise`` : mot de passe (``$champ``) potentiellement stocké sans hachage robuste (recommandation CNIL) — exécuter /rgpd-check"
                }
            }
        }
    }

    if ($nomNormalise -match $patternController) {
        $matchesEntite = [regex]::Matches($contenu, 'Promise<\s*(\w+)\s*(?:\[\])?\s*>|\b(\w+)\[\]')
        foreach ($m in $matchesEntite) {
            $type = if ($m.Groups[1].Success) { $m.Groups[1].Value } else { $m.Groups[2].Value }
            if ($type -match 'Entity$') {
                $avertissements += "``$nomNormalise`` : entité ``$type`` potentiellement exposée sans DTO — exécuter /rgpd-check"
            }
        }
    }
}

if (-not $avertissements) { exit 0 }

$dateStr    = (Get-Date).ToString('yyyy-MM-dd')
$sessionDir = ".claude/sessions"
$existing   = Get-ChildItem $sessionDir -Filter "${dateStr}_*.md" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $existing) { exit 0 }

$sessionContent = Get-Content $existing.FullName -Raw
if ($sessionContent -notmatch '## Alertes RGPD') {
    Add-Content -Path $existing.FullName -Value "`n## Alertes RGPD`n" -Encoding UTF8
}
foreach ($avert in ($avertissements | Select-Object -Unique)) {
    Add-Content -Path $existing.FullName -Value "- $avert" -Encoding UTF8
}
