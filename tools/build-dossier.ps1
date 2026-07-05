# Génère docs/specifications/dossier-specifications.html : version HTML autonome et imprimable
# du dossier de spécifications, à rediffuser aux relecteurs à chaque nouvelle version.
# Usage : pwsh tools/build-dossier.ps1 [-SpecDir <dossier>] [-Output <fichier>]

param(
    [string]$SpecDir = (Join-Path $PSScriptRoot '..\docs\specifications'),
    [string]$Output
)

$ErrorActionPreference = 'Stop'
$SpecDir = (Resolve-Path $SpecDir).Path
if (-not $Output) { $Output = Join-Path $SpecDir 'dossier-specifications.html' }

$fileOrder = @(
    '00-lisez-moi.md', '01-contexte-objectifs.md', '02-perimetre-phasage.md',
    '03-acteurs-parcours.md', '04-regles-metier.md', '05-exigences-fonctionnelles.md',
    '06-exigences-non-fonctionnelles.md', '07-donnees-rgpd.md',
    '08-questions-ouvertes.md', 'glossaire.md'
)

function ConvertTo-InlineHtml([string]$s) {
    $s = $s -replace '&', '&amp;' -replace '<', '&lt;' -replace '>', '&gt;'
    $s = [regex]::Replace($s, '`([^`]+)`', '<code>$1</code>')
    $s = [regex]::Replace($s, '\*\*([^*]+)\*\*', '<strong>$1</strong>')
    $s = [regex]::Replace($s, '(?<![\w*])\*([^*\s][^*]*)\*(?![\w*])', '<em>$1</em>')
    # Liens internes vers un autre chapitre du dossier -> ancre de section
    $s = [regex]::Replace($s, '\[([^\]]+)\]\(([\w][\w.-]*)\.md(#[^)]*)?\)', '<a href="#ch-$2">$1</a>')
    $s = [regex]::Replace($s, '\[([^\]]+)\]\((https?://[^)]+)\)', '<a href="$2">$1</a>')
    return $s
}

function Convert-MarkdownFile([string]$path) {
    $html = [System.Text.StringBuilder]::new()
    $lines = Get-Content $path -Encoding utf8
    $inTable = $false; $inList = $false; $inQuote = $false; $para = @()

    function Flush-Para {
        if ($script:para.Count -gt 0) {
            [void]$script:html.AppendLine('<p>' + (ConvertTo-InlineHtml ($script:para -join ' ')) + '</p>')
            $script:para = @()
        }
    }
    Set-Variable -Name html -Value $html -Scope Script
    Set-Variable -Name para -Value $para -Scope Script

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]

        if ($inTable -and $line -notmatch '^\s*\|') { [void]$html.AppendLine('</tbody></table>'); $inTable = $false }
        if ($inList -and $line -notmatch '^\s*([-*]|\d+\.)\s') { [void]$html.AppendLine('</ul>'); $inList = $false }
        if ($inQuote -and $line -notmatch '^\s*&gt;|^\s*>') { [void]$html.AppendLine('</blockquote>'); $inQuote = $false }

        if ($line -match '^\s*$') { Flush-Para; continue }

        if ($line -match '^(#{1,4})\s+(.*)$') {
            Flush-Para
            $level = $Matches[1].Length + 1   # H1 du fichier -> h2 du document
            if ($level -gt 6) { $level = 6 }
            [void]$html.AppendLine("<h$level>" + (ConvertTo-InlineHtml $Matches[2]) + "</h$level>")
            continue
        }
        if ($line -match '^\s*(---+|\*\*\*+)\s*$') { Flush-Para; [void]$html.AppendLine('<hr/>'); continue }
        if ($line -match '^\s*>\s?(.*)$') {
            Flush-Para
            if (-not $inQuote) { [void]$html.AppendLine('<blockquote>'); $inQuote = $true }
            [void]$html.AppendLine('<p>' + (ConvertTo-InlineHtml $Matches[1]) + '</p>')
            continue
        }
        if ($line -match '^\s*\|') {
            Flush-Para
            $cells = $line.Trim().Trim('|') -split '\|' | ForEach-Object { $_.Trim() }
            if (($cells -join '') -match '^[-: ]+$') { continue }   # ligne séparatrice
            if (-not $inTable) {
                [void]$html.AppendLine('<table><thead><tr>' +
                    (($cells | ForEach-Object { '<th>' + (ConvertTo-InlineHtml $_) + '</th>' }) -join '') +
                    '</tr></thead><tbody>')
                $inTable = $true
            } else {
                [void]$html.AppendLine('<tr>' +
                    (($cells | ForEach-Object { '<td>' + (ConvertTo-InlineHtml $_) + '</td>' }) -join '') +
                    '</tr>')
            }
            continue
        }
        if ($line -match '^\s*([-*]|\d+\.)\s+(.*)$') {
            Flush-Para
            if (-not $inList) { [void]$html.AppendLine('<ul>'); $inList = $true }
            [void]$html.AppendLine('<li>' + (ConvertTo-InlineHtml $Matches[2]) + '</li>')
            continue
        }
        $script:para += $line.Trim()
    }
    Flush-Para
    if ($inTable) { [void]$html.AppendLine('</tbody></table>') }
    if ($inList) { [void]$html.AppendLine('</ul>') }
    if ($inQuote) { [void]$html.AppendLine('</blockquote>') }
    return $html.ToString()
}

