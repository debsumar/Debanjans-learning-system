$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$registryPath = Join-Path $root 'assets\registry.js'
$failures = 0
$checks = 0

function Add-Check {
  param([string]$Name, [bool]$Passed, [int]$Count, [string]$Detail)
  $script:checks++
  $label = if ($Passed) { 'PASS' } else { 'FAIL' }
  if (-not $Passed) { $script:failures++ }
  Write-Host ("{0} {1}: {2} ({3})" -f $label, $Name, $Detail, $Count)
}

$registryText = ''
$registryLoaded = $false
$topics = @()
$registryChapters = @()
if (-not (Test-Path -LiteralPath $registryPath -PathType Leaf)) {
  Add-Check 'registry file' $false 0 'assets/registry.js is missing'
} else {
  try {
    $registryText = [IO.File]::ReadAllText($registryPath)
    $topicMatches = [regex]::Matches($registryText, '"?slug"?\s*:\s*"([^"]+)"[\s\S]*?"?hubPath"?\s*:\s*"([^"]+)"')
    $chapterMatches = [regex]::Matches($registryText, '\{\s*"?file"?\s*:\s*"([^"]+)"\s*,\s*"?title"?\s*:\s*"([^"]+)"\s*,\s*"?domain"?\s*:\s*"([^"]+)"\s*,\s*"?weight"?\s*:\s*"([^"]+)"\s*\}')
    foreach ($m in $topicMatches) {
      $topics += [pscustomobject]@{ Slug = $m.Groups[1].Value; HubPath = $m.Groups[2].Value }
    }
    foreach ($m in $chapterMatches) {
      $registryChapters += [pscustomobject]@{ File = $m.Groups[1].Value; Title = $m.Groups[2].Value; Domain = $m.Groups[3].Value; Weight = $m.Groups[4].Value }
    }
    $registryLoaded = ($topics.Count -gt 0 -and $registryChapters.Count -gt 0)
    Add-Check 'registry metadata extraction' $registryLoaded ($topics.Count + $registryChapters.Count) ("topics={0}, chapters={1}" -f $topics.Count, $registryChapters.Count)
  } catch {
    Add-Check 'registry metadata extraction' $false 0 $_.Exception.Message
  }
}

$registrySyntaxPass = $false
$node = Get-Command node -ErrorAction SilentlyContinue
if (Test-Path -LiteralPath $registryPath -PathType Leaf) {
  if ($null -ne $node) {
    $nodeOutput = & $node.Source --check $registryPath 2>&1 | Out-String
    $registrySyntaxPass = ($LASTEXITCODE -eq 0)
    if (-not $registrySyntaxPass) { Write-Host ('  registry syntax error: ' + $nodeOutput.Trim()) }
    Add-Check 'registry JavaScript syntax' $registrySyntaxPass 1 'validated with node --check'
  } else {
    Add-Check 'registry JavaScript syntax' $false 0 'Node.js is unavailable'
  }
}
$chapterDisk = @()
$topicRoot = Join-Path $root 'topics'
if (Test-Path -LiteralPath $topicRoot -PathType Container) {
  $chapterDisk = @(Get-ChildItem -LiteralPath $topicRoot -Recurse -Filter '*.html' -File | Where-Object { $_.Name -ne 'index.html' })
}
$missingRegistryChapters = @($registryChapters | Where-Object { -not (Test-Path -LiteralPath (Join-Path (Join-Path $topicRoot 'az-900') $_.File) -PathType Leaf) })
$listedDiskKeys = @($registryChapters | ForEach-Object { 'az-900/' + $_.File })
$unlistedDisk = @($chapterDisk | Where-Object { $listedDiskKeys -notcontains ($_.Directory.Name + '/' + $_.Name) })
Add-Check 'registry chapters exist' ($missingRegistryChapters.Count -eq 0) $registryChapters.Count $(if ($missingRegistryChapters.Count) { 'missing: ' + (($missingRegistryChapters | ForEach-Object File) -join ', ') } else { 'all registry files exist' })
Add-Check 'disk chapters listed' ($unlistedDisk.Count -eq 0) $chapterDisk.Count $(if ($unlistedDisk.Count) { 'unlisted: ' + (($unlistedDisk | ForEach-Object { $_.Directory.Name + '/' + $_.Name }) -join ', ') } else { 'all chapter HTML files listed' })

