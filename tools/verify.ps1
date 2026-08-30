$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$assetRoot = Join-Path $root 'assets'
$topicRoot = Join-Path (Join-Path $root 'topics') 'az-900'
$registryPath = Join-Path $assetRoot 'registry.js'
$studyPath = Join-Path $assetRoot 'study.js'
$failures = 0
$checks = 0

function Add-Check {
  param([string]$Name, [bool]$Passed, [int]$Count, [string]$Detail)
  $script:checks++
  $label = if ($Passed) { 'PASS' } else { 'FAIL' }
  if (-not $Passed) { $script:failures++ }
  Write-Host ("{0} {1}: {2} ({3})" -f $label, $Name, $Detail, $Count)
}
function Add-Skip {
  param([string]$Name, [int]$Count, [string]$Detail)
  $script:checks++
  Write-Host ("SKIP {0}: {1} ({2})" -f $Name, $Detail, $Count)
}
function Read-Text {
  param([string]$Path)
  if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $null }
  try { return [IO.File]::ReadAllText($Path) } catch { return $null }
}
function Number-Value {
  param([string]$Value)
  try { return [double]::Parse($Value, [Globalization.CultureInfo]::InvariantCulture) } catch { return $null }
}
function Normalize-ObjectiveId {
  param([string]$Value)
  return $Value.ToLowerInvariant()
}

$registryText = Read-Text $registryPath
$registryLoaded = $null -ne $registryText
if (-not $registryLoaded) {
  Add-Check 'registry file' $false 0 'assets/registry.js is missing or unreadable'
}
$topics = @()
$registryChapters = @()
if ($registryLoaded) {
  try {
    foreach ($m in [regex]::Matches($registryText, 'slug:\s*"([^"]+)"\s*,\s*hubPath:\s*"([^"]+)"')) {
      $topics += [pscustomobject]@{ Slug = $m.Groups[1].Value; HubPath = $m.Groups[2].Value }
    }
    foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"(c\d{2})"\s*,\s*file:\s*"([^"]+)"\s*,\s*title:\s*"([^"]+)"\s*,\s*shortTitle:\s*"([^"]+)"\s*,\s*domain:\s*"([^"]+)"\s*,\s*weight:\s*"([^"]+)"')) {
      $registryChapters += [pscustomobject]@{ Id = $m.Groups[1].Value; File = $m.Groups[2].Value; Title = $m.Groups[3].Value; ShortTitle = $m.Groups[4].Value; Domain = $m.Groups[5].Value; Weight = $m.Groups[6].Value }
    }
  } catch { }
}
$metadataPass = $registryLoaded -and $topics.Count -gt 0 -and $registryChapters.Count -eq 11
Add-Check 'registry metadata extraction' $metadataPass ($topics.Count + $registryChapters.Count) ("topics={0}, chapters={1}" -f $topics.Count, $registryChapters.Count)

$node = Get-Command node -ErrorAction SilentlyContinue
$syntaxPass = $false
if (-not $registryLoaded) {
  Add-Check 'registry JavaScript syntax' $false 0 'registry file unavailable'
} elseif ($null -eq $node) {
  Add-Check 'registry JavaScript syntax' $false 0 'Node.js is unavailable'
} else {
  $nodeOutput = & $node.Source --check $registryPath 2>&1 | Out-String
  $syntaxPass = $LASTEXITCODE -eq 0
  if (-not $syntaxPass) { Write-Host ('  registry syntax error: ' + $nodeOutput.Trim()) }
  Add-Check 'registry JavaScript syntax' $syntaxPass 1 'validated with node --check'
}

$chapterDisk = @()
if (Test-Path -LiteralPath $topicRoot -PathType Container) {
  $chapterDisk = @(Get-ChildItem -LiteralPath $topicRoot -Filter '*.html' -File | Where-Object { $_.Name -notin @('index.html', 'review.html', 'glossary.html') })
}
$missingRegistryChapters = @($registryChapters | Where-Object { -not (Test-Path -LiteralPath (Join-Path $topicRoot $_.File) -PathType Leaf) })
$listedDiskKeys = @($registryChapters | ForEach-Object { $_.File })
$unlistedDisk = @($chapterDisk | Where-Object { $listedDiskKeys -notcontains $_.Name })
Add-Check 'registry chapters exist' ($metadataPass -and $missingRegistryChapters.Count -eq 0) $registryChapters.Count $(if ($missingRegistryChapters.Count) { 'missing: ' + (($missingRegistryChapters | ForEach-Object File) -join ', ') } else { 'all registry files exist' })
Add-Check 'disk chapters listed' ($metadataPass -and $unlistedDisk.Count -eq 0 -and $chapterDisk.Count -eq 11) $chapterDisk.Count $(if ($unlistedDisk.Count) { 'unlisted: ' + (($unlistedDisk | ForEach-Object Name) -join ', ') } else { 'all 11 chapter HTML files listed' })

$hubPath = Join-Path $topicRoot 'index.html'
$hubText = Read-Text $hubPath
$rootIndex = Join-Path $root 'index.html'
$rootText = Read-Text $rootIndex

$chainPass = $true
$chainCount = 0
for ($i = 0; $i -lt $registryChapters.Count; $i++) {
  $chapterPath = Join-Path $topicRoot $registryChapters[$i].File
  $chapterText = Read-Text $chapterPath
  if ($null -eq $chapterText) { $chainPass = $false; continue }
  $chainCount++
  $prev = [regex]::Match($chapterText, 'href="([^"]+)">&larr; Prev').Groups[1].Value
  $next = [regex]::Match($chapterText, 'href="([^"]+)">Next &rarr;').Groups[1].Value
  $expectedPrev = if ($i -eq 0) { 'index.html' } else { $registryChapters[$i - 1].File }
  $expectedNext = if ($i -eq $registryChapters.Count - 1) { 'index.html' } else { $registryChapters[$i + 1].File }
  if ($prev -ne $expectedPrev -or $next -ne $expectedNext) {
    $chainPass = $false
    Write-Host ("  chain mismatch {0}: Prev={1}, Next={2}; expected Prev={3}, Next={4}" -f $registryChapters[$i].File, $prev, $next, $expectedPrev, $expectedNext)
  }
}
Add-Check 'prev/next chain' ($chainPass -and $chainCount -eq 11) $chainCount 'chain matches registry order; endpoints link to hub'

$launcherPass = $null -ne $rootText
$launcherMatches = @()
if ($null -ne $rootText) { $launcherMatches = @([regex]::Matches($rootText, 'href="(topics/[^"/]+/index\.html)"')) }
foreach ($m in $launcherMatches) {
  $target = Join-Path $root ($m.Groups[1].Value -replace '/', '\')
  if (-not (Test-Path -LiteralPath $target -PathType Leaf)) { $launcherPass = $false; Write-Host ('  missing launcher card target: ' + $m.Groups[1].Value) }
}
foreach ($topic in $topics) {
  $expectedHref = 'topics/' + $topic.Slug + '/index.html'
  if ($null -eq $rootText -or $rootText -notmatch ('href="' + [regex]::Escape($expectedHref) + '"')) { $launcherPass = $false; Write-Host ('  missing launcher card: ' + $topic.Slug) }
  $target = Join-Path $root ($topic.HubPath -replace '/', '\')
  if (-not (Test-Path -LiteralPath $target -PathType Leaf)) { $launcherPass = $false; Write-Host ('  missing launcher target: ' + $topic.HubPath) }
}
$expectedLauncherHrefs = @($topics | ForEach-Object { 'topics/' + $_.Slug + '/index.html' })
$actualLauncherHrefs = @($launcherMatches | ForEach-Object { $_.Groups[1].Value })
if (($actualLauncherHrefs -join '|') -ne ($expectedLauncherHrefs -join '|')) { $launcherPass = $false; Write-Host ('  launcher href mismatch: actual=' + ($actualLauncherHrefs -join ', ') + '; expected=' + ($expectedLauncherHrefs -join ', ')) }
Add-Check 'launcher topic cards' $launcherPass $launcherMatches.Count ("cards={0}, registry-topics={1}, exact href order" -f $launcherMatches.Count, $topics.Count)

$hubPass = $null -ne $hubText
$hubCardMatches = @()
if ($null -ne $hubText) { $hubCardMatches = @([regex]::Matches($hubText, '<article\s+class="card">\s*<a\s+href="([^"]+\.html)"')) }
foreach ($m in $hubCardMatches) {
  if (-not (Test-Path -LiteralPath (Join-Path $topicRoot $m.Groups[1].Value) -PathType Leaf)) { $hubPass = $false; Write-Host ('  missing hub card target: ' + $m.Groups[1].Value) }
}
$expectedHubHrefs = @($registryChapters | ForEach-Object File)
$actualHubHrefs = @($hubCardMatches | ForEach-Object { $_.Groups[1].Value })
if ($hubCardMatches.Count -ne 11 -or ($actualHubHrefs -join '|') -ne ($expectedHubHrefs -join '|')) { $hubPass = $false; Write-Host ('  hub href mismatch: actual=' + ($actualHubHrefs -join ', ') + '; expected=' + ($expectedHubHrefs -join ', ')) }
Add-Check 'hub chapter cards' $hubPass $hubCardMatches.Count ("found={0}, registry={1}, exact href order" -f $hubCardMatches.Count, $registryChapters.Count)

$htmlFiles = @()
if (Test-Path -LiteralPath $root -PathType Container) { $htmlFiles = @(Get-ChildItem -LiteralPath $root -Recurse -Filter '*.html' -File) }
$staticPass = $true
$nonAsciiCount = 0; $styleCount = 0; $retiredCount = 0; $rootAssetCount = 0; $remoteAssetCount = 0
foreach ($file in $htmlFiles) {
  $bytes = [IO.File]::ReadAllBytes($file.FullName)
  if (@($bytes | Where-Object { $_ -gt 127 }).Count -gt 0) { $nonAsciiCount++; $staticPass = $false; Write-Host ('  non-ASCII bytes: ' + $file.FullName) }
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $staticPass = $false; continue }
  if ($text -match '(?i)<style\b') { $styleCount++; $staticPass = $false; Write-Host ('  style tag: ' + $file.FullName) }
  if ($text -match 'az900-theme') { $retiredCount++; $staticPass = $false; Write-Host ('  retired key: ' + $file.FullName) }
  if ($text -match '(?i)["'']/assets/') { $rootAssetCount++; $staticPass = $false; Write-Host ('  root-relative asset path: ' + $file.FullName) }
  if ($text -match '(?i)<(?:script\b[^>]*\bsrc|link\b[^>]*\bhref)\s*=\s*["'']https?://') { $remoteAssetCount++; $staticPass = $false; Write-Host ('  remote script/stylesheet: ' + $file.FullName) }
}
Add-Check 'static HTML restrictions' $staticPass $htmlFiles.Count ("style={0}, retired={1}, root-assets={2}, remote-assets={3}, non-ascii-files={4}" -f $styleCount, $retiredCount, $rootAssetCount, $remoteAssetCount, $nonAsciiCount)

$anchorPass = $true; $anchorCount = 0
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $anchorPass = $false; continue }
  $ids = @{}
  foreach ($id in [regex]::Matches($text, 'id\s*=\s*["'']([^"'']+)["'']')) { $ids[$id.Groups[1].Value] = $true }
  foreach ($anchor in [regex]::Matches($text, 'href\s*=\s*["'']#([^"''#]+)["'']')) {
    $anchorCount++
    if (-not $ids.ContainsKey($anchor.Groups[1].Value)) { $anchorPass = $false; Write-Host ('  missing anchor #' + $anchor.Groups[1].Value + ': ' + $file.FullName) }
  }
}
Add-Check 'same-file anchors' $anchorPass $anchorCount 'every href="#x" has matching id'

