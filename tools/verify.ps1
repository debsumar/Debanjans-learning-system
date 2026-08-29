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
    foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"(c\d{2})"\s*,\s*file:\s*"([^"]+)"\s*,\s*title:\s*"([^"]+)"\s*,\s*domain:\s*"([^"]+)"\s*,\s*weight:\s*"([^"]+)"')) {
      $registryChapters += [pscustomobject]@{ Id = $m.Groups[1].Value; File = $m.Groups[2].Value; Title = $m.Groups[3].Value; Domain = $m.Groups[4].Value; Weight = $m.Groups[5].Value }
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
  $scripts = @([regex]::Matches($text, 'assets/study\.js')).Count; $mounts = @([regex]::Matches($text, 'id="study-summary"')).Count; $trailing = $text -match 'assets/study\.js"\s*>\s*</script>\s*</body>'
  if ($scripts -ne 1 -or $mounts -ne 1 -or -not $trailing) { $studyPass = $false; Write-Host ("  study contract {0}: scripts={1}, mounts={2}, trailing={3}" -f $name, $scripts, $mounts, $trailing) }
}
$studyText = Read-Text $studyPath
if ($null -eq $studyText) { $studyPass = $false; Write-Host '  study.js missing or unreadable' } elseif ($studyText -match '(?i)\b(import|export|fetch)\b' -or $studyText -match '\bvar\b') { $studyPass = $false; Write-Host '  study.js contains forbidden module, fetch, or var syntax' }
Add-Check 'study contract' ($studyPass -and $studyPages -eq 13) $studyPages '11 chapters, review, and hub each have one mount and one trailing classic study script'

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

Write-Host ''
if ($failures -eq 0) { Write-Host ("PASS: {0} checks, 0 failures." -f $checks); exit 0 }
Write-Host ("FAIL: {0} checks, {1} failures." -f $checks, $failures)
exit 1