# Version et date lues dans 00-lisez-moi.md
$lisezMoi = Get-Content (Join-Path $SpecDir '00-lisez-moi.md') -Raw -Encoding utf8
$version = if ($lisezMoi -match '\|\s*Version\s*\|\s*([^|]+?)\s*\|') { $Matches[1] } else { '?' }
$dateDoc = if ($lisezMoi -match '\|\s*Date\s*\|\s*([^|]+?)\s*\|') { $Matches[1] } else { (Get-Date -Format 'yyyy-MM-dd') }

$sections = [System.Text.StringBuilder]::new()
$toc = [System.Text.StringBuilder]::new()
foreach ($f in $fileOrder) {
    $path = Join-Path $SpecDir $f
    if (-not (Test-Path $path)) { Write-Warning "Fichier absent : $f"; continue }
    $id = 'ch-' + [System.IO.Path]::GetFileNameWithoutExtension($f)
    $firstH1 = (Get-Content $path -Encoding utf8 | Where-Object { $_ -match '^#\s+' } | Select-Object -First 1) -replace '^#\s+', ''
    [void]$toc.AppendLine("<li><a href=`"#$id`">" + (ConvertTo-InlineHtml $firstH1) + '</a></li>')
    [void]$sections.AppendLine("<section id=`"$id`" class=`"chapitre`">")
    [void]$sections.AppendLine((Convert-MarkdownFile $path))
    [void]$sections.AppendLine('</section>')
}

$css = @'
body { font-family: "Segoe UI", Arial, sans-serif; line-height: 1.5; color: #1a1a1a;
       max-width: 900px; margin: 0 auto; padding: 2rem; }
header.bandeau { border-bottom: 3px solid #2c5f2d; padding-bottom: 1rem; margin-bottom: 2rem; }
header.bandeau h1 { margin: 0 0 .3rem; font-size: 1.7rem; }
header.bandeau .meta { color: #555; font-size: .95rem; }
h2 { border-bottom: 2px solid #2c5f2d; padding-bottom: .3rem; margin-top: 2.5rem; }
h3 { margin-top: 1.8rem; }
table { border-collapse: collapse; width: 100%; margin: 1rem 0; font-size: .93rem; }
th, td { border: 1px solid #bbb; padding: .45rem .6rem; text-align: left; vertical-align: top; }
th { background: #eaf2ea; }
tr:nth-child(even) td { background: #f7f7f7; }
blockquote { border-left: 4px solid #2c5f2d; margin: 1rem 0; padding: .3rem 1rem; background: #f4f8f4; }
code { background: #f0f0f0; padding: .1rem .3rem; border-radius: 3px; font-size: .9em; }
nav.toc { background: #f4f8f4; border: 1px solid #cfe0cf; border-radius: 6px; padding: 1rem 2rem; }
nav.toc h2 { border: none; margin-top: 0; }
a { color: #1d4ed8; }
section.chapitre { margin-top: 1rem; }
@media print {
  body { max-width: none; padding: 0; font-size: 11pt; }
  section.chapitre { page-break-before: always; }
  nav.toc { page-break-before: avoid; }
  a { color: inherit; text-decoration: none; }
}
'@

$doc = @"
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Dossier de spécifications — to-toxon-odysseos ($version)</title>
<style>$css</style>
</head>
<body>
<header class="bandeau">
<h1>Dossier de spécifications — to-toxon-odysseos</h1>
<div class="meta">Application de gestion des concours de tir à l'arc conformes FFTA —
<strong>$version</strong> · $dateDoc · document de relecture, annotations bienvenues (voir chapitre « Lisez-moi »)</div>
</header>
<nav class="toc"><h2>Sommaire</h2><ol>
$($toc.ToString())
</ol></nav>
$($sections.ToString())
</body>
</html>
"@

[System.IO.File]::WriteAllText($Output, $doc, [System.Text.UTF8Encoding]::new($false))
Write-Host "Généré : $Output ($version, $([math]::Round((Get-Item $Output).Length / 1KB)) Ko)"