$pagePass = $true; $skipCount = 0; $mainCount = 0; $assetRefCount = 0
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $pagePass = $false; continue }
  if ($text -match '<body\b[^>]*>\s*<a class="skip" href="#main">Skip to content</a>') { $skipCount++ } else { $pagePass = $false; Write-Host ('  missing first-child skip link: ' + $file.FullName) }
  if ($text -match '<main\b[^>]*\bid="main"') { $mainCount++ } else { $pagePass = $false; Write-Host ('  missing main#main: ' + $file.FullName) }
  if ($text -match 'theme\.js' -and $text -match 'theme\.css') { $assetRefCount++ } else { $pagePass = $false; Write-Host ('  missing shared asset refs: ' + $file.FullName) }
}
Add-Check 'page accessibility and shared refs' ($pagePass -and $skipCount -eq $htmlFiles.Count -and $mainCount -eq $htmlFiles.Count) $htmlFiles.Count ("skip={0}, main={1}, shared-assets={2}, pages={3}" -f $skipCount, $mainCount, $assetRefCount, $htmlFiles.Count)

$objectiveExpected = @{}
if ($registryLoaded) {
  foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"(az900-c\d{2}-o\d+)"\s*,\s*text:\s*"([^"]+)"\s*,\s*domain:\s*"([^"]+)"\s*,\s*chapter:\s*"(c\d{2})"')) { $objectiveExpected[$m.Groups[1].Value] = $m.Groups[4].Value }
}
$objectiveSeen = @{}; $objectiveUnknown = @(); $objectivePass = $objectiveExpected.Count -eq 57
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $objectivePass = $false; continue }
  foreach ($m in [regex]::Matches($text, 'data-objective="([^"]+)"')) {
    foreach ($raw in ($m.Groups[1].Value -split '\s+')) {
      if (-not $raw) { continue }
      $id = Normalize-ObjectiveId $raw
      if ($objectiveExpected.ContainsKey($id)) { $objectiveSeen[$id] = $true } else { $objectiveUnknown += $raw }
    }
  }
}
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $objectivePass = $false; continue }
  foreach ($m in [regex]::Matches($text, '<section\b[^>]*\bid="skills"[\s\S]*?</section>')) {
    foreach ($idMatch in [regex]::Matches($m.Value, '\bid="(az900-c\d{2}-o\d+)"')) {
      $id = Normalize-ObjectiveId $idMatch.Groups[1].Value
      if ($objectiveExpected.ContainsKey($id)) { $objectiveSeen[$id] = $true }
    }
  }
}
$objectiveOrphans = @($objectiveExpected.Keys | Where-Object { -not $objectiveSeen.ContainsKey($_) })
$objectiveUnknown = @($objectiveUnknown | Select-Object -Unique)
if ($objectiveOrphans.Count) { Write-Host ('  objectives with no data-objective reference: ' + ($objectiveOrphans -join ', ')) }
if ($objectiveUnknown.Count) { Write-Host ('  HTML objective values absent from registry: ' + ($objectiveUnknown -join ', ')) }
$objectivePass = $objectivePass -and $objectiveOrphans.Count -eq 0 -and $objectiveUnknown.Count -eq 0
Add-Check 'objective coverage' $objectivePass $objectiveExpected.Count ("registry={0}, referenced={1}, orphan-registry={2}, orphan-html={3}; expected objectives=57, MCQs=110" -f $objectiveExpected.Count, $objectiveSeen.Count, $objectiveOrphans.Count, $objectiveUnknown.Count)

$skillsPass = $objectiveExpected.Count -eq 57; $skillsCount = 0
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $skillsPass = $false; continue }
  $sm = [regex]::Match($text, '<section\b[^>]*\bid="skills"[\s\S]*?</section>')
  if (-not $sm.Success) { $skillsPass = $false; Write-Host ('  missing #skills section: ' + $chapter.File); continue }
  $found = @{}
  foreach ($li in [regex]::Matches($sm.Value, '<li\b([^>]*)>')) {
    $idMatch = [regex]::Match($li.Groups[1].Value, '\bid="([^"]+)"')
    $skillsCount++
    if (-not $idMatch.Success -or $idMatch.Groups[1].Value -notmatch '^az900-c\d{2}-o\d+$') { $skillsPass = $false; Write-Host ('  invalid skills bullet id in ' + $chapter.File) } else { $found[$idMatch.Groups[1].Value] = $true }
  }
  $expected = @($objectiveExpected.Keys | Where-Object { $objectiveExpected[$_] -eq $chapter.Id })
  foreach ($id in $expected) { if (-not $found.ContainsKey($id)) { $skillsPass = $false; Write-Host ('  missing skills bullet ' + $id + ': ' + $chapter.File) } }
  foreach ($id in $found.Keys) { if (-not $objectiveExpected.ContainsKey($id) -or $objectiveExpected[$id] -ne $chapter.Id) { $skillsPass = $false; Write-Host ('  skills bullet not in registry/chapter: ' + $id) } }
}
Add-Check 'skills-bullet ids' ($skillsPass -and $skillsCount -eq 57) $skillsCount 'every #skills li has registry objective id; expected 57'

$idSeen = @{}; $idPass = $true; $recallTotal = 0; $mcqTotal = 0
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $idPass = $false; continue }
  foreach ($m in [regex]::Matches($text, 'data-(recall|mcq)="([^"]+)"')) {
    $kind = $m.Groups[1].Value; $id = $m.Groups[2].Value
    if ($idSeen.ContainsKey($id)) { $idPass = $false; Write-Host ('  duplicate study id ' + $id + ': ' + $file.FullName) } else { $idSeen[$id] = $file.FullName }
    if ($kind -eq 'recall') {
      $recallTotal++
      if ($id -notmatch '^(c\d{2}-r\d{2}|rev-[ds]\d{2})$') { $idPass = $false; Write-Host ('  invalid recall id: ' + $id) }
    } else {
      $mcqTotal++
      if ($id -notmatch '^c\d{2}-q\d{2}$') { $idPass = $false; Write-Host ('  invalid MCQ id: ' + $id) }
    }
  }
}
$chapterPracticeRecall = 0; $chapterPracticeMcq = 0
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $idPass = $false; continue }
  $mcqCount = @([regex]::Matches($text, 'data-mcq="c\d{2}-q\d{2}"')).Count
  $recallCount = @([regex]::Matches($text, 'data-recall="c\d{2}-r\d{2}"')).Count
  $chapterPracticeMcq += $mcqCount; $chapterPracticeRecall += $recallCount
  $expectedRecall = if ($chapter.Id -in @('c03', 'c07')) { 12 } else { 10 }
  if ($mcqCount -ne 10 -or $recallCount -ne $expectedRecall) { $idPass = $false; Write-Host ("  count mismatch {0}: MCQ={1}/10, recall={2}/{3}" -f $chapter.File, $mcqCount, $recallCount, $expectedRecall) }
}
$reviewText = Read-Text (Join-Path $topicRoot 'review.html')
$reviewRecall = if ($null -eq $reviewText) { 0 } else { @([regex]::Matches($reviewText, 'data-recall="rev-[ds]\d{2}"')).Count }
$idPass = $idPass -and $mcqTotal -eq 110 -and $chapterPracticeRecall -eq 114 -and $reviewRecall -eq 22
Add-Check 'recall and MCQ integrity' $idPass ($recallTotal + $mcqTotal) ("repo-recall={0}, chapter-recall={1}, review-recall={2}, mcq={3}, unique={4}; expected MCQs=110" -f $recallTotal, $chapterPracticeRecall, $reviewRecall, $mcqTotal, $idSeen.Count)