$chainPass = $true
$chainCount = 0
$hubFile = 'index.html'
for ($i = 0; $i -lt $registryChapters.Count; $i++) {
  $chapter = $registryChapters[$i]
  $chapterPath = Join-Path (Join-Path $topicRoot 'az-900') $chapter.File
  if (-not (Test-Path -LiteralPath $chapterPath -PathType Leaf)) { continue }
  $chainCount++
  $chapterText = [IO.File]::ReadAllText($chapterPath)
  $prev = [regex]::Match($chapterText, 'href="([^"]+)">&larr; Prev').Groups[1].Value
  $next = [regex]::Match($chapterText, 'href="([^"]+)">Next &rarr;').Groups[1].Value
  $expectedPrev = if ($i -eq 0) { $hubFile } else { $registryChapters[$i - 1].File }
  $expectedNext = if ($i -eq ($registryChapters.Count - 1)) { $hubFile } else { $registryChapters[$i + 1].File }
  if ($prev -ne $expectedPrev -or $next -ne $expectedNext) {
    $chainPass = $false
    Write-Host ("  chain mismatch {0}: Prev={1}, Next={2}; expected Prev={3}, Next={4}" -f $chapter.File, $prev, $next, $expectedPrev, $expectedNext)
  }
}
Add-Check 'prev/next chain' $chainPass $chainCount 'chain matches registry order; endpoints link to hub'