$confusionPass = $registryLoaded -and $null -ne $hubText; $confusionCount = 0
$confusionMatches = if ($registryLoaded) { @([regex]::Matches($registryText, '\{\s*id:\s*"([^"]+)"\s*,\s*discriminator:\s*"([^"]+)"\s*,\s*objectiveIds:\s*\[[^\]]*\]\s*,\s*calloutChapter:\s*"([^"]+)"\s*,\s*hubLinkTarget:\s*"([^"]+)"\s*\}')) } else { @() }
foreach ($cm in $confusionMatches) {
  $confusionCount++; $id = $cm.Groups[1].Value; $actualChapter = $cm.Groups[3].Value; $hubTarget = $cm.Groups[4].Value
  $chapterRecord = @($registryChapters | Where-Object Id -eq $actualChapter)
  if ($chapterRecord.Count -ne 1) { $confusionPass = $false; Write-Host ('  confusion chapter absent from registry: ' + $id + ' -> ' + $actualChapter); continue }
  $targetFile = $chapterRecord[0].File
  $targetParts = $hubTarget -split '#', 2
  if ($targetParts[0] -ne $targetFile) { $confusionPass = $false; Write-Host ("  confusion target mismatch {0}: hub={1}, chapter={2}" -f $id, $hubTarget, $targetFile) }
  $targetPath = Join-Path $topicRoot $targetFile; $targetText = Read-Text $targetPath
  if ($null -eq $targetText) { $confusionPass = $false; Write-Host ('  confusion file missing: ' + $targetFile); continue }
  $fragment = if ($targetParts.Count -gt 1) { $targetParts[1] } else { '' }
  $calloutScope = $targetText
  if ($calloutScope -notmatch 'class="[^"]*\bcal\b[^"]*\bconfuse\b[^"]*"') { $confusionPass = $false; Write-Host ('matching confuse callout missing in chapter: ' + $id + ' -> ' + $targetFile) }
  foreach ($term in ($id -split '-')) {
    if ($calloutScope -notmatch ('(?i)\b' + [regex]::Escape($term) + '\b')) { $confusionPass = $false; Write-Host ('  chapter callout does not mention confusion term ' + $term + ': ' + $id) }
  }
  $exactHubLinks = if ($null -eq $hubText) { @() } else { @([regex]::Matches($hubText, 'href="' + [regex]::Escape($hubTarget) + '"')) }
  $hubChapterLinks = if ($null -eq $hubText) { @() } else { @([regex]::Matches($hubText, 'href="' + [regex]::Escape($targetFile) + '#[^"]+"')) }
  if ($exactHubLinks.Count -ne 1 -and $hubChapterLinks.Count -ne 1) { $confusionPass = $false; Write-Host ('  hub link target missing, duplicated, or points at wrong chapter: ' + $targetFile) }
}
if ($confusionCount -ne 10) { $confusionPass = $false; Write-Host ("  registry confusion sets found {0}; expected 10" -f $confusionCount) }
Add-Check 'confusion set integrity' $confusionPass $confusionCount 'registry sets resolve to real callouts; hub targets equal callout chapters'

$geometryPass = $registryLoaded; $svgCount = 0; $rectCount = 0; $geometrySkips = 0
$ruleCount = if ($registryLoaded) { @([regex]::Matches($registryText, 'geometryRules:\s*\[')).Count } else { 0 }
$requiredRuleCount = if ($registryLoaded) { @([regex]::Matches($registryText, 'nothing sits outside the viewBox|no stroke sits exactly on the viewBox edge|centred labels use text-anchor=middle')).Count } else { 0 }
if ($ruleCount -ne 7 -or $requiredRuleCount -lt 21) { $geometryPass = $false; Write-Host ("  registry geometry rules incomplete: archetypes={0}, required-rule mentions={1}" -f $ruleCount, $requiredRuleCount) }
$diagramUses = if ($registryLoaded) { @([regex]::Matches($registryText, 'chapter:\s*"(c\d{2})"\s*,\s*section:\s*"([^"]+)"\s*,\s*label:\s*"([^"]+)"')) } else { @() }
foreach ($use in $diagramUses) {
  $chapterRecord = @($registryChapters | Where-Object Id -eq $use.Groups[1].Value)
  if ($chapterRecord.Count -ne 1) { $geometryPass = $false; continue }
  $chapterText = Read-Text (Join-Path $topicRoot $chapterRecord[0].File)
  $section = [regex]::Match($chapterText, '<section\b[^>]*\bid="' + [regex]::Escape($use.Groups[2].Value) + '"[\s\S]*?</section>').Value
  $svgMatch = [regex]::Match($chapterText, '<svg\b[^>]*role="img"[^>]*aria-label="' + [regex]::Escape($use.Groups[3].Value) + '"[\s\S]*?</svg>')
  if (-not $svgMatch.Success) { $geometryPass = $false; Write-Host ('  diagram missing registry use: ' + $use.Groups[1].Value + '#' + $use.Groups[2].Value); continue }
  $svgCount++; $svgAttrs = [regex]::Match($svgMatch.Value, '^<svg\b([^>]*)>').Groups[1].Value; $svgBody = [regex]::Match($svgMatch.Value, '^<svg\b[^>]*>([\s\S]*)</svg>$').Groups[1].Value
  $vm = [regex]::Match($svgAttrs, 'viewBox="\s*([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)"')
  if (-not $vm.Success) { $geometryPass = $false; Write-Host ('  diagram missing numeric viewBox: ' + $use.Groups[3].Value); continue }
  $vx = Number-Value $vm.Groups[1].Value; $vy = Number-Value $vm.Groups[2].Value; $vw = Number-Value $vm.Groups[3].Value; $vh = Number-Value $vm.Groups[4].Value
  $boxes = @()
  foreach ($rm in [regex]::Matches($svgBody, '<rect\b([^>]*)/?>')) {
    $a = $rm.Groups[1].Value; $xM=[regex]::Match($a, '\bx="([-\d.]+)"'); $yM=[regex]::Match($a, '\by="([-\d.]+)"'); $wM=[regex]::Match($a, '\bwidth="([-\d.]+)"'); $hM=[regex]::Match($a, '\bheight="([-\d.]+)"')
    if (-not ($xM.Success -and $yM.Success -and $wM.Success -and $hM.Success)) { $geometrySkips++; continue }
    $x=Number-Value $xM.Groups[1].Value; $y=Number-Value $yM.Groups[1].Value; $w=Number-Value $wM.Groups[1].Value; $h=Number-Value $hM.Groups[1].Value; $rectCount++; $boxes += ,@($x,$y,$w,$h)
    if ($x -lt $vx -or $y -lt $vy -or $x+$w -gt $vx+$vw -or $y+$h -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG rect outside viewBox: ' + $use.Groups[3].Value) }
    if ($x -eq $vx -or $y -eq $vy -or $x+$w -eq $vx+$vw -or $y+$h -eq $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG rect stroke on viewBox edge: ' + $use.Groups[3].Value) }
  }
  foreach ($cm in [regex]::Matches($svgBody, '<circle\b([^>]*)/?>')) {
    $a=$cm.Groups[1].Value; $cxM=[regex]::Match($a, '\bcx="([-\d.]+)"'); $cyM=[regex]::Match($a, '\bcy="([-\d.]+)"'); $rM=[regex]::Match($a, '\br="([-\d.]+)"')
    if ($cxM.Success -and $cyM.Success -and $rM.Success) { $cx=Number-Value $cxM.Groups[1].Value; $cy=Number-Value $cyM.Groups[1].Value; $r=Number-Value $rM.Groups[1].Value; if ($cx-$r -lt $vx -or $cy-$r -lt $vy -or $cx+$r -gt $vx+$vw -or $cy+$r -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG circle outside viewBox: ' + $use.Groups[3].Value) } } else { $geometrySkips++ }
  }
  foreach ($em in [regex]::Matches($svgBody, '<ellipse\b([^>]*)/?>')) {
    $a=$em.Groups[1].Value; $cxM=[regex]::Match($a, '\bcx="([-\d.]+)"'); $cyM=[regex]::Match($a, '\bcy="([-\d.]+)"'); $rxM=[regex]::Match($a, '\brx="([-\d.]+)"'); $ryM=[regex]::Match($a, '\bry="([-\d.]+)"')
    if ($cxM.Success -and $cyM.Success -and $rxM.Success -and $ryM.Success) { $cx=[double](Number-Value $cxM.Groups[1].Value); $cy=[double](Number-Value $cyM.Groups[1].Value); $rx=[double](Number-Value $rxM.Groups[1].Value); $ry=[double](Number-Value $ryM.Groups[1].Value); $bx=$cx-$rx; $by=$cy-$ry; $bw=2*$rx; $bh=2*$ry; $boxes += ,@($bx,$by,$bw,$bh); if ($bx -lt $vx -or $by -lt $vy -or $bx+$bw -gt $vx+$vw -or $by+$bh -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG ellipse outside viewBox: ' + $use.Groups[3].Value) } } else { $geometrySkips++ }
  }
  foreach ($lm in [regex]::Matches($svgBody, '<line\b([^>]*)/?>')) {
    $a=$lm.Groups[1].Value; $values=@(); foreach($n in @('x1','y1','x2','y2')) { $nm=[regex]::Match($a, '\b'+$n+'="([-\d.]+)"'); if($nm.Success){$values += Number-Value $nm.Groups[1].Value} }; if($values.Count -eq 4){if(($values[0] -lt $vx) -or ($values[2] -lt $vx) -or ($values[0] -gt $vx+$vw) -or ($values[2] -gt $vx+$vw) -or ($values[1] -lt $vy) -or ($values[3] -lt $vy) -or ($values[1] -gt $vy+$vh) -or ($values[3] -gt $vy+$vh)){ $geometryPass=$false; Write-Host ('  SVG line outside viewBox: ' + $use.Groups[3].Value)}} else {$geometrySkips++}
  }
  foreach ($tm in [regex]::Matches($svgBody, '<text\b([^>]*)>')) {
    $a=$tm.Groups[1].Value; $txM=[regex]::Match($a, '\bx="([-\d.]+)"'); $tyM=[regex]::Match($a, '\by="([-\d.]+)"'); if(-not($txM.Success -and $tyM.Success)){ $geometrySkips++; continue }; $tx=Number-Value $txM.Groups[1].Value; $ty=Number-Value $tyM.Groups[1].Value
    if ($tx -lt $vx -or $tx -gt $vx+$vw -or $ty -lt $vy -or $ty -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG text outside viewBox: ' + $use.Groups[3].Value) }
    foreach($box in $boxes){$centerX=$box[0]+$box[2]/2; if([math]::Abs($tx-$centerX) -lt 0.001 -and $ty -ge $box[1] -and $ty -le $box[1]+$box[3] -and $a -notmatch 'text-anchor="middle"'){ $geometryPass=$false; Write-Host ('  SVG centered text lacks text-anchor=middle: ' + $use.Groups[3].Value) }}
  }
  if ($svgBody -match '<path\b|<polyline\b|<polygon\b') { $geometrySkips++ }
}
if ($diagramUses.Count -ne 15 -or $svgCount -ne 15) { $geometryPass = $false; Write-Host ("  diagram catalogue/use count mismatch: registry={0}, matched SVGs={1}" -f $diagramUses.Count, $svgCount) }
Add-Check 'SVG geometry bounds and labels' $geometryPass $svgCount ("checked diagrams={0}, rects={1}, registry geometry rules={2}" -f $svgCount, $rectCount, $ruleCount)
if ($geometrySkips -gt 0) { Add-Skip 'SVG unsupported geometry' $geometrySkips 'path curves, transforms, markers, and text glyph extents are not statically checkable with regex' }

$studyPass = $true; $studyPages = 0
$studyPagePaths = @($registryChapters | ForEach-Object { Join-Path $topicRoot $_.File }) + @($hubPath, (Join-Path $topicRoot 'review.html'))
foreach ($path in $studyPagePaths) {
  $text = Read-Text $path
  $name = Split-Path -Leaf $path
  if ($null -eq $text) { $studyPass = $false; Write-Host ('  study page missing: ' + $path); continue }
  $studyPages++
  $scripts = @([regex]::Matches($text, 'assets/study\.js')).Count; $mounts = @([regex]::Matches($text, 'id="study-summary"')).Count; $trailing = $text -match 'assets/study\.js"\s*>\s*</script>\s*(?:<script\s+src="\.\./\.\./assets/model\.js"></script>\s*)?</body>'
  if ($scripts -ne 1 -or $mounts -ne 1 -or -not $trailing) { $studyPass = $false; Write-Host ("  study contract {0}: scripts={1}, mounts={2}, trailing={3}" -f $name, $scripts, $mounts, $trailing) }
}
$studyText = Read-Text $studyPath
$studyCode = $null
$studySyntaxPass = $false
$moduleSyntaxCount = 0; $networkCallCount = 0; $varSyntaxCount = 0
if ($null -ne $studyText) {
  # Remove comments before syntax checks: words in comments are not code.
  $studyCode = [regex]::Replace($studyText, '(?s)/\*.*?\*/', '')
  $studyCode = [regex]::Replace($studyCode, '(?m)//[^\r\n]*', '')
  $moduleSyntaxCount = @([regex]::Matches($studyCode, '(?m)^\s*(?:import|export)\b')).Count
  $networkCallCount = @([regex]::Matches($studyCode, '(?m)(?<![\w$])(?:[\w$]+\.)*fetch\s*\(')).Count
  $varSyntaxCount = @([regex]::Matches($studyCode, '\bvar\b')).Count
  $studySyntaxPass = $moduleSyntaxCount -eq 0 -and $networkCallCount -eq 0 -and $varSyntaxCount -eq 0
  if (-not $studySyntaxPass) { Write-Host ("  study.js forbidden syntax: module={0}, network={1}, var={2}" -f $moduleSyntaxCount, $networkCallCount, $varSyntaxCount) }
}
if ($null -eq $studyText) { $studyPass = $false; Write-Host '  study.js missing or unreadable' } elseif (-not $studySyntaxPass) { $studyPass = $false }
Add-Check 'study contract' ($studyPass -and $studyPages -eq 13) $studyPages '11 chapters, review, and hub each have one mount and one trailing classic study script; syntax is classic and local-only'

$modelContractPass = $registryLoaded; $modelContractCount = 0; $modelCellCount = 0; $modelFailures = @()
$modelRecords = @()
$modelRuntimeText = Read-Text (Join-Path $assetRoot 'model.js')
if (-not $registryLoaded -or $registryText -notmatch 'interactiveModel\s*:') {
  $modelContractPass = $false; $modelFailures += 'interactiveModel declaration missing'
} else {
  $modelBlock = [regex]::Match($registryText, 'interactiveModel\s*:\s*\{([\s\S]*?)\n\s*\},\s*\n\s*/\* 7\. QUESTION SCHEMA').Groups[1].Value
  if ([string]::IsNullOrWhiteSpace($modelBlock)) { $modelContractPass = $false; $modelFailures += 'interactiveModel block unreadable' }
  foreach ($m in [regex]::Matches($modelBlock, '\{\s*id:\s*"([^"]+)"\s*,\s*chapter:\s*"([^"]+)"\s*,\s*section:\s*"([^"]+)"\s*,\s*rowCount:\s*(\d+)\s*,\s*columnCount:\s*(\d+)\s*\}')) {
    $modelRecords += [pscustomobject]@{ Id = $m.Groups[1].Value; Chapter = $m.Groups[2].Value; Section = $m.Groups[3].Value; Rows = [int]$m.Groups[4].Value; Columns = [int]$m.Groups[5].Value }
  }
  if ($modelRecords.Count -ne 3) { $modelContractPass = $false; $modelFailures += ('registered models=' + $modelRecords.Count + ', expected=3') }
  if ($modelBlock -notmatch 'sourceOfTruth:\s*"Static HTML table\.model-matrix') { $modelContractPass = $false; $modelFailures += 'static source-of-truth declaration missing' }
  if ($modelBlock -notmatch 'Registry declares identity and dimensions, not outcome values') { $modelContractPass = $false; $modelFailures += 'registry value-boundary declaration missing' }
}
if ($null -eq $modelRuntimeText) {
  $modelContractPass = $false; $modelFailures += 'assets/model.js missing'
} else {
  if ($modelRuntimeText -notmatch 'querySelector\("table\.model-matrix"\)') { $modelContractPass = $false; $modelFailures += 'runtime does not read table.model-matrix' }
  if ($modelRuntimeText -notmatch 'outcomes:\s*cells\.map\(text\)') { $modelContractPass = $false; $modelFailures += 'runtime does not derive outcomes from matrix cells' }
  if ($modelRuntimeText -match 'outcomes\s*=\s*\[\s*"') { $modelContractPass = $false; $modelFailures += 'runtime contains hard-coded outcome array' }
}
foreach ($model in $modelRecords) {
  $modelContractCount++
  $chapterRecord = @($registryChapters | Where-Object Id -eq $model.Chapter)
  if ($chapterRecord.Count -ne 1) { $modelContractPass = $false; $modelFailures += ($model.Id + ': chapter not in registry'); continue }
  $chapterText = Read-Text (Join-Path $topicRoot $chapterRecord[0].File)
  if ($null -eq $chapterText) { $modelContractPass = $false; $modelFailures += ($model.Id + ': chapter file missing'); continue }
  $sectionMatch = [regex]::Match($chapterText, '<section\b[^>]*\bid="' + [regex]::Escape($model.Section) + '"[\s\S]*?</section>')
  if (-not $sectionMatch.Success) { $modelContractPass = $false; $modelFailures += ($model.Id + ': section missing'); continue }
  $sectionText = $sectionMatch.Value
  $modelDivs = @([regex]::Matches($sectionText, '<div\b(?=[^>]*\bclass="[^"]*\bmodel\b[^"]*")(?=[^>]*\bdata-model="' + [regex]::Escape($model.Id) + '")[^>]*>'))
  if ($modelDivs.Count -ne 1) { $modelContractPass = $false; $modelFailures += ($model.Id + ': model div count=' + $modelDivs.Count); continue }
  $matrixMatches = @([regex]::Matches($sectionText, '<table\b(?=[^>]*\bclass="[^"]*\bmodel-matrix\b[^"]*")[^>]*>[\s\S]*?</table>'))
  if ($matrixMatches.Count -ne 1) { $modelContractPass = $false; $modelFailures += ($model.Id + ': matrix table count=' + $matrixMatches.Count); continue }
  $matrix = $matrixMatches[0].Value
  $headMatch = [regex]::Match($matrix, '<thead\b[\s\S]*?</thead>')
  $headerCells = if ($headMatch.Success) { @([regex]::Matches($headMatch.Value, '<(?:th|td)\b[^>]*>([\s\S]*?)</(?:th|td)>')) } else { @() }
  $bodyMatch = [regex]::Match($matrix, '<tbody\b[\s\S]*?</tbody>')
  $rows = if ($bodyMatch.Success) { @([regex]::Matches($bodyMatch.Value, '<tr\b[\s\S]*?</tr>')) } else { @() }
  if ($headerCells.Count -ne ($model.Columns + 1)) { $modelContractPass = $false; $modelFailures += ($model.Id + ': header cells=' + $headerCells.Count + ', expected=' + ($model.Columns + 1)) }
  if ($rows.Count -ne $model.Rows) { $modelContractPass = $false; $modelFailures += ($model.Id + ': rows=' + $rows.Count + ', expected=' + $model.Rows) }
  foreach ($row in $rows) {
    $cells = @([regex]::Matches($row.Value, '<(?:th|td)\b[^>]*>([\s\S]*?)</(?:th|td)>'))
    if ($cells.Count -ne ($model.Columns + 1)) { $modelContractPass = $false; $modelFailures += ($model.Id + ': row cells=' + $cells.Count + ', expected=' + ($model.Columns + 1)) }
    foreach ($cell in $cells) { $cellText = [regex]::Replace($cell.Groups[1].Value, '<[^>]+>', '').Trim(); if ([string]::IsNullOrWhiteSpace($cellText)) { $modelContractPass = $false; $modelFailures += ($model.Id + ': empty matrix cell') } else { $modelCellCount++ } }
  }
  foreach ($cell in $headerCells) { $headerText = [regex]::Replace($cell.Groups[1].Value, '<[^>]+>', '').Trim(); if ([string]::IsNullOrWhiteSpace($headerText)) { $modelContractPass = $false; $modelFailures += ($model.Id + ': empty matrix header') } }
}
if ($modelFailures.Count) { Write-Host ('  interactive model contract: ' + ($modelFailures -join '; ')) }
Add-Check 'interactive model contract' $modelContractPass $modelContractCount ("registered={0}, nonempty-static-cells={1}; matrix is sole outcome source" -f $modelContractCount, $modelCellCount)

$componentNames = @('tldr', 'myth', 'steps', 'glossary-link', 'study-brief', 'model')
$componentPass = $registryLoaded; $componentHits = 0
if ($registryLoaded) {
  foreach ($name in $componentNames) {
    $property = if ($name -match '-') { '"' + [regex]::Escape($name) + '"' } else { '\b' + [regex]::Escape($name) + '\b' }
    if ($registryText -match ('componentCatalogue\s*:\s*\{[\s\S]*?' + $property + '\s*:')) { $componentHits++ } else { $componentPass = $false; Write-Host ('  component catalogue entry missing: ' + $name) }
  }
  if ($registryText -notmatch 'componentCatalogue\s*:\s*\{') { $componentPass = $false }
  if ($registryText -notmatch 'glossaryAnchorRule\s*:') { $componentPass = $false; Write-Host '  glossary anchor slug rule missing from registry' }
  $requiredMarkupCount = @([regex]::Matches($registryText, '\brequiredMarkup\s*:')).Count
  $invariantCount = @([regex]::Matches($registryText, '\binvariants\s*:')).Count
  if ($requiredMarkupCount -lt 5 -or $invariantCount -lt 5) { $componentPass = $false; Write-Host ("  component catalogue contracts incomplete: markup={0}, invariants={1}" -f $requiredMarkupCount, $invariantCount) }
}
Add-Check 'component catalogue' ($componentPass -and $componentHits -eq $componentNames.Count) $componentHits 'tldr, myth, steps, glossary-link, study-brief, and model declare markup and invariants'

$tldrPass = $true; $tldrPages = 0; $tldrCount = 0; $tldrLiTotal = 0
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $tldrPass = $false; Write-Host ('  TL;DR chapter missing: ' + $chapter.File); continue }
  $tldrPages++
  $mainMatch = [regex]::Match($text, '<main\b[^>]*\bid\s*=\s*["'']main["''][^>]*>([\s\S]*?)</main>')
  if (-not $mainMatch.Success) { $tldrPass = $false; Write-Host ('  TL;DR main missing: ' + $chapter.File); continue }
  $mainBody = $mainMatch.Groups[1].Value
  $tldrPattern = '<section\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcard\b[^"'']*\btldr\b[^"'']*["''])(?=[^>]*\bid\s*=\s*["'']tldr["''])[^>]*>[\s\S]*?</section>'
  $tldrMatches = @([regex]::Matches($mainBody, $tldrPattern))
  $tldrCount += $tldrMatches.Count
  $firstSection = [regex]::Match($mainBody, '<section\b[^>]*>')
  $firstIsTldr = $firstSection.Success -and $firstSection.Value -match '\bclass\s*=\s*["''][^"'']*\bcard\b[^"'']*\btldr\b[^"'']*["'']' -and $firstSection.Value -match '\bid\s*=\s*["'']tldr["'']'
  if ($tldrMatches.Count -ne 1 -or -not $firstIsTldr) { $tldrPass = $false; Write-Host ("  TL;DR shape {0}: sections={1}, first={2}" -f $chapter.File, $tldrMatches.Count, $firstIsTldr) }
  if ($tldrMatches.Count -eq 1) {
    $liCount = @([regex]::Matches($tldrMatches[0].Value, '<li\b')).Count; $tldrLiTotal += $liCount
    if ($liCount -lt 4 -or $liCount -gt 6) { $tldrPass = $false; Write-Host ("  TL;DR bullet count {0}: {1}" -f $chapter.File, $liCount) }
  }
  $toc = [regex]::Match($text, '<nav\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\btoc\b[^"'']*["''])[^>]*>[\s\S]*?</nav>')
  if (-not $toc.Success -or $toc.Value -notmatch 'href\s*=\s*["'']#tldr["'']') { $tldrPass = $false; Write-Host ('  TL;DR TOC link missing: ' + $chapter.File) }
}
$tldrPass = $tldrPass -and $tldrPages -eq 11 -and $tldrCount -eq 11
Add-Check 'TL;DR contract' $tldrPass $tldrCount ("chapters={0}, tldr-sections={1}, bullets={2}, each has nav.toc #tldr" -f $tldrPages, $tldrCount, $tldrLiTotal)

$glossaryText = Read-Text (Join-Path $topicRoot 'glossary.html')
$glossaryPass = $null -ne $glossaryText; $glossaryLinkCount = 0; $deadGlossaryTargets = @(); $invalidGlossarySlugs = @(); $glossaryIds = @{}
if ($null -ne $glossaryText) {
  foreach ($idMatch in [regex]::Matches($glossaryText, '<dt\b[^>]*\bid\s*=\s*["'']([^"'']+)["'']')) { $glossaryIds[$idMatch.Groups[1].Value] = $true }
} else { Write-Host '  glossary file missing or unreadable' }
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $glossaryPass = $false; continue }
  foreach ($link in [regex]::Matches($text, 'href\s*=\s*["'']glossary\.html#(g-[^"''#]+)["'']')) {
    $glossaryLinkCount++; $target = $link.Groups[1].Value
    if ($target -notmatch '^g-[a-z0-9]+(?:-[a-z0-9]+)*$') { $invalidGlossarySlugs += $target; $glossaryPass = $false; Write-Host ('  invalid glossary slug ' + $target + ': ' + $chapter.File) }
    if (-not $glossaryIds.ContainsKey($target)) { $deadGlossaryTargets += ($chapter.File + '#' + $target); $glossaryPass = $false; Write-Host ('  dead glossary target ' + $chapter.File + '#' + $target) }
  }
}
$deadGlossaryTargets = @($deadGlossaryTargets | Select-Object -Unique); $invalidGlossarySlugs = @($invalidGlossarySlugs | Select-Object -Unique)
Add-Check 'cross-file glossary anchors' $glossaryPass $glossaryLinkCount ("links={0}, dead={1}, invalid-slugs={2}; targets resolve to glossary dt ids" -f $glossaryLinkCount, $deadGlossaryTargets.Count, $invalidGlossarySlugs.Count)

$recallObjectivePass = $registryLoaded; $chapterRecallObjectiveCount = 0; $recallObjectiveUnknown = @(); $recallObjectiveMissing = @()
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $recallObjectivePass = $false; continue }
  foreach ($item in [regex]::Matches($text, '<[^>]*\bdata-recall\s*=\s*["''][^"'']+["''][^>]*>')) {
    $chapterRecallObjectiveCount++
    $objectiveAttr = [regex]::Match($item.Value, 'data-objective\s*=\s*["'']([^"'']*)["'']')
    if (-not $objectiveAttr.Success -or [string]::IsNullOrWhiteSpace($objectiveAttr.Groups[1].Value)) { $recallObjectiveMissing += $chapter.File; $recallObjectivePass = $false; continue }
    foreach ($raw in ($objectiveAttr.Groups[1].Value -split '\s+')) {
      if (-not $raw) { continue }
      $id = Normalize-ObjectiveId $raw
      if (-not $objectiveExpected.ContainsKey($id)) { $recallObjectiveUnknown += ($chapter.File + ':' + $raw); $recallObjectivePass = $false }
    }
  }
}
$recallObjectiveUnknown = @($recallObjectiveUnknown | Select-Object -Unique); $recallObjectiveMissing = @($recallObjectiveMissing | Select-Object -Unique)
if ($recallObjectiveUnknown.Count) { Write-Host ('  recall objectives absent from registry: ' + ($recallObjectiveUnknown -join ', ')) }
if ($recallObjectiveMissing.Count) { Write-Host ('  recall items missing data-objective: ' + ($recallObjectiveMissing -join ', ')) }
$recallObjectivePass = $recallObjectivePass -and $chapterRecallObjectiveCount -eq 114
Add-Check 'recall objective coverage' $recallObjectivePass $chapterRecallObjectiveCount ("chapter-items={0}, expected=114, unknown-objectives={1}, missing-objective-attrs={2}; review.html rev-* items explicitly exempt" -f $chapterRecallObjectiveCount, $recallObjectiveUnknown.Count, $recallObjectiveMissing.Count)

$stepsPass = $true; $stepListCount = 0; $stepItemCount = 0; $stepOpenCount = 0
$stepPattern = '<ol\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bsteps\b[^"'']*["''])[^>]*>[\s\S]*?</ol>'
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $stepsPass = $false; continue }
  foreach ($list in [regex]::Matches($text, $stepPattern)) {
    $stepListCount++; $items = @([regex]::Matches($list.Value, '<li\b[^>]*>[\s\S]*?</li>')); $stepItemCount += $items.Count
    $listOpenCount = @([regex]::Matches($list.Value, '<details\b[^>]*\bopen(?:\s*=\s*(?:["''][^"'']*["'']|[^\s>]+))?[^>]*>')).Count; $stepOpenCount += $listOpenCount
    if ($items.Count -eq 0) { $stepsPass = $false; Write-Host ('  steps list has no li: ' + $chapter.File) }
    foreach ($item in $items) {
      $details = @([regex]::Matches($item.Value, '<details\b[^>]*>')).Count
      if ($details -ne 1) { $stepsPass = $false; Write-Host ("  steps li details count {0}: {1}" -f $chapter.File, $details) }
    }
    $firstDetails = [regex]::Match($list.Value, '<details\b[^>]*>')
    if ($listOpenCount -ne 1 -or -not $firstDetails.Success -or $firstDetails.Value -notmatch '\bopen(?:\s*=\s*(?:["''][^"'']*["'']|[^\s>]+))?') { $stepsPass = $false; Write-Host ("  steps open contract {0}: open={1}, first-open={2}" -f $chapter.File, $listOpenCount, ($firstDetails.Success -and $firstDetails.Value -match '\bopen(?:\s*=\s*(?:["''][^"'']*["'']|[^\s>]+))?')) }
  }
}
Add-Check 'steps contract' $stepsPass $stepListCount ("lists={0}, items={1}, open-details={2}; every li has one details and first is sole open" -f $stepListCount, $stepItemCount, $stepOpenCount)