$rootIndex = Join-Path $root 'index.html'
$rootText = if (Test-Path -LiteralPath $rootIndex -PathType Leaf) { [IO.File]::ReadAllText($rootIndex) } else { '' }
$launcherPass = $true
$launcherMatches = [regex]::Matches($rootText, 'href="(topics/[^"/]+/index\.html)"')
foreach ($m in $launcherMatches) {
  $launcherTarget = Join-Path $root ($m.Groups[1].Value -replace '/', '\')
  if (-not (Test-Path -LiteralPath $launcherTarget -PathType Leaf)) {
    $launcherPass = $false
    Write-Host ('  missing launcher card target: ' + $m.Groups[1].Value)
  }
}
foreach ($topic in $topics) {
  $expectedHref = 'topics/' + $topic.Slug + '/index.html'
  if ($rootText -notmatch ('href="' + [regex]::Escape($expectedHref) + '"')) {
    $launcherPass = $false
    Write-Host ('  missing launcher card: ' + $topic.Slug)
  }
  $hubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  if (-not (Test-Path -LiteralPath $hubPath -PathType Leaf)) {
    $launcherPass = $false
    Write-Host ('  missing launcher target: ' + $topic.HubPath)
  }
}
$expectedLauncherHrefs = @($topics | ForEach-Object { 'topics/' + $_.Slug + '/index.html' })
$actualLauncherHrefs = @($launcherMatches | ForEach-Object { $_.Groups[1].Value })
if ($actualLauncherHrefs.Count -ne $expectedLauncherHrefs.Count -or ($actualLauncherHrefs -join '|') -ne ($expectedLauncherHrefs -join '|')) {
  $launcherPass = $false
  Write-Host ('  launcher href mismatch: actual=' + ($actualLauncherHrefs -join ', ') + '; expected=' + ($expectedLauncherHrefs -join ', '))
}
Add-Check 'launcher topic cards' $launcherPass $launcherMatches.Count ("cards={0}, registry-topics={1}, exact href order" -f $launcherMatches.Count, $topics.Count)

$hubPass = $true
$hubCardCount = 0
$hubIndex = Join-Path $root 'topics\az-900\index.html'
$hubText = if (Test-Path -LiteralPath $hubIndex -PathType Leaf) { [IO.File]::ReadAllText($hubIndex) } else { '' }
$hubCardMatches = [regex]::Matches($hubText, '<article\s+class="card">\s*<a\s+href="([^"]+\.html)"')
$hubCardCount = $hubCardMatches.Count
$expectedHubCount = if ($topics.Count -gt 0) { @($registryChapters).Count } else { 0 }
foreach ($m in $hubCardMatches) {
  $cardPath = Join-Path (Split-Path -Parent $hubIndex) $m.Groups[1].Value
  if (-not (Test-Path -LiteralPath $cardPath -PathType Leaf)) {
    $hubPass = $false
    Write-Host ('  missing hub card target: ' + $m.Groups[1].Value)
  }
}
$expectedHubHrefs = @($registryChapters | ForEach-Object { $_.File })
$actualHubHrefs = @($hubCardMatches | ForEach-Object { $_.Groups[1].Value })
if ($hubCardCount -ne $expectedHubCount -or ($actualHubHrefs -join '|') -ne ($expectedHubHrefs -join '|')) {
  $hubPass = $false
  Write-Host ('  hub href mismatch: actual=' + ($actualHubHrefs -join ', ') + '; expected=' + ($expectedHubHrefs -join ', '))
}
Add-Check 'hub chapter cards' $hubPass $hubCardCount ("found={0}, registry={1}, exact href order" -f $hubCardCount, $expectedHubCount)

$htmlFiles = @()
if (Test-Path -LiteralPath $root -PathType Container) { $htmlFiles = @(Get-ChildItem -LiteralPath $root -Recurse -Filter '*.html' -File) }
$staticPass = $true
$nonAsciiCount = 0
$styleCount = 0
$retiredCount = 0
$rootAssetCount = 0
$remoteAssetCount = 0
foreach ($file in $htmlFiles) {
  $bytes = [IO.File]::ReadAllBytes($file.FullName)
  if (@($bytes | Where-Object { $_ -gt 127 }).Count -gt 0) { $nonAsciiCount++; $staticPass = $false; Write-Host ('  non-ASCII bytes: ' + $file.FullName) }
  $text = [IO.File]::ReadAllText($file.FullName)
  if ($text -match '(?i)<style\b') { $styleCount++; $staticPass = $false; Write-Host ('  style tag: ' + $file.FullName) }
  if ($text -match 'az900-theme') { $retiredCount++; $staticPass = $false; Write-Host ('  retired key: ' + $file.FullName) }
  if ($text -match '(?i)["'']/assets/') { $rootAssetCount++; $staticPass = $false; Write-Host ('  root-relative asset path: ' + $file.FullName) }
  if ($text -match '(?i)<(?:script\b[^>]*\bsrc|link\b[^>]*\bhref)\s*=\s*["'']https?://') { $remoteAssetCount++; $staticPass = $false; Write-Host ('  remote script/stylesheet: ' + $file.FullName) }
}
Add-Check 'static HTML restrictions' $staticPass $htmlFiles.Count ("style={0}, retired={1}, root-assets={2}, remote-assets={3}, non-ascii-files={4}" -f $styleCount, $retiredCount, $rootAssetCount, $remoteAssetCount, $nonAsciiCount)

$anchorPass = $true
$anchorCount = 0
foreach ($file in $htmlFiles) {
  $text = [IO.File]::ReadAllText($file.FullName)
  $ids = @{}
  foreach ($id in [regex]::Matches($text, 'id\s*=\s*["'']([^"'']+)["'']')) { $ids[$id.Groups[1].Value] = $true }
  foreach ($anchor in [regex]::Matches($text, 'href\s*=\s*["'']#([^"''#]+)["'']')) {
    $anchorCount++
    if (-not $ids.ContainsKey($anchor.Groups[1].Value)) { $anchorPass = $false; Write-Host ('  missing anchor #' + $anchor.Groups[1].Value + ': ' + $file.FullName) }
  }
}
Add-Check 'same-file anchors' $anchorPass $anchorCount 'every href="#x" has matching id'

$pagePass = $true
$skipCount = 0
$mainCount = 0
$assetRefCount = 0
foreach ($file in $htmlFiles) {
  $text = [IO.File]::ReadAllText($file.FullName)
  if ($text -match '<body>\s*<a class="skip" href="#main">Skip to content</a>') { $skipCount++ } else { $pagePass = $false; Write-Host ('  missing first-child skip link: ' + $file.FullName) }
  if ($text -match '<main\b[^>]*\bid="main"') { $mainCount++ } else { $pagePass = $false; Write-Host ('  missing main#main: ' + $file.FullName) }
  if ($text -match 'theme\.js' -and $text -match 'theme\.css') { $assetRefCount++ } else { $pagePass = $false; Write-Host ('  missing shared asset refs: ' + $file.FullName) }
}
Add-Check 'page accessibility and shared refs' $pagePass $htmlFiles.Count ("skip={0}, main={1}, shared-assets={2}, pages={3}" -f $skipCount, $mainCount, $assetRefCount, $htmlFiles.Count)

Write-Host ''
if ($failures -eq 0) {
  Write-Host ("PASS: {0} checks, 0 failures." -f $checks)
  exit 0
} else {
  Write-Host ("FAIL: {0} checks, {1} failures." -f $checks, $failures)
  exit 1
}