$mythPass = $true; $mythTotal = 0; $mythDistribution = @(); $mythPattern = '<(?<tag>div|aside|p)\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcal\b[^"'']*["''])(?=[^>]*\bclass\s*=\s*["''][^"'']*\bmyth\b[^"'']*["''])[^>]*>'
foreach ($chapter in $registryChapters) {
  $text = Read-Text (Join-Path $topicRoot $chapter.File)
  if ($null -eq $text) { $mythPass = $false; continue }
  $chapterMythCount = 0
  foreach ($myth in [regex]::Matches($text, $mythPattern)) {
    $chapterMythCount++; $mythTotal++; $tag = $myth.Groups['tag'].Value; $rest = $text.Substring($myth.Index); $close = [regex]::Match($rest, '</' + $tag + '\s*>')
    if (-not $close.Success -or $rest.Substring(0, $close.Index + $close.Length) -notmatch '<span\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\blbl\b[^"'']*["''])[^>]*>') { $mythPass = $false; Write-Host ('  myth callout missing span.lbl: ' + $chapter.File) }
  }
  if ($chapterMythCount -gt 3) { $mythPass = $false; Write-Host ("  myth callout maximum exceeded {0}: {1}" -f $chapter.File, $chapterMythCount) }
  $mythDistribution += ($chapter.File + '=' + $chapterMythCount)
}
Add-Check 'myth callouts' $mythPass $mythTotal ("per-chapter {0}; each has span.lbl, max=3" -f ($mythDistribution -join ', '))

$briefTerms = @('buildBrief', 'buildDueList', 'copyBrief', 'Copy study brief', 'Copy due-review list')
$briefMissing = @(); if ($null -eq $studyText) { $briefMissing = $briefTerms } else { $briefMissing = @($briefTerms | Where-Object { $studyText -notmatch [regex]::Escape($_) }) }
$briefPass = $briefMissing.Count -eq 0
if ($briefMissing.Count) { Write-Host ('  study brief controls missing: ' + ($briefMissing -join ', ')) }
Add-Check 'study brief contract' $briefPass $briefTerms.Count ("brief builder and copy controls present; missing={0}; module={1}, network={2}, var={3}" -f $briefMissing.Count, $moduleSyntaxCount, $networkCallCount, $varSyntaxCount)

$progressPass = $true; $answerCount = 0; $hiddenAnswerCount = 0; $missingSummaryCount = 0
$studyAddedClasses = @()
if ($null -ne $studyText) { $studyAddedClasses = @([regex]::Matches($studyText, 'study-[a-z-]+') | ForEach-Object { $_.Value } | Select-Object -Unique) }
$hiddenStudyClasses = @()
$cssFiles = if (Test-Path -LiteralPath $assetRoot -PathType Container) { @(Get-ChildItem -LiteralPath $assetRoot -Recurse -Filter '*.css' -File) } else { @() }
foreach ($css in $cssFiles) {
  $cssText = Read-Text $css.FullName
  foreach ($rule in [regex]::Matches($cssText, '([^{}]+)\{([^{}]*)\}')) {
    if ($rule.Groups[2].Value -match '(?i)display\s*:\s*none|visibility\s*:\s*hidden|content-visibility\s*:\s*hidden') {
      foreach ($class in $studyAddedClasses) { if ($rule.Groups[1].Value -match '(?<![\w-])\.' + [regex]::Escape($class) + '(?![\w-])') { $hiddenStudyClasses += $class } }
    }
  }
}
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $progressPass = $false; continue }
  foreach ($item in [regex]::Matches($text, '<details\b([^>]*)>([\s\S]*?)</details>')) {
    if ($item.Groups[1].Value -notmatch 'data-(?:recall|mcq)=') { continue }
    $answerCount++
    if ($item.Groups[2].Value -notmatch '<summary\b') { $missingSummaryCount++; $progressPass = $false; Write-Host ('  answer item lacks summary: ' + $file.FullName) }
    if ($item.Groups[1].Value -match '\bhidden\b' -or $hiddenStudyClasses.Count -gt 0 -and $item.Groups[1].Value -match ('class="[^"]*(' + (($hiddenStudyClasses | ForEach-Object {[regex]::Escape($_)}) -join '|') + ')[^"]*"')) { $hiddenAnswerCount++; $progressPass = $false; Write-Host ('  answer item hidden by static or study-added class: ' + $file.FullName) }
  }
}
$hiddenStudyClasses = @($hiddenStudyClasses | Select-Object -Unique)
$progressPass = $progressPass -and $hiddenAnswerCount -eq 0 -and $missingSummaryCount -eq 0
Add-Check 'progressive enhancement' $progressPass $answerCount ("answer-bearing items={0}, missing-summary={1}, answer-hidden-by-study-css={2}, study-hidden-control-rules={3}; readable with JS off" -f $answerCount, $missingSummaryCount, $hiddenAnswerCount, $hiddenStudyClasses.Count)
if ($hiddenStudyClasses.Count -eq 0) { Add-Skip 'progressive enhancement CSS proof' 1 'no CSS rule hides content using classes added by study.js' }

$modelJsPath = Join-Path $assetRoot 'model.js'
$modelText = Read-Text $modelJsPath
$modelRecords = @()
$modelMarkerCount = 0
$modelContractPass = $registryLoaded
$modelBlockPattern = '<div\b(?=[^>]*\bdata-model\s*=\s*["''][^"'']+["''])[^>]*>(?:(?<modelDepth><div\b[^>]*>)|(?<-modelDepth></div>)|(?!<div\b|</div>)[\s\S])*(?(modelDepth)(?!))</div>'
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $modelContractPass = $false; continue }
  $markers = @([regex]::Matches($text, '\bdata-model\s*=\s*["'']'))
  $modelMarkerCount += $markers.Count
  $blocks = @([regex]::Matches($text, $modelBlockPattern))
  if ($blocks.Count -ne $markers.Count) {
    $modelContractPass = $false
    Write-Host ("  model wrapper parse mismatch {0}: markers={1}, wrappers={2}" -f $file.Name, $markers.Count, $blocks.Count)
  }
  foreach ($blockMatch in $blocks) {
    $block = $blockMatch.Value
    $openEnd = $block.IndexOf('>')
    $openTag = if ($openEnd -ge 0) { $block.Substring(0, $openEnd + 1) } else { '' }
    $idMatch = [regex]::Match($openTag, '\bdata-model\s*=\s*["'']([^"'']+)["'']')
    $id = if ($idMatch.Success) { $idMatch.Groups[1].Value } else { '' }
    $tables = @([regex]::Matches($block, '<table\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bmodel-matrix\b[^"'']*["''])[^>]*>[\s\S]*?</table>'))
    $shapePass = $tables.Count -eq 1
    $outcomes = @()
    $rowCount = 0; $scenarioCount = 0
    if ($tables.Count -eq 1) {
      $table = $tables[0].Value
      $thead = @([regex]::Matches($table, '<thead\b[^>]*>[\s\S]*?</thead>'))
      $headerRows = if ($thead.Count -eq 1) { @([regex]::Matches($thead[0].Value, '<tr\b[^>]*>[\s\S]*?</tr>')) } else { @() }
      $headerCells = if ($headerRows.Count -eq 1) { @([regex]::Matches($headerRows[0].Value, '<th\b[^>]*\bscope\s*=\s*["'']col["''][^>]*>[\s\S]*?</th>')) } else { @() }
      $allHeaderCells = if ($headerRows.Count -eq 1) { @([regex]::Matches($headerRows[0].Value, '<(?:th|td)\b[^>]*>[\s\S]*?</(?:th|td)>')) } else { @() }
      $scenarioCount = $headerCells.Count - 1
      $tbody = @([regex]::Matches($table, '<tbody\b[^>]*>[\s\S]*?</tbody>'))
      $bodyRows = if ($tbody.Count -eq 1) { @([regex]::Matches($tbody[0].Value, '<tr\b[^>]*>[\s\S]*?</tr>')) } else { @() }
      $rowCount = $bodyRows.Count
      if ($thead.Count -ne 1 -or $headerRows.Count -ne 1 -or $headerCells.Count -ne $allHeaderCells.Count -or $scenarioCount -lt 1 -or $tbody.Count -ne 1 -or $rowCount -lt 2) { $shapePass = $false }
      foreach ($rowMatch in $bodyRows) {
        $row = $rowMatch.Value
        $cells = @([regex]::Matches($row, '<(?:th|td)\b[^>]*>[\s\S]*?</(?:th|td)>'))
        $rowHeaders = @([regex]::Matches($row, '<th\b[^>]*\bscope\s*=\s*["'']row["''][^>]*>[\s\S]*?</th>'))
        $outcomeCells = @([regex]::Matches($row, '<td\b[^>]*>[\s\S]*?</td>'))
        if ($cells.Count -ne $headerCells.Count -or $rowHeaders.Count -ne 1 -or $outcomeCells.Count -ne $scenarioCount) { $shapePass = $false }
        foreach ($cell in $outcomeCells) {
          $value = [regex]::Replace($cell.Value, '<[^>]+>', '') -replace '\s+', ' '
          $value = $value.Trim()
          $outcomes += $value
          if ([string]::IsNullOrWhiteSpace($value)) { $shapePass = $false }
        }
      }
    }
    if (-not $shapePass) {
      $modelContractPass = $false
      Write-Host ("  model matrix contract failed: {0} ({1})" -f $file.Name, $(if ($id) { $id } else { 'unknown-id' }))
    }
    $modelRecords += [pscustomobject]@{ Id = $id; Page = $file.Name; Path = $file.FullName; Rows = $rowCount; Cols = $scenarioCount; Outcomes = @($outcomes); ShapePass = $shapePass }
  }
}
$ids = @($modelRecords | ForEach-Object Id)
if ($modelMarkerCount -ne 3 -or $modelRecords.Count -ne 3 -or @($ids | Select-Object -Unique).Count -ne $modelRecords.Count) {
  $modelContractPass = $false
  Write-Host ("  shipped model count/id contract: markers={0}, parsed={1}, unique-ids={2}; expected 3" -f $modelMarkerCount, $modelRecords.Count, @($ids | Select-Object -Unique).Count)
}
Add-Check 'model contract' $modelContractPass $modelRecords.Count 'every data-model wrapper has one rectangular model-matrix with scoped headers and at least 2 rows'

$modelOutcomePass = $modelRecords.Count -eq 3
foreach ($record in $modelRecords) {
  $distinct = @($record.Outcomes | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
  Write-Host ("  model outcomes {0}: [{1}]" -f $record.Id, ($distinct -join ', '))
  if (-not $record.ShapePass -or $record.Outcomes.Count -eq 0 -or $distinct.Count -lt 2 -or $distinct.Count -gt 5 -or @($record.Outcomes | Where-Object { [string]::IsNullOrWhiteSpace($_) }).Count -gt 0) {
    $modelOutcomePass = $false
    Write-Host ("  model outcome vocabulary failed: {0}; distinct={1}, cells={2}" -f $record.Id, $distinct.Count, $record.Outcomes.Count)
  }
}
Add-Check 'model outcome vocabulary' $modelOutcomePass $modelRecords.Count 'each model reports 2-5 distinct non-empty outcomes'

$modelScriptPass = $true; $modelPageCount = 0; $modelScriptRefs = 0
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $modelScriptPass = $false; continue }
  $hasModel = $text -match '\bdata-model\s*='
  $modelRefs = @([regex]::Matches($text, '<script\b[^>]*\bsrc\s*=\s*["''][^"'']*model\.js[^"'']*["''][^>]*>\s*</script>'))
  $exactRefs = @([regex]::Matches($text, '<script\b[^>]*\bsrc\s*=\s*["'']\.\./\.\./assets/model\.js["''][^>]*>\s*</script>'))
  $modelScriptRefs += $modelRefs.Count
  if ($hasModel) {
    $modelPageCount++
    $studyIndex = $text.LastIndexOf('<script src="../../assets/study.js"></script>')
    $modelIndex = $text.LastIndexOf('<script src="../../assets/model.js"></script>')
    $trailing = $text -match '(?s)<script\s+src="\.\./\.\./assets/model\.js"></script>\s*</body>'
    $classic = $modelRefs.Count -gt 0 -and $modelRefs.Value -notmatch '(?i)\btype\s*=\s*["'']module["'']'
    if ($modelRefs.Count -ne 1 -or $exactRefs.Count -ne 1 -or $studyIndex -lt 0 -or $modelIndex -le $studyIndex -or -not $trailing -or -not $classic) {
      $modelScriptPass = $false
      Write-Host ("  model script contract failed: {0}: refs={1}, exact={2}, after-study={3}, trailing={4}, classic={5}" -f $file.Name, $modelRefs.Count, $exactRefs.Count, ($modelIndex -gt $studyIndex), $trailing, $classic)
    }
  } elseif ($modelRefs.Count -ne 0) {
    $modelScriptPass = $false
    Write-Host ('  page without model loads model.js: ' + $file.Name)
  }
}
$modelScriptPass = $modelScriptPass -and $modelPageCount -eq $modelRecords.Count -and $modelPageCount -eq 3
Add-Check 'model script contract' $modelScriptPass $modelScriptRefs 'model pages load one trailing classic model.js after study.js; other pages do not load it'

$modelProgressPass = $null -ne $modelText
$hiddenModelRules = @(); $modelFactStrings = @()
foreach ($record in $modelRecords) { $modelFactStrings += $record.Outcomes }
$modelFactStrings = @($modelFactStrings | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
$progressCss = @()
if (Test-Path -LiteralPath $assetRoot -PathType Container) { $progressCss += @(Get-ChildItem -LiteralPath $assetRoot -Filter '*.css' -File) }
if (Test-Path -LiteralPath $topicRoot -PathType Container) { $progressCss += @(Get-ChildItem -LiteralPath $topicRoot -Filter '*.css' -File) }
foreach ($css in $progressCss) {
  $cssText = Read-Text $css.FullName
  if ($null -eq $cssText) { $modelProgressPass = $false; continue }
  foreach ($rule in [regex]::Matches($cssText, '([^{}]+)\{([^{}]*)\}')) {
    $selector = $rule.Groups[1].Value; $declarations = $rule.Groups[2].Value
    if ($selector -match '(?i)\.model-matrix\b|\[data-model\]' -and $declarations -match '(?i)display\s*:\s*none|visibility\s*:\s*hidden|content-visibility\s*:\s*hidden') {
      $hiddenModelRules += ($css.Name + ': ' + $selector.Trim())
    }
  }
}
if ($hiddenModelRules.Count) { $modelProgressPass = $false; Write-Host ('  model table hidden by CSS: ' + ($hiddenModelRules -join ' | ')) }
if ($null -eq $modelText) { Write-Host '  model.js missing or unreadable' } else {
  foreach ($fact in $modelFactStrings) {
    if ($modelText.IndexOf($fact, [StringComparison]::Ordinal) -ge 0) { $modelProgressPass = $false; Write-Host ('  matrix outcome string found in model.js: ' + $fact) }
  }
}
Add-Check 'model progressive enhancement' $modelProgressPass $progressCss.Count ("model.js has no matrix facts; model tables are not hidden; css-files={0}, hidden-rules={1}, matrix-facts={2}" -f $progressCss.Count, $hiddenModelRules.Count, $modelFactStrings.Count)

$modelEsPass = $false; $modelVarCount = 0; $modelModuleCount = 0; $modelFetchCount = 0
if ($null -ne $modelText) {
  $modelCode = [regex]::Replace($modelText, '(?s)/\*.*?\*/', '')
  $modelCode = [regex]::Replace($modelCode, '(?m)//[^\r\n]*', '')
  $modelModuleCount = @([regex]::Matches($modelCode, '(?m)^\s*(?:import|export)\b')).Count
  $modelFetchCount = @([regex]::Matches($modelCode, '(?m)(?<![\w$])(?:[\w$]+\.)*fetch\s*\(')).Count
  $modelVarCount = @([regex]::Matches($modelCode, '\bvar\b')).Count
  $modelEsPass = $modelModuleCount -eq 0 -and $modelFetchCount -eq 0 -and $modelVarCount -eq 0
  if (-not $modelEsPass) { Write-Host ("  model.js forbidden syntax: module={0}, fetch={1}, var={2}" -f $modelModuleCount, $modelFetchCount, $modelVarCount) }
}
Add-Check 'model.js ES2026 classic discipline' $modelEsPass 1 ("model.js classic/no var/no module/no fetch; module={0}, fetch={1}, var={2}" -f $modelModuleCount, $modelFetchCount, $modelVarCount)

$faviconPass = $htmlFiles.Count -gt 0; $faviconPageCount = 0; $faviconLinks = 0; $descriptionPageCount = 0; $descriptionTags = 0; $descriptionSeen = @{}
foreach ($file in $htmlFiles) {
  $text = Read-Text $file.FullName
  if ($null -eq $text) { $faviconPass = $false; continue }
  $icons = @([regex]::Matches($text, '<link\b(?=[^>]*\brel\s*=\s*["'']icon["''])[^>]*>'))
  $faviconLinks += $icons.Count
  if ($icons.Count -ne 1) { $faviconPass = $false; Write-Host ("  favicon count {0}: {1}" -f $file.Name, $icons.Count) }
  foreach ($icon in $icons) {
    $href = [regex]::Match($icon.Value, '\bhref\s*=\s*["'']([^"'']+)["'']')
    if (-not $href.Success -or -not $href.Groups[1].Value.StartsWith('data:image/svg+xml,', [StringComparison]::Ordinal) -or $href.Groups[1].Value.StartsWith('http', [StringComparison]::OrdinalIgnoreCase)) {
      $faviconPass = $false; Write-Host ('  favicon is not an offline SVG data URI: ' + $file.Name)
    } else { $faviconPageCount++ }
  }
  $descriptions = @([regex]::Matches($text, '<meta\b(?=[^>]*\bname\s*=\s*["'']description["''])[^>]*>'))
  $descriptionTags += $descriptions.Count
  if ($descriptions.Count -ne 1) { $faviconPass = $false; Write-Host ("  description count {0}: {1}" -f $file.Name, $descriptions.Count) }
  foreach ($description in $descriptions) {
    $content = [regex]::Match($description.Value, '\bcontent\s*=\s*["'']([^"'']*)["'']')
    if (-not $content.Success -or [string]::IsNullOrWhiteSpace($content.Groups[1].Value)) { $faviconPass = $false; Write-Host ('  empty description: ' + $file.Name); continue }
    $descriptionPageCount++
    $value = $content.Groups[1].Value
    if ($descriptionSeen.ContainsKey($value)) { $faviconPass = $false; Write-Host ("  duplicate description: {0} and {1}" -f $descriptionSeen[$value], $file.Name) } else { $descriptionSeen[$value] = $file.Name }
  }
}
$faviconPass = $faviconPass -and $faviconPageCount -eq $htmlFiles.Count -and $descriptionPageCount -eq $htmlFiles.Count -and $descriptionSeen.Count -eq $htmlFiles.Count
Add-Check 'favicon and description contract' $faviconPass $htmlFiles.Count ("pages={0}, favicon-pages={1}, icon-links={2}, descriptions={3}, unique-descriptions={4}; offline SVG data URIs" -f $htmlFiles.Count, $faviconPageCount, $faviconLinks, $descriptionTags, $descriptionSeen.Count)


$esPass = $true; $jsCount = 0; $varCount = 0; $moduleCount = 0
$jsFiles = if (Test-Path -LiteralPath $assetRoot -PathType Container) { @(Get-ChildItem -LiteralPath $assetRoot -Filter '*.js' -File) } else { @() }
foreach ($js in $jsFiles) {
  $jsCount++; $text = Read-Text $js.FullName
  if ($null -eq $text) { $esPass = $false; continue }
  $v = @([regex]::Matches($text, '\bvar\b')).Count; $m = @([regex]::Matches($text, '(?i)type\s*=\s*["'']module["'']')).Count; $varCount += $v; $moduleCount += $m
  if ($v -gt 0) { $esPass = $false; Write-Host ('  var keyword in asset script: ' + $js.Name) }
  if ($m -gt 0) { $esPass = $false; Write-Host ('  module type in asset script: ' + $js.Name) }
}
Add-Check 'ES2026 classic asset scripts' ($esPass -and $jsCount -gt 0) $jsCount ("asset-js={0}, var={1}, module-markers={2}" -f $jsCount, $varCount, $moduleCount)


$breadcrumbPass = $true
$breadcrumbPages = 0
$breadcrumbNavCount = 0
$breadcrumbLiCount = 0
$breadcrumbLeafCount = 0
$breadcrumbAncestorCount = 0
$breadcrumbLabelCount = 0
$breadcrumbSeparatorViolations = 0
$breadcrumbMissing = @()
$breadcrumbPageRecords = @()
if ($null -ne $rootText) {
  $rootCrumbs = @([regex]::Matches($rootText, '<nav\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcrumbs\b[^"'']*["''])(?=[^>]*\baria-label\s*=\s*["'']Breadcrumb["''])[^>]*>[\s\S]*?</nav>'))
  if ($rootCrumbs.Count -ne 0 -or $rootText -notmatch '<div\b[^>]*\bclass\s*=\s*["'']site["''][^>]*>') {
    $breadcrumbPass = $false
    Write-Host '  root launcher must have no breadcrumb and must retain div.site'
  }
} else {
  $breadcrumbPass = $false
  Write-Host '  root launcher missing or unreadable'
}
$breadcrumbPageRecords += [pscustomobject]@{ Path = $hubPath; Type = 'hub'; Depth = 2; Labels = @('Learning System', 'AZ-900'); Hrefs = @('../../index.html') }
$breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topicRoot 'review.html'); Type = 'review'; Depth = 3; Labels = @('Learning System', 'AZ-900', 'Review'); Hrefs = @('../../index.html', 'index.html') }
$breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topicRoot 'glossary.html'); Type = 'glossary'; Depth = 3; Labels = @('Learning System', 'AZ-900', 'Glossary'); Hrefs = @('../../index.html', 'index.html') }
foreach ($chapter in $registryChapters) {
  $breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topicRoot $chapter.File); Type = 'chapter'; Depth = 3; Labels = @('Learning System', 'AZ-900', $chapter.ShortTitle); Hrefs = @('../../index.html', 'index.html'); ShortTitle = $chapter.ShortTitle }
}
$expectedBreadcrumbPaths = @{}
foreach ($record in $breadcrumbPageRecords) { try { $expectedBreadcrumbPaths[[IO.Path]::GetFullPath($record.Path)] = $true } catch { $breadcrumbPass = $false } }
foreach ($file in @($htmlFiles | Where-Object { [IO.Path]::GetFullPath($_.FullName) -ne [IO.Path]::GetFullPath($rootIndex) })) {
  try { $actualPath = [IO.Path]::GetFullPath($file.FullName) } catch { $actualPath = $null }
  if ($null -eq $actualPath -or -not $expectedBreadcrumbPaths.ContainsKey($actualPath)) {
    $breadcrumbPass = $false
    Write-Host ('  HTML page missing from breadcrumb contract: ' + $file.FullName)
  }
}
if ($htmlFiles.Count -ne ($breadcrumbPageRecords.Count + 1)) {
  $breadcrumbPass = $false
  Write-Host ("  HTML page count mismatch: discovered={0}, expected topic plus root={1}" -f $htmlFiles.Count, ($breadcrumbPageRecords.Count + 1))
}
foreach ($record in $breadcrumbPageRecords) {
  $breadcrumbPages++
  $pageText = Read-Text $record.Path
  if ($null -eq $pageText) {
    $breadcrumbPass = $false
    $breadcrumbMissing += (Split-Path -Leaf $record.Path)
    Write-Host ('  breadcrumb page missing or unreadable: ' + $record.Path)
    continue
  }
  $navs = @([regex]::Matches($pageText, '<nav\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcrumbs\b[^"'']*["''])(?=[^>]*\baria-label\s*=\s*["'']Breadcrumb["''])[^>]*>([\s\S]*?)</nav>'))
  $breadcrumbNavCount += $navs.Count
  if ($navs.Count -ne 1) {
    $breadcrumbPass = $false
    Write-Host ("  {0} breadcrumb nav count={1}; expected=1" -f (Split-Path -Leaf $record.Path), $navs.Count)
    continue
  }
  $navText = $navs[0].Groups[1].Value
  $ols = @([regex]::Matches($navText, '<ol\b[^>]*>[\s\S]*?</ol>'))
  $lis = @([regex]::Matches($navText, '<li\b[^>]*>[\s\S]*?</li>'))
  $breadcrumbLiCount += $lis.Count
  if ($ols.Count -ne 1 -or $lis.Count -ne $record.Depth) {
    $breadcrumbPass = $false
    Write-Host ("  {0} breadcrumb shape: ol={1}, li={2}; expected ol=1, li={3}" -f (Split-Path -Leaf $record.Path), $ols.Count, $lis.Count, $record.Depth)
  }
  $plainNavText = [regex]::Replace($navText, '<[^>]*>', '')
  if ($plainNavText -match '&rsaquo;|&gt;|&raquo;|[/>]') {
    $breadcrumbPass = $false; $breadcrumbSeparatorViolations++
    Write-Host ('  typed breadcrumb separator found: ' + (Split-Path -Leaf $record.Path))
  }
  if ($lis.Count -ne $record.Depth) { continue }
  for ($i = 0; $i -lt $lis.Count; $i++) {
    $li = $lis[$i].Value
    $isLast = $i -eq ($lis.Count - 1)
    $anchors = @([regex]::Matches($li, '<a\b[^>]*\bhref\s*=\s*["'']([^"'']+)["''][^>]*>[\s\S]*?</a>'))
    if (-not $isLast) {
      if ($anchors.Count -ne 1) { $breadcrumbPass = $false; Write-Host ("  ancestor li lacks exactly one anchor: {0} li={1}" -f (Split-Path -Leaf $record.Path), ($i + 1)); continue }
      $breadcrumbAncestorCount++
      $href = $anchors[0].Groups[1].Value
      if ($i -ge $record.Hrefs.Count -or $href -ne $record.Hrefs[$i]) {
        $breadcrumbPass = $false
        $expectedHref = if ($i -lt $record.Hrefs.Count) { $record.Hrefs[$i] } else { 'none' }
        Write-Host ("  breadcrumb ancestor href mismatch {0} li={1}: actual={2}, expected={3}" -f (Split-Path -Leaf $record.Path), ($i + 1), $href, $expectedHref)
      }
      $targetHref = ($href -split '#', 2)[0]
      if ([string]::IsNullOrWhiteSpace($targetHref)) { $breadcrumbPass = $false; Write-Host ('  empty breadcrumb ancestor href: ' + (Split-Path -Leaf $record.Path)); continue }
      try { $targetPath = [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $record.Path) ($targetHref -replace '/', '\'))) } catch { $targetPath = $null }
      if ($null -eq $targetPath -or -not (Test-Path -LiteralPath $targetPath -PathType Leaf)) {
        $breadcrumbPass = $false; Write-Host ("  breadcrumb ancestor target missing {0}: {1}" -f (Split-Path -Leaf $record.Path), $href)
      } elseif ([IO.Path]::GetFullPath($targetPath) -eq [IO.Path]::GetFullPath($record.Path)) {
        $breadcrumbPass = $false; Write-Host ('  breadcrumb ancestor links to current page: ' + (Split-Path -Leaf $record.Path))
      }
    } elseif ($anchors.Count -gt 0) {
      $breadcrumbPass = $false
      Write-Host ('  breadcrumb leaf must not be an anchor: ' + (Split-Path -Leaf $record.Path))
    }
  }
  $current = @([regex]::Matches($lis[$lis.Count - 1].Value, '<(?!a\b)[A-Za-z][^>]*\baria-current\s*=\s*["'']page["''][^>]*>'))
  $currentAnchors = @([regex]::Matches($lis[$lis.Count - 1].Value, '<a\b[^>]*\baria-current\s*=\s*["'']page["'']'))
  if ($current.Count -ne 1 -or $currentAnchors.Count -ne 0) {
    $breadcrumbPass = $false
    Write-Host ("  breadcrumb leaf current marker invalid: {0} non-anchor={1}, anchor={2}" -f (Split-Path -Leaf $record.Path), $current.Count, $currentAnchors.Count)
  } else { $breadcrumbLeafCount++ }
  foreach ($a in [regex]::Matches($navText, '<a\b[^>]*\bhref\s*=\s*["'']([^"'']+)["'']')) {
    $targetHref = ($a.Groups[1].Value -split '#', 2)[0]
    try { $targetPath = [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $record.Path) ($targetHref -replace '/', '\'))) } catch { $targetPath = $null }
    if ($null -ne $targetPath -and [IO.Path]::GetFullPath($targetPath) -eq [IO.Path]::GetFullPath($record.Path)) {
      $breadcrumbPass = $false
      Write-Host ('  breadcrumb contains self-link: ' + (Split-Path -Leaf $record.Path))
    }
  }
  $leafText = [regex]::Replace($lis[$lis.Count - 1].Value, '<[^>]*>', '')
  $leafText = [Net.WebUtility]::HtmlDecode($leafText).Trim()
  if ($record.Type -eq 'chapter') {
    $breadcrumbLabelCount++
    if ($leafText -ne $record.ShortTitle) {
      $breadcrumbPass = $false
      Write-Host ("  breadcrumb shortTitle mismatch {0}: actual='{1}', expected='{2}'" -f (Split-Path -Leaf $record.Path), $leafText, $record.ShortTitle)
    }
  } elseif ($leafText -ne $record.Labels[$record.Labels.Count - 1]) {
    $breadcrumbPass = $false
    Write-Host ("  breadcrumb leaf label mismatch {0}: actual='{1}', expected='{2}'" -f (Split-Path -Leaf $record.Path), $leafText, $record.Labels[$record.Labels.Count - 1])
  }
}
$themeText = Read-Text (Join-Path $assetRoot 'theme.css')
$cssSeparatorPass = $null -ne $themeText -and $themeText -match '(?m)^\s*\.crumbs\s+li\s*\+\s*li::before\s*\{'
$printCssText = if ($null -ne $themeText -and $themeText.IndexOf('@media print', [StringComparison]::Ordinal) -ge 0) { $themeText.Substring($themeText.IndexOf('@media print', [StringComparison]::Ordinal)) } else { '' }
$cssPrintPass = $printCssText -match '(?s)\.crumbs\b[^{}]*\{[^{}]*display\s*:\s*none'
if (-not $cssSeparatorPass) { $breadcrumbPass = $false; Write-Host '  theme.css missing .crumbs li + li::before separator rule' }
if (-not $cssPrintPass) { $breadcrumbPass = $false; Write-Host '  theme.css print block does not hide .crumbs' }
$breadcrumbPass = $breadcrumbPass -and $breadcrumbPages -eq 14 -and $breadcrumbNavCount -eq 14 -and $breadcrumbLiCount -eq 41 -and $breadcrumbLeafCount -eq 14 -and $breadcrumbLabelCount -eq 11 -and $breadcrumbMissing.Count -eq 0 -and $breadcrumbSeparatorViolations -eq 0
Add-Check 'breadcrumb contract' $breadcrumbPass $breadcrumbPages ("pages={0}, navs={1}, li={2}, leaves={3}, ancestors={4}, shortTitle-labels={5}, missing={6}, typed-separators={7}, css-separator={8}, print-hide={9}; root has none" -f $breadcrumbPages, $breadcrumbNavCount, $breadcrumbLiCount, $breadcrumbLeafCount, $breadcrumbAncestorCount, $breadcrumbLabelCount, $breadcrumbMissing.Count, $breadcrumbSeparatorViolations, $cssSeparatorPass, $cssPrintPass)

Write-Host ''
if ($failures -eq 0) { Write-Host ("PASS: {0} checks, 0 failures." -f $checks); exit 0 }
Write-Host ("FAIL: {0} checks, {1} failures." -f $checks, $failures)
exit 1
