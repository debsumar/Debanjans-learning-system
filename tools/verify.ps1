$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$assetRoot = Join-Path $root 'assets'
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
function Get-BalancedBlock {
  param([string]$Text, [int]$StartIndex)
  $depth = 1
  $index = $StartIndex
  $quote = [char]0
  while ($index -lt $Text.Length) {
    $character = $Text[$index]
    if ($quote -ne [char]0) {
      if ($character -eq [char]92) { $index += 2; continue }
      if ($character -eq $quote) { $quote = [char]0 }
      $index++
      continue
    }
    if ($character -eq [char]34 -or $character -eq [char]39) {
      $quote = $character
      $index++
      continue
    }
    if ($character -eq [char]47 -and $index + 1 -lt $Text.Length -and $Text[$index + 1] -eq [char]42) {
      $index += 2
      while ($index + 1 -lt $Text.Length -and -not ($Text[$index] -eq [char]42 -and $Text[$index + 1] -eq [char]47)) { $index++ }
      if ($index + 1 -ge $Text.Length) { return $null }
      $index += 2
      continue
    }
    if ($character -eq [char]47 -and $index + 1 -lt $Text.Length -and $Text[$index + 1] -eq [char]47) {
      $index += 2
      while ($index -lt $Text.Length -and $Text[$index] -ne [char]10 -and $Text[$index] -ne [char]13) { $index++ }
      continue
    }
    if ($character -eq [char]123) { $depth++ }
    if ($character -eq [char]125) {
      $depth--
      if ($depth -eq 0) { return $Text.Substring($StartIndex, $index - $StartIndex) }
    }
    $index++
  }
  return $null
}
function Get-TopicRegistryRecords {
  param([string]$Text, [string]$Root)
  $records = @()
  $script:topicRegistrySlugs = @()
  $script:registryParserDiagnostics = @()
  $rootMatch = [regex]::Match($Text, 'globalThis\.LEARNING_SYSTEM\s*=\s*\{')
  if (-not $rootMatch.Success) { return $records }
  $rootBody = Get-BalancedBlock $Text ($rootMatch.Index + $rootMatch.Length)
  if ($null -eq $rootBody) { return $records }
  $topicRegistriesBody = $null
  $topicRegistriesMatch = [regex]::Match($rootBody, 'topicRegistries\s*:\s*\{')
  $rootRegistryText = $rootBody
  if ($topicRegistriesMatch.Success) {
    $topicRegistriesOpen = $topicRegistriesMatch.Index + $topicRegistriesMatch.Value.LastIndexOf('{')
    $topicRegistriesBody = Get-BalancedBlock $rootBody ($topicRegistriesOpen + 1)
    if ($null -ne $topicRegistriesBody) {
      $topicRegistriesClose = $topicRegistriesOpen + $topicRegistriesBody.Length + 2
      $rootRegistryText = $rootBody.Remove($topicRegistriesMatch.Index, $topicRegistriesClose - $topicRegistriesMatch.Index)
      $firstRegistryEntry = [regex]::Match($topicRegistriesBody, '(?m)^(\s+)(?:"([^"]+)"|([A-Za-z][\w-]*))\s*:\s*\{')
      if ($firstRegistryEntry.Success) {
        $registryEntryIndent = $firstRegistryEntry.Groups[1].Value -replace '[\r\n]', ''
        $registryEntryPattern = '(?m)^' + [regex]::Escape($registryEntryIndent) + '(?:"([^"]+)"|([A-Za-z][\w-]*))\s*:\s*\{'
        foreach ($entry in [regex]::Matches($topicRegistriesBody, $registryEntryPattern)) {
          $script:topicRegistrySlugs += $(if ($entry.Groups[1].Success) { $entry.Groups[1].Value } else { $entry.Groups[2].Value })
        }
      }
    }
  }
  $rootTopicsMatch = [regex]::Match($rootRegistryText, 'topics\s*:\s*\[([\s\S]*?)\]')
  $topicEntries = if ($rootTopicsMatch.Success) { @([regex]::Matches($rootTopicsMatch.Groups[1].Value, 'slug:\s*"([^"]+)"\s*,\s*hubPath:\s*"([^"]+)"')) } else { @() }
  $rootSlug = 'az-900'
  $rootTopicEntries = @($topicEntries | Where-Object { $_.Groups[1].Value -eq $rootSlug })
  if ($rootTopicEntries.Count -ne 1) {
    $script:registryParserDiagnostics += ('explicit root topic slug "' + $rootSlug + '" must resolve exactly once in topics[]; found=' + $rootTopicEntries.Count)
    $rootSlug = ''
  }
  foreach ($topicMatch in $topicEntries) {
    $slug = $topicMatch.Groups[1].Value
    $hubPath = $topicMatch.Groups[2].Value
    $registryText = ''
    $nestedMatch = $null
    if ($null -ne $topicRegistriesBody) {
      $nestedMatch = [regex]::Match($topicRegistriesBody, '(?m)^\s*(?:"' + [regex]::Escape($slug) + '"|' + [regex]::Escape($slug) + ')\s*:\s*\{')
    }
    if ($null -ne $nestedMatch -and $nestedMatch.Success) {
      $registryText = Get-BalancedBlock $topicRegistriesBody ($nestedMatch.Index + $nestedMatch.Length)
    } elseif ($slug.ToLowerInvariant() -eq $rootSlug) {
      $registryText = $rootRegistryText
    }
    if ($null -eq $registryText) { $registryText = '' }
    $chapters = @()
    foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"(c\d{2})"\s*,\s*file:\s*"([^"]+)"\s*,\s*title:\s*"([^"]+)"\s*,\s*shortTitle:\s*"([^"]+)"\s*,\s*domain:\s*"([^"]+)"\s*,\s*weight:\s*"([^"]+)"\s*,\s*objectiveIds:\s*\[([^\]]*)\]\s*,\s*sectionIds:\s*\[([^\]]*)\][\s\S]*?\bmcqCount:\s*(\d+)\s*,\s*recallCount:\s*(\d+)')) {
      $objectiveIds = @([regex]::Matches($m.Groups[7].Value, '"([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
      $sectionIds = @([regex]::Matches($m.Groups[8].Value, '"([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
      $chapters += [pscustomobject]@{ Id = $m.Groups[1].Value; File = $m.Groups[2].Value; Title = $m.Groups[3].Value; ShortTitle = $m.Groups[4].Value; Domain = $m.Groups[5].Value; Weight = $m.Groups[6].Value; ObjectiveIds = $objectiveIds; SectionIds = $sectionIds; McqCount = [int]$m.Groups[9].Value; RecallCount = [int]$m.Groups[10].Value }
    }
    $objectives = @()
    foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"([^"]+)"\s*,\s*text:\s*"([^"]+)"\s*,\s*domain:\s*"([^"]+)"\s*,\s*chapter:\s*"(c\d{2})"\s*,\s*confusionSets:\s*\[([^\]]*)\]')) {
      $objectiveConfusionSetIds = @([regex]::Matches($m.Groups[5].Value, '"([^"]+)"') | ForEach-Object { $_.Groups[1].Value })
      $objectives += [pscustomobject]@{ Id = $m.Groups[1].Value; Text = $m.Groups[2].Value; Domain = $m.Groups[3].Value; Chapter = $m.Groups[4].Value; ConfusionSetIds = $objectiveConfusionSetIds }
    }
    $confusionSets = @()
    foreach ($m in [regex]::Matches($registryText, '\{\s*id:\s*"([^"]+)"\s*,\s*discriminator:\s*"([^"]+)"\s*,\s*objectiveIds:\s*\[[^\]]*\]\s*,\s*calloutChapter:\s*"([^"]+)"\s*,\s*hubLinkTarget:\s*"([^"]+)"\s*\}')) {
      $confusionSets += [pscustomobject]@{ Id = $m.Groups[1].Value; Discriminator = $m.Groups[2].Value; CalloutChapter = $m.Groups[3].Value; HubLinkTarget = $m.Groups[4].Value }
    }
    $diagramArchetypes = @()
    $diagramCatalogueMatch = [regex]::Match($registryText, 'diagramCatalogue\s*:\s*\{')
    if ($diagramCatalogueMatch.Success) {
      $diagramCatalogueText = Get-BalancedBlock $registryText ($diagramCatalogueMatch.Index + $diagramCatalogueMatch.Length)
      $archetypesMatch = if ($null -eq $diagramCatalogueText) { $null } else { [regex]::Match($diagramCatalogueText, 'archetypes\s*:\s*\{') }
      if ($null -ne $archetypesMatch -and $archetypesMatch.Success) {
        $archetypesText = Get-BalancedBlock $diagramCatalogueText ($archetypesMatch.Index + $archetypesMatch.Length)
        if ($null -ne $archetypesText) {
          foreach ($m in [regex]::Matches($archetypesText, '(?:"([^"]+)"|(\w+))\s*:\s*\{\s*count:\s*(\d+)')) {
            $name = if ($m.Groups[1].Success) { $m.Groups[1].Value } else { $m.Groups[2].Value }
            $diagramArchetypes += [pscustomobject]@{ Name = $name; Count = [int]$m.Groups[3].Value }
          }
        }
      }
    }
    $diagramUses = @()
    foreach ($m in [regex]::Matches($registryText, 'chapter:\s*"(c\d{2})"\s*,\s*section:\s*"([^"]+)"\s*,\s*label:\s*"([^"]+)"')) {
      $diagramUses += [pscustomobject]@{ Chapter = $m.Groups[1].Value; Section = $m.Groups[2].Value; Label = $m.Groups[3].Value }
    }
    $questionCounts = [pscustomobject]@{ McqTotal = 0; RecallTotal = 0; ReviewRecallTotal = 0; PerChapter = @() }
    $questionSchemaMatch = [regex]::Match($registryText, 'questionSchema\s*:\s*\{')
    if ($questionSchemaMatch.Success) {
      $questionSchemaText = Get-BalancedBlock $registryText ($questionSchemaMatch.Index + $questionSchemaMatch.Length)
      $countsMatch = if ($null -eq $questionSchemaText) { $null } else { [regex]::Match($questionSchemaText, 'counts\s*:\s*\{') }
      if ($null -ne $countsMatch -and $countsMatch.Success) {
        $countsText = Get-BalancedBlock $questionSchemaText ($countsMatch.Index + $countsMatch.Length)
        if ($null -ne $countsText) {
          $mcqMatch = [regex]::Match($countsText, 'mcqTotal:\s*(\d+)')
          $recallMatch = [regex]::Match($countsText, 'recallTotal:\s*(\d+)')
          $reviewMatch = [regex]::Match($countsText, 'reviewRecallTotal:\s*(\d+)')
          if ($mcqMatch.Success) { $questionCounts.McqTotal = [int]$mcqMatch.Groups[1].Value }
          if ($recallMatch.Success) { $questionCounts.RecallTotal = [int]$recallMatch.Groups[1].Value }
          if ($reviewMatch.Success) { $questionCounts.ReviewRecallTotal = [int]$reviewMatch.Groups[1].Value }
          foreach ($m in [regex]::Matches($countsText, '\b(c\d{2}):\s*\{\s*mcq:\s*(\d+)\s*,\s*recall:\s*(\d+)\s*\}')) {
            $questionCounts.PerChapter += [pscustomobject]@{ Id = $m.Groups[1].Value; Mcq = [int]$m.Groups[2].Value; Recall = [int]$m.Groups[3].Value }
          }
        }
      }
    }
    $componentCatalogue = ''
    $componentMatch = [regex]::Match($registryText, 'componentCatalogue\s*:\s*\{')
    if ($componentMatch.Success) { $componentCatalogue = Get-BalancedBlock $registryText ($componentMatch.Index + $componentMatch.Length) }
    if ($null -eq $componentCatalogue) { $componentCatalogue = '' }
    $shippedModels = @()
    $modelComponentMatch = [regex]::Match($componentCatalogue, '(?m)^\s*model\s*:\s*\{')
    $modelComponentBlock = if ($modelComponentMatch.Success) { Get-BalancedBlock $componentCatalogue ($modelComponentMatch.Index + $modelComponentMatch.Value.LastIndexOf('{') + 1) } else { $null }
    $shippedMatch = if ($null -eq $modelComponentBlock) { $null } else { [regex]::Match($modelComponentBlock, 'shipped\s*:\s*\[') }
    if ($null -ne $shippedMatch -and $shippedMatch.Success) {
      foreach ($m in [regex]::Matches($modelComponentBlock.Substring($shippedMatch.Index), '\{\s*dataModel:\s*"([^"]+)"\s*,\s*chapter:\s*"([^"]+)"\s*,\s*page:\s*"([^"]+)"\s*,\s*rows:\s*(\d+)\s*,\s*cols:\s*(\d+)\s*\}')) {
        $shippedModels += [pscustomobject]@{ Id = $m.Groups[1].Value; Chapter = $m.Groups[2].Value; Page = $m.Groups[3].Value; Rows = [int]$m.Groups[4].Value; Columns = [int]$m.Groups[5].Value }
      }
    }
    $records += [pscustomobject]@{ Slug = $slug; HubPath = $hubPath; TopicRoot = Join-Path (Join-Path $Root 'topics') $slug; RegistryText = $registryText; Chapters = $chapters; Objectives = $objectives; ConfusionSets = $confusionSets; DiagramArchetypes = $diagramArchetypes; DiagramUses = $diagramUses; ShippedModels = $shippedModels; QuestionCounts = $questionCounts; ComponentCatalogue = $componentCatalogue }
  }
  return $records
}

$registryText = Read-Text $registryPath
$registryLoaded = $null -ne $registryText
if (-not $registryLoaded) {
  Add-Check 'registry file' $false 0 'assets/registry.js is missing or unreadable'
}
$topics = @()
$script:registryParserDiagnostics = @()
if ($registryLoaded) {
  try { $topics = @(Get-TopicRegistryRecords $registryText $root) } catch { $script:registryParserDiagnostics += ('topic registry parser error: ' + $_.Exception.Message) }
}
if ($script:registryParserDiagnostics.Count) { Write-Host ('  registry parser diagnostic: ' + ($script:registryParserDiagnostics -join '; ')) }
$metadataPass = $registryLoaded -and $script:registryParserDiagnostics.Count -eq 0 -and $topics.Count -gt 0 -and @($topics | Where-Object { $_.Chapters.Count -eq 0 }).Count -eq 0
$topicSlugs = @($topics | ForEach-Object { $_.Slug })
$orphanTopicRegistries = @($script:topicRegistrySlugs | Where-Object { $_ -notin $topicSlugs })
$topicRegistryMapPass = $registryLoaded -and $orphanTopicRegistries.Count -eq 0
if ($orphanTopicRegistries.Count) { Write-Host ('  topic registries absent from topics[]: ' + ($orphanTopicRegistries -join ', ')) }
Add-Check 'registry metadata extraction' $metadataPass $topics.Count ("topics={0}, empty-topic-registries={1}" -f $topics.Count, @($topics | Where-Object { $_.Chapters.Count -eq 0 }).Count)
Add-Check 'registry topic registry map' $topicRegistryMapPass $script:topicRegistrySlugs.Count ("topic-registries={0}, orphan-registries={1}" -f $script:topicRegistrySlugs.Count, $orphanTopicRegistries.Count)
foreach ($topic in $topics) {
  Add-Check ($topic.Slug + ': registry metadata extraction') ($registryLoaded -and $topic.Chapters.Count -gt 0) $topic.Chapters.Count ("topics={0}, chapters={1}" -f $topics.Count, $topic.Chapters.Count)
}

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

foreach ($topic in $topics) {
  $chapterDisk = @()
  if (Test-Path -LiteralPath $topic.TopicRoot -PathType Container) {
    $chapterDisk = @(Get-ChildItem -LiteralPath $topic.TopicRoot -Filter '*.html' -File | Where-Object { $_.Name -notin @('index.html', 'review.html', 'glossary.html') })
  }
  $missingRegistryChapters = @($topic.Chapters | Where-Object { -not (Test-Path -LiteralPath (Join-Path $topic.TopicRoot $_.File) -PathType Leaf) })
  $listedDiskKeys = @($topic.Chapters | ForEach-Object { $_.File })
  $unlistedDisk = @($chapterDisk | Where-Object { $listedDiskKeys -notcontains $_.Name })
  Add-Check ($topic.Slug + ': registry chapters exist') ($topic.Chapters.Count -gt 0 -and $missingRegistryChapters.Count -eq 0) $topic.Chapters.Count $(if ($missingRegistryChapters.Count) { 'missing: ' + (($missingRegistryChapters | ForEach-Object File) -join ', ') } else { 'all registry files exist' })
  Add-Check ($topic.Slug + ': disk chapters listed') ($topic.Chapters.Count -gt 0 -and $unlistedDisk.Count -eq 0 -and $chapterDisk.Count -eq $topic.Chapters.Count) $chapterDisk.Count $(if ($unlistedDisk.Count) { 'unlisted: ' + (($unlistedDisk | ForEach-Object Name) -join ', ') } else { 'all chapter HTML files listed' })
}

$rootIndex = Join-Path $root 'index.html'
$rootText = Read-Text $rootIndex

foreach ($topic in $topics) {
  $chainPass = $true
  $chainCount = 0
  for ($i = 0; $i -lt $topic.Chapters.Count; $i++) {
    $chapterPath = Join-Path $topic.TopicRoot $topic.Chapters[$i].File
    $chapterText = Read-Text $chapterPath
    if ($null -eq $chapterText) { $chainPass = $false; continue }
    $chainCount++
    $prev = [regex]::Match($chapterText, 'href="([^"]+)">&larr; Prev').Groups[1].Value
    $next = [regex]::Match($chapterText, 'href="([^"]+)">Next &rarr;').Groups[1].Value
    $expectedPrev = if ($i -eq 0) { 'index.html' } else { $topic.Chapters[$i - 1].File }
    $expectedNext = if ($i -eq $topic.Chapters.Count - 1) { 'index.html' } else { $topic.Chapters[$i + 1].File }
    if ($prev -ne $expectedPrev -or $next -ne $expectedNext) {
      $chainPass = $false
      Write-Host ("  chain mismatch {0}: Prev={1}, Next={2}; expected Prev={3}, Next={4}" -f $topic.Chapters[$i].File, $prev, $next, $expectedPrev, $expectedNext)
    }
  }
  Add-Check ($topic.Slug + ': prev/next chain') ($topic.Chapters.Count -gt 0 -and $chainPass -and $chainCount -eq $topic.Chapters.Count) $chainCount 'chain matches registry order; endpoints link to hub'
}

$publishedTopics = @($topics | Where-Object { Test-Path -LiteralPath (Join-Path $root ($_.HubPath -replace '/', '\')) -PathType Leaf })
$launcherPass = $null -ne $rootText
$expectedLauncherHrefs = @($publishedTopics | ForEach-Object { $_.HubPath })
$launcherHrefPattern = if ($expectedLauncherHrefs.Count -gt 0) { 'href="(' + (($expectedLauncherHrefs | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')"' } else { '(?!)' }
$launcherMatches = @()
$launcherCandidateMatches = @()
if ($null -ne $rootText) {
  $launcherMatches = @([regex]::Matches($rootText, $launcherHrefPattern))
  $launcherCandidateMatches = @([regex]::Matches($rootText, 'href="(topics/[^"/]+/[^"]+\.html)"'))
}
foreach ($m in $launcherCandidateMatches) {
  $target = Join-Path $root ($m.Groups[1].Value -replace '/', '\')
  if (-not (Test-Path -LiteralPath $target -PathType Leaf)) { $launcherPass = $false; Write-Host ('  missing launcher card target: ' + $m.Groups[1].Value) }
}
if ($launcherCandidateMatches.Count -ne $launcherMatches.Count) { $launcherPass = $false; Write-Host ('  unregistered launcher card href: ' + (($launcherCandidateMatches | ForEach-Object { $_.Groups[1].Value }) -join ', ')) }
foreach ($topic in $publishedTopics) {
  if ($null -eq $rootText -or $rootText -notmatch ('href="' + [regex]::Escape($topic.HubPath) + '"')) { $launcherPass = $false; Write-Host ('  missing launcher card: ' + $topic.Slug) }
}
$actualLauncherHrefs = @($launcherMatches | ForEach-Object { $_.Groups[1].Value })
if (($actualLauncherHrefs -join '|') -ne ($expectedLauncherHrefs -join '|')) { $launcherPass = $false; Write-Host ('  launcher href mismatch: actual=' + ($actualLauncherHrefs -join ', ') + '; expected=' + ($expectedLauncherHrefs -join ', ')) }
Add-Check 'launcher topic cards' ($publishedTopics.Count -gt 0 -and $launcherPass -and $launcherMatches.Count -eq $publishedTopics.Count) $launcherMatches.Count ("cards={0}, published-topics={1}, exact href order" -f $launcherMatches.Count, $publishedTopics.Count)

foreach ($topic in $topics) {
  $topicHubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  $topicHubText = Read-Text $topicHubPath
  $hubPass = $null -ne $topicHubText
  $hubCardMatches = @()
  if ($null -ne $topicHubText) { $hubCardMatches = @([regex]::Matches($topicHubText, '<article\s+class="card">\s*<a\s+href="([^"]+\.html)"')) }
  foreach ($m in $hubCardMatches) {
    if (-not (Test-Path -LiteralPath (Join-Path $topic.TopicRoot $m.Groups[1].Value) -PathType Leaf)) { $hubPass = $false; Write-Host ('  missing hub card target: ' + $m.Groups[1].Value) }
  }
  $expectedHubHrefs = @($topic.Chapters | ForEach-Object File)
  $actualHubHrefs = @($hubCardMatches | ForEach-Object { $_.Groups[1].Value })
  if (($actualHubHrefs -join '|') -ne ($expectedHubHrefs -join '|')) { $hubPass = $false; Write-Host ('  hub href mismatch: actual=' + ($actualHubHrefs -join ', ') + '; expected=' + ($expectedHubHrefs -join ', ')) }
  Add-Check ($topic.Slug + ': hub chapter cards') ($topic.Chapters.Count -gt 0 -and $hubPass -and $hubCardMatches.Count -eq $topic.Chapters.Count) $hubCardMatches.Count ("found={0}, registry={1}, exact href order" -f $hubCardMatches.Count, $topic.Chapters.Count)
}

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

foreach ($topic in $topics) {
  $objectiveExpected = @{}
  foreach ($objective in $topic.Objectives) { $objectiveExpected[(Normalize-ObjectiveId $objective.Id)] = $objective.Chapter }
  $objectiveSeen = @{}; $objectiveUnknown = @(); $objectivePass = $objectiveExpected.Count -eq $topic.Objectives.Count
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $objectivePass = $false; continue }
    foreach ($m in [regex]::Matches($text, 'data-objective="([^"]+)"')) {
      foreach ($raw in ($m.Groups[1].Value -split '\s+')) {
        if (-not $raw) { continue }
        $id = Normalize-ObjectiveId $raw
        if ($objectiveExpected.ContainsKey($id)) { $objectiveSeen[$id] = $true } else { $objectiveUnknown += $raw }
      }
    }
    foreach ($m in [regex]::Matches($text, '<section\b[^>]*\bid="skills"[\s\S]*?</section>')) {
      foreach ($idMatch in [regex]::Matches($m.Value, '<li\b[^>]*\bid="([^"]+)"')) {
        $raw = $idMatch.Groups[1].Value; $id = Normalize-ObjectiveId $raw
        if ($objectiveExpected.ContainsKey($id)) { $objectiveSeen[$id] = $true } else { $objectiveUnknown += $raw }
      }
    }
  }
  $objectiveOrphans = @($objectiveExpected.Keys | Where-Object { -not $objectiveSeen.ContainsKey($_) })
  $objectiveUnknown = @($objectiveUnknown | Select-Object -Unique)
  if ($objectiveOrphans.Count) { Write-Host ('  objectives with no page reference: ' + ($objectiveOrphans -join ', ')) }
  if ($objectiveUnknown.Count) { Write-Host ('  HTML objective values absent from registry: ' + ($objectiveUnknown -join ', ')) }
  $objectivePass = $objectivePass -and $objectiveOrphans.Count -eq 0 -and $objectiveUnknown.Count -eq 0
  Add-Check ($topic.Slug + ': objective coverage') ($topic.Chapters.Count -gt 0 -and $objectivePass) $objectiveExpected.Count ("registry={0}, referenced={1}, orphan-registry={2}, orphan-html={3}; expected objectives={0}, MCQs={4}" -f $objectiveExpected.Count, $objectiveSeen.Count, $objectiveOrphans.Count, $objectiveUnknown.Count, $topic.QuestionCounts.McqTotal)
}

foreach ($topic in $topics) {
  $topicObjectiveExpected = @{}
  foreach ($objective in $topic.Objectives) { $topicObjectiveExpected[(Normalize-ObjectiveId $objective.Id)] = $objective.Chapter }
  $skillsPass = $topicObjectiveExpected.Count -eq $topic.Objectives.Count; $skillsCount = 0
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $skillsPass = $false; continue }
    $sm = [regex]::Match($text, '<section\b[^>]*\bid="skills"[\s\S]*?</section>')
    if (-not $sm.Success) { $skillsPass = $false; Write-Host ('  missing #skills section: ' + $chapter.File); continue }
    $found = @{}
    foreach ($li in [regex]::Matches($sm.Value, '<li\b([^>]*)>')) {
      $idMatch = [regex]::Match($li.Groups[1].Value, '\bid="([^"]+)"')
      $skillsCount++
      if (-not $idMatch.Success) { $skillsPass = $false; Write-Host ('  invalid skills bullet id in ' + $chapter.File); continue }
      $id = Normalize-ObjectiveId $idMatch.Groups[1].Value
      if (-not $topicObjectiveExpected.ContainsKey($id)) { $skillsPass = $false; Write-Host ('  invalid skills bullet id in ' + $chapter.File); continue }
      $found[$id] = $true
    }
    $expected = @($topicObjectiveExpected.Keys | Where-Object { $topicObjectiveExpected[$_] -eq $chapter.Id })
    foreach ($id in $expected) { if (-not $found.ContainsKey($id)) { $skillsPass = $false; Write-Host ('  missing skills bullet ' + $id + ': ' + $chapter.File) } }
    foreach ($id in $found.Keys) { if ($topicObjectiveExpected[$id] -ne $chapter.Id) { $skillsPass = $false; Write-Host ('  skills bullet not in registry/chapter: ' + $id) } }
  }
  Add-Check ($topic.Slug + ': skills-bullet ids') ($topic.Chapters.Count -gt 0 -and $skillsPass -and $skillsCount -eq $topic.Objectives.Count) $skillsCount ("every #skills li has registry objective id; expected {0}" -f $topic.Objectives.Count)
}

$idSeen = @{}
foreach ($topic in $topics) {
  $idPass = $true; $recallTotal = 0; $mcqTotal = 0; $chapterPracticeRecall = 0; $chapterPracticeMcq = 0
  $topicIdSeen = @{}
  $topicHubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  $topicStudyPaths = @($topic.Chapters | ForEach-Object { Join-Path $topic.TopicRoot $_.File }) + @($topicHubPath, (Join-Path $topic.TopicRoot 'review.html'), (Join-Path $topic.TopicRoot 'glossary.html'))
  foreach ($path in $topicStudyPaths) {
    $text = Read-Text $path
    if ($null -eq $text) { $idPass = $false; continue }
    foreach ($m in [regex]::Matches($text, 'data-(recall|mcq)="([^"]+)"')) {
      $kind = $m.Groups[1].Value; $id = $m.Groups[2].Value; $key = $topic.Slug + ':' + $id
      if ($idSeen.ContainsKey($key)) { $idPass = $false; Write-Host ('  duplicate study id ' + $id + ': ' + $path) } else { $idSeen[$key] = $path; $topicIdSeen[$id] = $path }
      if ($kind -eq 'recall') {
        $recallTotal++
        if ($id -notmatch '^(c\d{2}-r\d{2}|rev-[ds]\d{2})$') { $idPass = $false; Write-Host ('  invalid recall id: ' + $id) }
      } else {
        $mcqTotal++
        if ($id -notmatch '^c\d{2}-q\d{2}$') { $idPass = $false; Write-Host ('  invalid MCQ id: ' + $id) }
      }
    }
  }
  $declaredChapterMcq = 0; $declaredChapterRecall = 0
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $idPass = $false; continue }
    $mcqCount = @([regex]::Matches($text, 'data-mcq="c\d{2}-q\d{2}"')).Count
    $recallCount = @([regex]::Matches($text, 'data-recall="c\d{2}-r\d{2}"')).Count
    $chapterPracticeMcq += $mcqCount; $chapterPracticeRecall += $recallCount
    $declaredChapterMcq += $chapter.McqCount; $declaredChapterRecall += $chapter.RecallCount
    $schemaChapter = @($topic.QuestionCounts.PerChapter | Where-Object { $_.Id -eq $chapter.Id })
    if ($schemaChapter.Count -ne 1 -or $schemaChapter[0].Mcq -ne $chapter.McqCount -or $schemaChapter[0].Recall -ne $chapter.RecallCount) { $idPass = $false; Write-Host ('  registry chapter question count mismatch: ' + $chapter.Id) }
    if ($mcqCount -ne $chapter.McqCount -or $recallCount -ne $chapter.RecallCount) { $idPass = $false; Write-Host ("  count mismatch {0}: MCQ={1}/{2}, recall={3}/{4}" -f $chapter.File, $mcqCount, $chapter.McqCount, $recallCount, $chapter.RecallCount) }
  }
  $reviewText = Read-Text (Join-Path $topic.TopicRoot 'review.html')
  $reviewRecall = if ($null -eq $reviewText) { 0 } else { @([regex]::Matches($reviewText, 'data-recall="rev-[ds]\d{2}"')).Count }
  if ($declaredChapterMcq -ne $topic.QuestionCounts.McqTotal -or $declaredChapterRecall -ne $topic.QuestionCounts.RecallTotal) { $idPass = $false; Write-Host ("  declared question totals mismatch: MCQ={0}/{1}, recall={2}/{3}" -f $declaredChapterMcq, $topic.QuestionCounts.McqTotal, $declaredChapterRecall, $topic.QuestionCounts.RecallTotal) }
  $idPass = $idPass -and $mcqTotal -eq $topic.QuestionCounts.McqTotal -and $chapterPracticeMcq -eq $topic.QuestionCounts.McqTotal -and $chapterPracticeRecall -eq $topic.QuestionCounts.RecallTotal -and $reviewRecall -eq $topic.QuestionCounts.ReviewRecallTotal -and $recallTotal -eq ($topic.QuestionCounts.RecallTotal + $topic.QuestionCounts.ReviewRecallTotal)
  Add-Check ($topic.Slug + ': recall and MCQ integrity') ($topic.Chapters.Count -gt 0 -and $idPass) ($recallTotal + $mcqTotal) ("recall={0}, chapter-recall={1}, review-recall={2}, mcq={3}, unique={4}; expected MCQs={5}, chapter-recall={6}, review-recall={7}" -f $recallTotal, $chapterPracticeRecall, $reviewRecall, $mcqTotal, $topicIdSeen.Count, $topic.QuestionCounts.McqTotal, $topic.QuestionCounts.RecallTotal, $topic.QuestionCounts.ReviewRecallTotal)
}

foreach ($topic in $topics) {
  $topicHubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  $hubText = Read-Text $topicHubPath
  $confusionPass = $registryLoaded -and $null -ne $hubText; $confusionCount = 0
  foreach ($set in $topic.ConfusionSets) {
    $confusionCount++; $id = $set.Id; $actualChapter = $set.CalloutChapter; $hubTarget = $set.HubLinkTarget
    $chapterRecord = @($topic.Chapters | Where-Object Id -eq $actualChapter)
    if ($chapterRecord.Count -ne 1) { $confusionPass = $false; Write-Host ('  confusion chapter absent from registry: ' + $id + ' -> ' + $actualChapter); continue }
    $targetFile = $chapterRecord[0].File
    $targetParts = $hubTarget -split '#', 2
    if ($targetParts[0] -ne $targetFile) { $confusionPass = $false; Write-Host ("  confusion target mismatch {0}: hub={1}, chapter={2}" -f $id, $hubTarget, $targetFile) }
    $targetPath = Join-Path $topic.TopicRoot $targetFile; $targetText = Read-Text $targetPath
    if ($null -eq $targetText) { $confusionPass = $false; Write-Host ('  confusion file missing: ' + $targetFile); continue }
    $fragment = if ($targetParts.Count -gt 1) { $targetParts[1] } else { '' }
    $sectionMatch = if ([string]::IsNullOrWhiteSpace($fragment)) { $null } else { [regex]::Match($targetText, '<section\b[^>]*\bid="' + [regex]::Escape($fragment) + '"[\s\S]*?</section>') }
    if ($null -eq $sectionMatch -or -not $sectionMatch.Success) { $confusionPass = $false; Write-Host ('  confusion target section missing: ' + $id + ' -> ' + $targetFile + '#' + $fragment); continue }
    $calloutScope = $sectionMatch.Value
    if ($calloutScope -notmatch 'class="[^"]*\bcal\b[^"]*\bconfuse\b[^"]*"') { $confusionPass = $false; Write-Host ('matching confuse callout missing in section: ' + $id + ' -> ' + $targetFile + '#' + $fragment) }
    foreach ($term in ($id -split '-')) {
      if ($calloutScope -notmatch ('(?i)\b' + [regex]::Escape($term) + '\b')) { $confusionPass = $false; Write-Host ('  chapter callout does not mention confusion term ' + $term + ': ' + $id) }
    }
    $exactHubLinks = if ($null -eq $hubText) { @() } else { @([regex]::Matches($hubText, 'href="' + [regex]::Escape($hubTarget) + '"')) }
    $hubChapterLinks = if ($null -eq $hubText) { @() } else { @([regex]::Matches($hubText, 'href="' + [regex]::Escape($targetFile) + '#[^"]+"')) }
    if ($exactHubLinks.Count -ne 1 -and $hubChapterLinks.Count -ne 1) { $confusionPass = $false; Write-Host ('  hub link target missing, duplicated, or points at wrong chapter: ' + $targetFile) }
  }
  $confusionExpected = @{}
  foreach ($objective in $topic.Objectives) {
    foreach ($confusionSetId in $objective.ConfusionSetIds) { $confusionExpected[$confusionSetId] = $true }
  }
  $confusionActual = @{}
  foreach ($set in $topic.ConfusionSets) { $confusionActual[$set.Id] = $true }
  $missingConfusionSets = @($confusionExpected.Keys | Where-Object { -not $confusionActual.ContainsKey($_) })
  $unknownConfusionSets = @($confusionActual.Keys | Where-Object { -not $confusionExpected.ContainsKey($_) })
  if ($missingConfusionSets.Count -or $unknownConfusionSets.Count) {
    $confusionPass = $false
    Write-Host ("  registry confusion set ids: missing={0}; unknown={1}" -f ($missingConfusionSets -join ', '), ($unknownConfusionSets -join ', '))
  }
  Add-Check ($topic.Slug + ': confusion set integrity') ($topic.Chapters.Count -gt 0 -and $confusionPass -and $confusionCount -eq $confusionExpected.Count) $confusionCount 'registry sets resolve to objective references and real callouts; hub targets equal callout chapters'
}

foreach ($topic in $topics) {
  $geometryPass = $registryLoaded; $svgCount = 0; $rectCount = 0; $geometrySkips = 0
  $archetypeCount = $topic.DiagramArchetypes.Count
  $ruleCount = @([regex]::Matches($topic.RegistryText, 'geometryRules:\s*\[')).Count
  $requiredRuleCount = @([regex]::Matches($topic.RegistryText, 'nothing sits outside the viewBox|no stroke sits exactly on the viewBox edge|centred labels use text-anchor=middle')).Count
  if ($ruleCount -ne $archetypeCount -or $requiredRuleCount -lt ($archetypeCount * 3)) { $geometryPass = $false; Write-Host ("  registry geometry rules incomplete: archetypes={0}, geometry-rules={1}, required-rule mentions={2}" -f $archetypeCount, $ruleCount, $requiredRuleCount) }
  $expectedDiagramUses = 0
  foreach ($archetype in $topic.DiagramArchetypes) { $expectedDiagramUses += $archetype.Count }
  $diagramUses = @($topic.DiagramUses)
  foreach ($use in $diagramUses) {
    $chapterRecord = @($topic.Chapters | Where-Object Id -eq $use.Chapter)
    if ($chapterRecord.Count -ne 1) { $geometryPass = $false; continue }
    $chapterText = Read-Text (Join-Path $topic.TopicRoot $chapterRecord[0].File)
    if ($null -eq $chapterText) { $geometryPass = $false; Write-Host ('  diagram chapter missing: ' + $chapterRecord[0].File); continue }
    $sectionMatch = [regex]::Match($chapterText, '<section\b[^>]*\bid="' + [regex]::Escape($use.Section) + '"[\s\S]*?</section>')
    if (-not $sectionMatch.Success) { $geometryPass = $false; Write-Host ('  diagram section missing: ' + $use.Chapter + '#' + $use.Section); continue }
    $svgMatch = [regex]::Match($sectionMatch.Value, '<svg\b[^>]*role="img"[^>]*aria-label="' + [regex]::Escape($use.Label) + '"[\s\S]*?</svg>')
    if (-not $svgMatch.Success) { $geometryPass = $false; Write-Host ('  diagram missing registry use: ' + $use.Chapter + '#' + $use.Section); continue }
    $svgCount++; $svgAttrs = [regex]::Match($svgMatch.Value, '^<svg\b([^>]*)>').Groups[1].Value; $svgBody = [regex]::Match($svgMatch.Value, '^<svg\b[^>]*>([\s\S]*)</svg>$').Groups[1].Value
    $vm = [regex]::Match($svgAttrs, 'viewBox="\s*([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)\s+([-\d.]+)"')
    if (-not $vm.Success) { $geometryPass = $false; Write-Host ('  diagram missing numeric viewBox: ' + $use.Label); continue }
    $vx = Number-Value $vm.Groups[1].Value; $vy = Number-Value $vm.Groups[2].Value; $vw = Number-Value $vm.Groups[3].Value; $vh = Number-Value $vm.Groups[4].Value
    $boxes = @()
    foreach ($rm in [regex]::Matches($svgBody, '<rect\b([^>]*)/?>')) {
      $a = $rm.Groups[1].Value; $xM=[regex]::Match($a, '\bx="([-\d.]+)"'); $yM=[regex]::Match($a, '\by="([-\d.]+)"'); $wM=[regex]::Match($a, '\bwidth="([-\d.]+)"'); $hM=[regex]::Match($a, '\bheight="([-\d.]+)"')
      if (-not ($xM.Success -and $yM.Success -and $wM.Success -and $hM.Success)) { $geometrySkips++; continue }
      $x=Number-Value $xM.Groups[1].Value; $y=Number-Value $yM.Groups[1].Value; $w=Number-Value $wM.Groups[1].Value; $h=Number-Value $hM.Groups[1].Value; $rectCount++; $boxes += ,@($x,$y,$w,$h)
      if ($x -lt $vx -or $y -lt $vy -or $x+$w -gt $vx+$vw -or $y+$h -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG rect outside viewBox: ' + $use.Label) }
      if ($x -eq $vx -or $y -eq $vy -or $x+$w -eq $vx+$vw -or $y+$h -eq $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG rect stroke on viewBox edge: ' + $use.Label) }
    }
    foreach ($cm in [regex]::Matches($svgBody, '<circle\b([^>]*)/?>')) {
      $a=$cm.Groups[1].Value; $cxM=[regex]::Match($a, '\bcx="([-\d.]+)"'); $cyM=[regex]::Match($a, '\bcy="([-\d.]+)"'); $rM=[regex]::Match($a, '\br="([-\d.]+)"')
      if ($cxM.Success -and $cyM.Success -and $rM.Success) { $cx=Number-Value $cxM.Groups[1].Value; $cy=Number-Value $cyM.Groups[1].Value; $r=Number-Value $rM.Groups[1].Value; if ($cx-$r -lt $vx -or $cy-$r -lt $vy -or $cx+$r -gt $vx+$vw -or $cy+$r -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG circle outside viewBox: ' + $use.Label) } } else { $geometrySkips++ }
    }
    foreach ($em in [regex]::Matches($svgBody, '<ellipse\b([^>]*)/?>')) {
      $a=$em.Groups[1].Value; $cxM=[regex]::Match($a, '\bcx="([-\d.]+)"'); $cyM=[regex]::Match($a, '\bcy="([-\d.]+)"'); $rxM=[regex]::Match($a, '\brx="([-\d.]+)"'); $ryM=[regex]::Match($a, '\bry="([-\d.]+)"')
      if ($cxM.Success -and $cyM.Success -and $rxM.Success -and $ryM.Success) { $cx=[double](Number-Value $cxM.Groups[1].Value); $cy=[double](Number-Value $cyM.Groups[1].Value); $rx=[double](Number-Value $rxM.Groups[1].Value); $ry=[double](Number-Value $ryM.Groups[1].Value); $bx=$cx-$rx; $by=$cy-$ry; $bw=2*$rx; $bh=2*$ry; $boxes += ,@($bx,$by,$bw,$bh); if ($bx -lt $vx -or $by -lt $vy -or $bx+$bw -gt $vx+$vw -or $by+$bh -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG ellipse outside viewBox: ' + $use.Label) } } else { $geometrySkips++ }
    }
    foreach ($lm in [regex]::Matches($svgBody, '<line\b([^>]*)/?>')) {
      $a=$lm.Groups[1].Value; $values=@(); foreach($n in @('x1','y1','x2','y2')) { $nm=[regex]::Match($a, '\b'+$n+'="([-\d.]+)"'); if($nm.Success){$values += Number-Value $nm.Groups[1].Value} }; if($values.Count -eq 4){if(($values[0] -lt $vx) -or ($values[2] -lt $vx) -or ($values[0] -gt $vx+$vw) -or ($values[2] -gt $vx+$vw) -or ($values[1] -lt $vy) -or ($values[3] -lt $vy) -or ($values[1] -gt $vy+$vh) -or ($values[3] -gt $vy+$vh)){ $geometryPass=$false; Write-Host ('  SVG line outside viewBox: ' + $use.Label)}} else {$geometrySkips++}
    }
    foreach ($tm in [regex]::Matches($svgBody, '<text\b([^>]*)>')) {
      $a=$tm.Groups[1].Value; $txM=[regex]::Match($a, '\bx="([-\d.]+)"'); $tyM=[regex]::Match($a, '\by="([-\d.]+)"'); if(-not($txM.Success -and $tyM.Success)){ $geometrySkips++; continue }; $tx=Number-Value $txM.Groups[1].Value; $ty=Number-Value $tyM.Groups[1].Value
      if ($tx -lt $vx -or $tx -gt $vx+$vw -or $ty -lt $vy -or $ty -gt $vy+$vh) { $geometryPass=$false; Write-Host ('  SVG text outside viewBox: ' + $use.Label) }
      foreach($box in $boxes){$centerX=$box[0]+$box[2]/2; if([math]::Abs($tx-$centerX) -lt 0.001 -and $ty -ge $box[1] -and $ty -le $box[1]+$box[3] -and $a -notmatch 'text-anchor="middle"'){ $geometryPass=$false; Write-Host ('  SVG centered text lacks text-anchor=middle: ' + $use.Label) }}
    }
    if ($svgBody -match '<path\b|<polyline\b|<polygon\b') { $geometrySkips++ }
  }
  if ($diagramUses.Count -ne $expectedDiagramUses -or $svgCount -ne $expectedDiagramUses) { $geometryPass = $false; Write-Host ("  diagram catalogue/use count mismatch: registry={0}, uses={1}, matched SVGs={2}" -f $expectedDiagramUses, $diagramUses.Count, $svgCount) }
  Add-Check ($topic.Slug + ': SVG geometry bounds and labels') ($topic.Chapters.Count -gt 0 -and $geometryPass) $svgCount ("checked diagrams={0}, rects={1}, registry geometry rules={2}" -f $svgCount, $rectCount, $ruleCount)
  if ($geometrySkips -gt 0) { Add-Skip ($topic.Slug + ': SVG unsupported geometry') $geometrySkips 'path curves, transforms, markers, and text glyph extents are not statically checkable with regex' }
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
foreach ($topic in $topics) {
  $studyPass = $true; $studyPages = 0
  $topicHubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  $studyPagePaths = @($topic.Chapters | ForEach-Object { Join-Path $topic.TopicRoot $_.File }) + @($topicHubPath, (Join-Path $topic.TopicRoot 'review.html'))
  foreach ($path in $studyPagePaths) {
    $text = Read-Text $path
    $name = Split-Path -Leaf $path
    if ($null -eq $text) { $studyPass = $false; Write-Host ('  study page missing: ' + $path); continue }
    $studyPages++
    $scripts = @([regex]::Matches($text, 'assets/study\.js')).Count; $mounts = @([regex]::Matches($text, 'id="study-summary"')).Count; $trailing = $text -match 'assets/study\.js"\s*>\s*</script>\s*(?:<script\s+src="\.\./\.\./assets/model\.js"></script>\s*)?</body>'
    if ($scripts -ne 1 -or $mounts -ne 1 -or -not $trailing) { $studyPass = $false; Write-Host ("  study contract {0}: scripts={1}, mounts={2}, trailing={3}" -f $name, $scripts, $mounts, $trailing) }
  }
  if ($null -eq $studyText) { $studyPass = $false; Write-Host '  study.js missing or unreadable' } elseif (-not $studySyntaxPass) { $studyPass = $false }
  Add-Check ($topic.Slug + ': study contract') ($topic.Chapters.Count -gt 0 -and $studyPass -and $studyPages -eq ($topic.Chapters.Count + 2)) $studyPages ("chapters, review, and hub each have one mount and one trailing classic study script; expected pages={0}; syntax is classic and local-only" -f ($topic.Chapters.Count + 2))
}

$modelRuntimeText = Read-Text (Join-Path $assetRoot 'model.js')
foreach ($topic in $topics) {
  $modelContractPass = $registryLoaded; $modelContractCount = 0; $modelCellCount = 0; $modelFailures = @(); $modelRecords = @()
  $interactiveModelMatch = [regex]::Match($topic.RegistryText, 'interactiveModel\s*:\s*\{')
  $modelBlock = $null
  if ($interactiveModelMatch.Success) { $modelBlock = Get-BalancedBlock $topic.RegistryText ($interactiveModelMatch.Index + $interactiveModelMatch.Value.LastIndexOf('{') + 1) }
  if ($null -eq $modelBlock) {
    if ($topic.ShippedModels.Count -gt 0) { $modelContractPass = $false; $modelFailures += 'interactiveModel block unreadable' }
  } else {
    foreach ($m in [regex]::Matches($modelBlock, '\{\s*id:\s*"([^"]+)"\s*,\s*chapter:\s*"([^"]+)"\s*,\s*section:\s*"([^"]+)"\s*,\s*rowCount:\s*(\d+)\s*,\s*columnCount:\s*(\d+)\s*\}')) {
      $modelRecords += [pscustomobject]@{ Id = $m.Groups[1].Value; Chapter = $m.Groups[2].Value; Section = $m.Groups[3].Value; Rows = [int]$m.Groups[4].Value; Columns = [int]$m.Groups[5].Value }
    }
    if ($modelRecords.Count -ne $topic.ShippedModels.Count) { $modelContractPass = $false; $modelFailures += ('registered models=' + $modelRecords.Count + ', shipped=' + $topic.ShippedModels.Count) }
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
    $chapterRecord = @($topic.Chapters | Where-Object Id -eq $model.Chapter)
    if ($chapterRecord.Count -ne 1) { $modelContractPass = $false; $modelFailures += ($model.Id + ': chapter not in registry'); continue }
    $chapterText = Read-Text (Join-Path $topic.TopicRoot $chapterRecord[0].File)
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
  $shippedModelIds = @($topic.ShippedModels | ForEach-Object Id)
  $registeredModelIds = @($modelRecords | ForEach-Object Id)
  $missingShippedModels = @($shippedModelIds | Where-Object { $_ -notin $registeredModelIds })
  $unknownRegisteredModels = @($registeredModelIds | Where-Object { $_ -notin $shippedModelIds })
  if ($modelRecords.Count -ne $topic.ShippedModels.Count -or $missingShippedModels.Count -ne 0 -or $unknownRegisteredModels.Count -ne 0) {
    $modelContractPass = $false; $modelFailures += ('interactive/shipped mismatch: missing=' + ($missingShippedModels -join ', ') + ', unknown=' + ($unknownRegisteredModels -join ', '))
  }
  foreach ($model in $modelRecords) {
    $shippedModel = @($topic.ShippedModels | Where-Object Id -eq $model.Id)
    $chapterRecord = @($topic.Chapters | Where-Object Id -eq $model.Chapter)
    if ($shippedModel.Count -ne 1 -or $chapterRecord.Count -ne 1 -or $shippedModel[0].Chapter -ne $model.Chapter -or $shippedModel[0].Page -ne $chapterRecord[0].File -or $shippedModel[0].Rows -ne $model.Rows -or $shippedModel[0].Columns -ne $model.Columns) {
      $modelContractPass = $false; $modelFailures += ($model.Id + ': interactive/shipped dimensions or page mismatch')
    }
  }
  if ($modelFailures.Count) { Write-Host ('  interactive model contract: ' + ($modelFailures -join '; ')) }
  Add-Check ($topic.Slug + ': interactive model contract') ($topic.Chapters.Count -gt 0 -and $modelContractPass) $modelContractCount ("registered={0}, shipped={1}, nonempty-static-cells={2}; matrix is sole outcome source" -f $modelContractCount, $topic.ShippedModels.Count, $modelCellCount)
}

foreach ($topic in $topics) {
  $componentNames = @('tldr', 'myth', 'steps', 'glossary-link', 'study-brief', 'model')
  $componentPass = $registryLoaded -and -not [string]::IsNullOrWhiteSpace($topic.ComponentCatalogue); $componentHits = 0; $componentMissing = @()
  foreach ($name in $componentNames) {
    $property = if ($name -match '-') { '"' + [regex]::Escape($name) + '"' } else { '\b' + [regex]::Escape($name) + '\b' }
    $componentMatch = [regex]::Match($topic.ComponentCatalogue, '(?m)^\s*' + $property + '\s*:\s*\{')
    $componentBlock = if ($componentMatch.Success) { Get-BalancedBlock $topic.ComponentCatalogue ($componentMatch.Index + $componentMatch.Value.LastIndexOf('{') + 1) } else { $null }
    if ($null -eq $componentBlock -or $componentBlock -notmatch '\bpurpose\s*:' -or $componentBlock -notmatch '\brequiredMarkup\s*:' -or $componentBlock -notmatch '\binvariants\s*:') {
      $componentPass = $false; $componentMissing += $name
    } else { $componentHits++ }
  }
  if ($topic.ComponentCatalogue -notmatch '\bglossaryAnchorRule\s*:') { $componentPass = $false; $componentMissing += 'glossaryAnchorRule' }
  if ($componentMissing.Count) { Write-Host ('  component catalogue entries missing required contract fields: ' + ($componentMissing -join ', ')) }
  Add-Check ($topic.Slug + ': component catalogue') ($topic.Chapters.Count -gt 0 -and $componentPass -and $componentHits -eq $componentNames.Count) $componentHits ("required-components={0}, contract-complete={1}; glossary anchor rule present" -f $componentNames.Count, $componentHits)
}

foreach ($topic in $topics) {
  $tldrPass = $true; $tldrPages = 0; $tldrCount = 0; $tldrLiTotal = 0
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
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
  $tldrPass = $tldrPass -and $tldrPages -eq $topic.Chapters.Count -and $tldrCount -eq $topic.Chapters.Count
  Add-Check ($topic.Slug + ': TL;DR contract') ($topic.Chapters.Count -gt 0 -and $tldrPass) $tldrCount ("chapters={0}, tldr-sections={1}, bullets={2}, each has nav.toc #tldr" -f $tldrPages, $tldrCount, $tldrLiTotal)
}

foreach ($topic in $topics) {
  $glossaryText = Read-Text (Join-Path $topic.TopicRoot 'glossary.html')
  $glossaryPass = $null -ne $glossaryText; $glossaryLinkCount = 0; $deadGlossaryTargets = @(); $invalidGlossarySlugs = @(); $glossaryIds = @{}
  if ($null -ne $glossaryText) {
    foreach ($idMatch in [regex]::Matches($glossaryText, '<dt\b[^>]*\bid\s*=\s*["'']([^"'']+)["'']')) { $glossaryIds[$idMatch.Groups[1].Value] = $true }
  } else { Write-Host '  glossary file missing or unreadable' }
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $glossaryPass = $false; continue }
    foreach ($link in [regex]::Matches($text, 'href\s*=\s*["'']glossary\.html#(g-[^"''#]+)["'']')) {
      $glossaryLinkCount++; $target = $link.Groups[1].Value
      if ($target -notmatch '^g-[a-z0-9]+(?:-[a-z0-9]+)*$') { $invalidGlossarySlugs += $target; $glossaryPass = $false; Write-Host ('  invalid glossary slug ' + $target + ': ' + $chapter.File) }
      if (-not $glossaryIds.ContainsKey($target)) { $deadGlossaryTargets += ($chapter.File + '#' + $target); $glossaryPass = $false; Write-Host ('  dead glossary target ' + $chapter.File + '#' + $target) }
    }
  }
  $deadGlossaryTargets = @($deadGlossaryTargets | Select-Object -Unique); $invalidGlossarySlugs = @($invalidGlossarySlugs | Select-Object -Unique)
  Add-Check ($topic.Slug + ': cross-file glossary anchors') ($topic.Chapters.Count -gt 0 -and $glossaryPass) $glossaryLinkCount ("links={0}, dead={1}, invalid-slugs={2}; targets resolve to this topic glossary dt ids" -f $glossaryLinkCount, $deadGlossaryTargets.Count, $invalidGlossarySlugs.Count)
}

foreach ($topic in $topics) {
  $topicObjectiveExpected = @{}
  foreach ($objective in $topic.Objectives) { $topicObjectiveExpected[(Normalize-ObjectiveId $objective.Id)] = $true }
  $recallObjectivePass = $registryLoaded; $chapterRecallObjectiveCount = 0; $recallObjectiveUnknown = @(); $recallObjectiveMissing = @()
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $recallObjectivePass = $false; continue }
    foreach ($item in [regex]::Matches($text, '<[^>]*\bdata-recall\s*=\s*["''][^"'']+["''][^>]*>')) {
      $chapterRecallObjectiveCount++
      $objectiveAttr = [regex]::Match($item.Value, 'data-objective\s*=\s*["'']([^"'']*)["'']')
      if (-not $objectiveAttr.Success -or [string]::IsNullOrWhiteSpace($objectiveAttr.Groups[1].Value)) { $recallObjectiveMissing += $chapter.File; $recallObjectivePass = $false; continue }
      foreach ($raw in ($objectiveAttr.Groups[1].Value -split '\s+')) {
        if (-not $raw) { continue }
        $id = Normalize-ObjectiveId $raw
        if (-not $topicObjectiveExpected.ContainsKey($id)) { $recallObjectiveUnknown += ($chapter.File + ':' + $raw); $recallObjectivePass = $false }
      }
    }
  }
  $recallObjectiveUnknown = @($recallObjectiveUnknown | Select-Object -Unique); $recallObjectiveMissing = @($recallObjectiveMissing | Select-Object -Unique)
  if ($recallObjectiveUnknown.Count) { Write-Host ('  recall objectives absent from registry: ' + ($recallObjectiveUnknown -join ', ')) }
  if ($recallObjectiveMissing.Count) { Write-Host ('  recall items missing data-objective: ' + ($recallObjectiveMissing -join ', ')) }
  $recallObjectivePass = $recallObjectivePass -and $chapterRecallObjectiveCount -eq $topic.QuestionCounts.RecallTotal
  Add-Check ($topic.Slug + ': recall objective coverage') ($topic.Chapters.Count -gt 0 -and $recallObjectivePass) $chapterRecallObjectiveCount ("chapter-items={0}, expected={1}, unknown-objectives={2}, missing-objective-attrs={3}; review.html rev-* items explicitly exempt" -f $chapterRecallObjectiveCount, $topic.QuestionCounts.RecallTotal, $recallObjectiveUnknown.Count, $recallObjectiveMissing.Count)
}

$stepPattern = '<ol\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bsteps\b[^"'']*["''])[^>]*>[\s\S]*?</ol>'
foreach ($topic in $topics) {
  $stepsPass = $true; $stepListCount = 0; $stepItemCount = 0; $stepOpenCount = 0
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
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
  Add-Check ($topic.Slug + ': steps contract') ($topic.Chapters.Count -gt 0 -and $stepsPass) $stepListCount ("lists={0}, items={1}, open-details={2}; every li has one details and first is sole open" -f $stepListCount, $stepItemCount, $stepOpenCount)
}

$mythPattern = '<(?<tag>div|aside|p)\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcal\b[^"'']*["''])(?=[^>]*\bclass\s*=\s*["''][^"'']*\bmyth\b[^"'']*["''])[^>]*>'
foreach ($topic in $topics) {
  $mythPass = $true; $mythTotal = 0; $mythDistribution = @()
  foreach ($chapter in $topic.Chapters) {
    $text = Read-Text (Join-Path $topic.TopicRoot $chapter.File)
    if ($null -eq $text) { $mythPass = $false; continue }
    $chapterMythCount = 0
    foreach ($myth in [regex]::Matches($text, $mythPattern)) {
      $chapterMythCount++; $mythTotal++; $tag = $myth.Groups['tag'].Value; $rest = $text.Substring($myth.Index); $close = [regex]::Match($rest, '</' + $tag + '\s*>')
      $calloutText = if ($close.Success) { $rest.Substring(0, $close.Index + $close.Length) } else { '' }
      if (-not $close.Success -or $calloutText -notmatch '<span\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\blbl\b[^"'']*["''])[^>]*>\s*Common wrong turn\s*</span>') { $mythPass = $false; Write-Host ('  myth callout missing exact span.lbl label: ' + $chapter.File) }
    }
    if ($chapterMythCount -gt 3) { $mythPass = $false; Write-Host ("  myth callout maximum exceeded {0}: {1}" -f $chapter.File, $chapterMythCount) }
    $mythDistribution += ($chapter.File + '=' + $chapterMythCount)
  }
  Add-Check ($topic.Slug + ': myth callouts') ($topic.Chapters.Count -gt 0 -and $mythPass) $mythTotal ("per-chapter {0}; each has exact span.lbl Common wrong turn, max=3" -f ($mythDistribution -join ', '))
}

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

foreach ($topic in $topics) {
  $topicCssPath = Join-Path $topic.TopicRoot 'topic.css'
  $topicCssText = Read-Text $topicCssPath
  $topicCssPass = $null -ne $topicCssText; $topicCssRootBlocks = @(); $topicCssUnexpectedTokens = @(); $topicCssOutsideColours = @(); $topicCssMissingAccents = @()
  if ($null -eq $topicCssText) {
    Write-Host ('  topic.css missing or unreadable: ' + $topicCssPath)
  } else {
    $topicCssRootBlocks = @([regex]::Matches($topicCssText, '(?s):root(?:\[data-theme="light"\])?\s*\{.*?\}'))
    $topicCssOutsideText = $topicCssText
    foreach ($rootBlock in $topicCssRootBlocks) { $topicCssOutsideText = $topicCssOutsideText.Replace($rootBlock.Value, '') }
    $topicCssOutsideColours = @([regex]::Matches($topicCssOutsideText, '(?i)#[0-9a-f]{3,8}\b|(?:rgb|hsl)a?\([^)]*\)'))
    foreach ($token in [regex]::Matches($topicCssText, '(?m)--([a-z-]+)\s*:')) {
      if ($token.Groups[1].Value -notin @('accent', 'accent-soft', 'accent-dim')) { $topicCssUnexpectedTokens += $token.Groups[1].Value }
    }
    foreach ($rootBlock in $topicCssRootBlocks) {
      foreach ($requiredAccent in @('accent', 'accent-soft', 'accent-dim')) {
        if (@([regex]::Matches($rootBlock.Value, '(?m)--' + [regex]::Escape($requiredAccent) + '\s*:')).Count -ne 1) { $topicCssMissingAccents += $requiredAccent }
      }
    }
    if ($topicCssRootBlocks.Count -ne 2 -or $topicCssOutsideColours.Count -ne 0 -or $topicCssUnexpectedTokens.Count -ne 0 -or $topicCssMissingAccents.Count -ne 0) { $topicCssPass = $false }
  }
  if ($topicCssUnexpectedTokens.Count) { Write-Host ('  topic.css non-accent token declarations: ' + (($topicCssUnexpectedTokens | Select-Object -Unique) -join ', ')) }
  if ($topicCssMissingAccents.Count) { Write-Host ('  topic.css missing or duplicate accent tokens: ' + (($topicCssMissingAccents | Select-Object -Unique) -join ', ')) }
  if ($topicCssOutsideColours.Count) { Write-Host ('  topic.css colour literals outside :root token blocks: ' + $topicCssOutsideColours.Count) }
  Add-Check ($topic.Slug + ': topic CSS accent tokens') ($topic.Chapters.Count -gt 0 -and $topicCssPass) $topicCssRootBlocks.Count ("root-token-blocks={0}, outside-colours={1}, non-accent-tokens={2}, missing-or-duplicate-accents={3}; topic.css defines accent tokens only" -f $topicCssRootBlocks.Count, $topicCssOutsideColours.Count, @($topicCssUnexpectedTokens | Select-Object -Unique).Count, @($topicCssMissingAccents | Select-Object -Unique).Count)
}

$modelJsPath = Join-Path $assetRoot 'model.js'
$modelText = Read-Text $modelJsPath
$modelBlockPattern = '<div\b(?=[^>]*\bdata-model\s*=\s*["''][^"'']+["''])[^>]*>(?:(?<modelDepth><div\b[^>]*>)|(?<-modelDepth></div>)|(?!<div\b|</div>)[\s\S])*(?(modelDepth)(?!))</div>'
$modelExpectedPaths = @{}
foreach ($topic in $topics) {
  $modelContractPass = $registryLoaded; $modelRecords = @(); $modelMarkerCount = 0
  $topicModelPaths = @($topic.Chapters | ForEach-Object { Join-Path $topic.TopicRoot $_.File }) + @((Join-Path $topic.TopicRoot 'index.html'), (Join-Path $topic.TopicRoot 'review.html'), (Join-Path $topic.TopicRoot 'glossary.html'))
  foreach ($path in $topicModelPaths) {
    try { $modelExpectedPaths[[IO.Path]::GetFullPath($path)] = $true } catch { $modelContractPass = $false }
    $text = Read-Text $path
    if ($null -eq $text) { $modelContractPass = $false; continue }
    $markers = @([regex]::Matches($text, '\bdata-model\s*=\s*["'']'))
    $modelMarkerCount += $markers.Count
    $blocks = @([regex]::Matches($text, $modelBlockPattern))
    if ($blocks.Count -ne $markers.Count) { $modelContractPass = $false; Write-Host ("  model wrapper parse mismatch {0}: markers={1}, wrappers={2}" -f (Split-Path -Leaf $path), $markers.Count, $blocks.Count) }
    foreach ($blockMatch in $blocks) {
      $block = $blockMatch.Value; $openEnd = $block.IndexOf('>'); $openTag = if ($openEnd -ge 0) { $block.Substring(0, $openEnd + 1) } else { '' }
      $idMatch = [regex]::Match($openTag, '\bdata-model\s*=\s*["'']([^"'']+)["'']'); $id = if ($idMatch.Success) { $idMatch.Groups[1].Value } else { '' }
      $tables = @([regex]::Matches($block, '<table\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bmodel-matrix\b[^"'']*["''])[^>]*>[\s\S]*?</table>'))
      $shapePass = $tables.Count -eq 1; $outcomes = @(); $rowCount = 0; $scenarioCount = 0
      if ($tables.Count -eq 1) {
        $table = $tables[0].Value; $thead = @([regex]::Matches($table, '<thead\b[^>]*>[\s\S]*?</thead>')); $headerRows = if ($thead.Count -eq 1) { @([regex]::Matches($thead[0].Value, '<tr\b[^>]*>[\s\S]*?</tr>')) } else { @() }
        $headerCells = if ($headerRows.Count -eq 1) { @([regex]::Matches($headerRows[0].Value, '<th\b[^>]*\bscope\s*=\s*["'']col["''][^>]*>[\s\S]*?</th>')) } else { @() }
        $allHeaderCells = if ($headerRows.Count -eq 1) { @([regex]::Matches($headerRows[0].Value, '<(?:th|td)\b[^>]*>[\s\S]*?</(?:th|td)>')) } else { @() }
        $scenarioCount = $headerCells.Count - 1; $tbody = @([regex]::Matches($table, '<tbody\b[^>]*>[\s\S]*?</tbody>')); $bodyRows = if ($tbody.Count -eq 1) { @([regex]::Matches($tbody[0].Value, '<tr\b[^>]*>[\s\S]*?</tr>')) } else { @() }; $rowCount = $bodyRows.Count
        if ($thead.Count -ne 1 -or $headerRows.Count -ne 1 -or $headerCells.Count -ne $allHeaderCells.Count -or $scenarioCount -lt 1 -or $tbody.Count -ne 1 -or $rowCount -lt 2) { $shapePass = $false }
        foreach ($rowMatch in $bodyRows) {
          $row = $rowMatch.Value; $cells = @([regex]::Matches($row, '<(?:th|td)\b[^>]*>[\s\S]*?</(?:th|td)>')); $rowHeaders = @([regex]::Matches($row, '<th\b[^>]*\bscope\s*=\s*["'']row["''][^>]*>[\s\S]*?</th>')); $outcomeCells = @([regex]::Matches($row, '<td\b[^>]*>[\s\S]*?</td>'))
          if ($cells.Count -ne $headerCells.Count -or $rowHeaders.Count -ne 1 -or $outcomeCells.Count -ne $scenarioCount) { $shapePass = $false }
          foreach ($cell in $outcomeCells) { $value = ([regex]::Replace($cell.Value, '<[^>]+>', '') -replace '\s+', ' ').Trim(); $outcomes += $value; if ([string]::IsNullOrWhiteSpace($value)) { $shapePass = $false } }
        }
      }
      if (-not $shapePass) { $modelContractPass = $false; Write-Host ("  model matrix contract failed: {0} ({1})" -f (Split-Path -Leaf $path), $(if ($id) { $id } else { 'unknown-id' })) }
      $modelRecords += [pscustomobject]@{ Id = $id; Page = (Split-Path -Leaf $path); Path = $path; Rows = $rowCount; Cols = $scenarioCount; Outcomes = @($outcomes); ShapePass = $shapePass }
    }
  }
  $expectedIds = @($topic.ShippedModels | ForEach-Object Id); $actualIds = @($modelRecords | ForEach-Object Id); $unknownIds = @($actualIds | Where-Object { $_ -notin $expectedIds }); $missingIds = @($expectedIds | Where-Object { $_ -notin $actualIds })
  if ($modelMarkerCount -ne $topic.ShippedModels.Count -or $modelRecords.Count -ne $topic.ShippedModels.Count -or @($actualIds | Select-Object -Unique).Count -ne $modelRecords.Count -or $unknownIds.Count -ne 0 -or $missingIds.Count -ne 0) { $modelContractPass = $false; Write-Host ("  shipped model count/id contract: markers={0}, parsed={1}, unique-ids={2}; expected={3}, missing={4}, unknown={5}" -f $modelMarkerCount, $modelRecords.Count, @($actualIds | Select-Object -Unique).Count, $topic.ShippedModels.Count, ($missingIds -join ', '), ($unknownIds -join ', ')) }
  foreach ($record in $modelRecords) {
    $shippedModel = @($topic.ShippedModels | Where-Object Id -eq $record.Id)
    if ($shippedModel.Count -ne 1 -or $record.Page -ne $shippedModel[0].Page -or $record.Rows -ne $shippedModel[0].Rows -or $record.Cols -ne $shippedModel[0].Columns) { $modelContractPass = $false; Write-Host ('  shipped model dimensions or page mismatch: ' + $record.Id) }
  }
  Add-Check ($topic.Slug + ': model contract') ($topic.Chapters.Count -gt 0 -and $modelContractPass) $modelRecords.Count ("registered={0}, markers={1}; every data-model wrapper has one rectangular model-matrix with scoped headers and at least 2 rows" -f $topic.ShippedModels.Count, $modelMarkerCount)

  $modelOutcomePass = $modelRecords.Count -eq $topic.ShippedModels.Count
  foreach ($record in $modelRecords) {
    $distinct = @($record.Outcomes | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
    if (-not $record.ShapePass -or $record.Outcomes.Count -eq 0 -or $distinct.Count -lt 2 -or $distinct.Count -gt 5 -or @($record.Outcomes | Where-Object { [string]::IsNullOrWhiteSpace($_) }).Count -gt 0) { $modelOutcomePass = $false; Write-Host ("  model outcome vocabulary failed: {0}; distinct={1}, cells={2}" -f $record.Id, $distinct.Count, $record.Outcomes.Count) }
  }
  Add-Check ($topic.Slug + ': model outcome vocabulary') ($topic.Chapters.Count -gt 0 -and $modelOutcomePass) $modelRecords.Count 'each model reports 2-5 distinct non-empty outcomes'

  $modelScriptPass = $true; $modelPageCount = 0; $modelScriptRefs = 0
  foreach ($path in $topicModelPaths) {
    $text = Read-Text $path
    if ($null -eq $text) { $modelScriptPass = $false; continue }
    $hasModel = $text -match '\bdata-model\s*='; $modelRefs = @([regex]::Matches($text, '<script\b[^>]*\bsrc\s*=\s*["''][^"'']*model\.js[^"'']*["''][^>]*>\s*</script>')); $exactRefs = @([regex]::Matches($text, '<script\b[^>]*\bsrc\s*=\s*["'']\.\./\.\./assets/model\.js["''][^>]*>\s*</script>')); $modelScriptRefs += $modelRefs.Count
    if ($hasModel) {
      $modelPageCount++; $studyIndex = $text.LastIndexOf('<script src="../../assets/study.js"></script>'); $modelIndex = $text.LastIndexOf('<script src="../../assets/model.js"></script>'); $trailing = $text -match '(?s)<script\s+src="\.\./\.\./assets/model\.js"></script>\s*</body>'; $classic = $modelRefs.Count -gt 0 -and $modelRefs.Value -notmatch '(?i)\btype\s*=\s*["'']module["'']'
      if ($modelRefs.Count -ne 1 -or $exactRefs.Count -ne 1 -or $studyIndex -lt 0 -or $modelIndex -le $studyIndex -or -not $trailing -or -not $classic) { $modelScriptPass = $false; Write-Host ("  model script contract failed: {0}: refs={1}, exact={2}, after-study={3}, trailing={4}, classic={5}" -f (Split-Path -Leaf $path), $modelRefs.Count, $exactRefs.Count, ($modelIndex -gt $studyIndex), $trailing, $classic) }
    } elseif ($modelRefs.Count -ne 0) { $modelScriptPass = $false; Write-Host ('  page without model loads model.js: ' + (Split-Path -Leaf $path)) }
  }
  $registeredModelPages = @($topic.ShippedModels | ForEach-Object { $_.Page } | Select-Object -Unique)
  $modelScriptPass = $modelScriptPass -and $modelPageCount -eq $registeredModelPages.Count
  Add-Check ($topic.Slug + ': model script contract') ($topic.Chapters.Count -gt 0 -and $modelScriptPass) $modelScriptRefs 'model pages load one trailing classic model.js after study.js; other topic pages do not load it'

  $modelProgressPass = $null -ne $modelText; $hiddenModelRules = @(); $modelFactStrings = @(); foreach ($record in $modelRecords) { $modelFactStrings += $record.Outcomes }; $modelFactStrings = @($modelFactStrings | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
  $progressCss = @(); if (Test-Path -LiteralPath $assetRoot -PathType Container) { $progressCss += @(Get-ChildItem -LiteralPath $assetRoot -Filter '*.css' -File) }; $topicCssPath = Join-Path $topic.TopicRoot 'topic.css'; if (Test-Path -LiteralPath $topicCssPath -PathType Leaf) { $progressCss += Get-Item -LiteralPath $topicCssPath }
  foreach ($css in $progressCss) {
    $cssText = Read-Text $css.FullName
    if ($null -eq $cssText) { $modelProgressPass = $false; continue }
    foreach ($rule in [regex]::Matches($cssText, '([^{}]+)\{([^{}]*)\}')) { $selector = $rule.Groups[1].Value; $declarations = $rule.Groups[2].Value; if ($selector -match '(?i)\.model-matrix\b|\[data-model\]' -and $declarations -match '(?i)display\s*:\s*none|visibility\s*:\s*hidden|content-visibility\s*:\s*hidden') { $hiddenModelRules += ($css.Name + ': ' + $selector.Trim()) } }
  }
  if ($hiddenModelRules.Count) { $modelProgressPass = $false; Write-Host ('  model table hidden by CSS: ' + ($hiddenModelRules -join ' | ')) }
  if ($null -eq $modelText) { Write-Host '  model.js missing or unreadable' } else { foreach ($fact in $modelFactStrings) { if ($modelText.IndexOf($fact, [StringComparison]::Ordinal) -ge 0) { $modelProgressPass = $false; Write-Host ('  matrix outcome string found in model.js: ' + $fact) } } }
  Add-Check ($topic.Slug + ': model progressive enhancement') ($topic.Chapters.Count -gt 0 -and $modelProgressPass) $progressCss.Count ("model.js has no matrix facts; model tables are not hidden; css-files={0}, hidden-rules={1}, matrix-facts={2}" -f $progressCss.Count, $hiddenModelRules.Count, $modelFactStrings.Count)
}

$modelPagesOutsideRegistryPass = $true
$modelPagesOutsideRegistryCount = 0
foreach ($file in $htmlFiles) {
  try { $actualPath = [IO.Path]::GetFullPath($file.FullName) } catch { $actualPath = $null }
  if ($null -ne $actualPath -and -not $modelExpectedPaths.ContainsKey($actualPath)) {
    $text = Read-Text $file.FullName
    if ($null -ne $text -and ($text -match '\bdata-model\s*=' -or $text -match '<script\b[^>]*\bsrc\s*=\s*["''][^"'']*model\.js')) {
      $modelPagesOutsideRegistryPass = $false
      $modelPagesOutsideRegistryCount++
      Write-Host ('  unregistered model markup or script: ' + $file.FullName)
    }
  }
}
Add-Check 'model pages outside topic registry' $modelPagesOutsideRegistryPass $modelPagesOutsideRegistryCount 'all model markup and scripts are on registered topic pages'

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
    if (-not $href.Success -or -not $href.Groups[1].Value.StartsWith('data:image/svg+xml,', [StringComparison]::Ordinal)) {
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
  if ($rootCrumbs.Count -ne 0 -or $rootText -notmatch '<div\b[^>]*\bclass\s*=\s*["'']site["''][^>]*>') { $breadcrumbPass = $false; Write-Host '  root launcher must have no breadcrumb and must retain div.site' }
} else { $breadcrumbPass = $false; Write-Host '  root launcher missing or unreadable' }
foreach ($topic in $publishedTopics) {
  $breadcrumbMatch = [regex]::Match($topic.ComponentCatalogue, 'breadcrumb\s*:\s*\{')
  $breadcrumbBlock = if ($breadcrumbMatch.Success) { Get-BalancedBlock $topic.ComponentCatalogue ($breadcrumbMatch.Index + $breadcrumbMatch.Value.LastIndexOf('{') + 1) } else { $null }
  $breadcrumbDepths = @{}; $breadcrumbLabels = @{}; $leafSource = ''
  if ($null -eq $breadcrumbBlock) { $breadcrumbPass = $false; Write-Host ('  breadcrumb component missing or unreadable: ' + $topic.Slug); continue }
  $depthMatch = [regex]::Match($breadcrumbBlock, 'depthByPageType\s*:\s*\{')
  $depthBlock = if ($depthMatch.Success) { Get-BalancedBlock $breadcrumbBlock ($depthMatch.Index + $depthMatch.Value.LastIndexOf('{') + 1) } else { $null }
  $labelMatch = [regex]::Match($breadcrumbBlock, 'labels\s*:\s*\{')
  $labelBlock = if ($labelMatch.Success) { Get-BalancedBlock $breadcrumbBlock ($labelMatch.Index + $labelMatch.Value.LastIndexOf('{') + 1) } else { $null }
  if ($null -ne $depthBlock) { foreach ($m in [regex]::Matches($depthBlock, '(\w+)\s*:\s*(\d+)')) { $breadcrumbDepths[$m.Groups[1].Value] = [int]$m.Groups[2].Value } }
  if ($null -ne $labelBlock) { foreach ($m in [regex]::Matches($labelBlock, '(\w+)\s*:\s*"([^"]+)"')) { $breadcrumbLabels[$m.Groups[1].Value] = $m.Groups[2].Value } }
  $leafSourceMatch = [regex]::Match($breadcrumbBlock, 'leafSource\s*:\s*"([^"]+)"'); if ($leafSourceMatch.Success) { $leafSource = $leafSourceMatch.Groups[1].Value }
  foreach ($key in @('hub', 'chapter', 'review', 'glossary')) { if (-not $breadcrumbDepths.ContainsKey($key)) { $breadcrumbPass = $false; Write-Host ('  breadcrumb depth missing: ' + $topic.Slug + ':' + $key) } }
  foreach ($key in @('root', 'topic', 'review', 'glossary')) { if (-not $breadcrumbLabels.ContainsKey($key)) { $breadcrumbPass = $false; Write-Host ('  breadcrumb label missing: ' + $topic.Slug + ':' + $key) } }
  if ($leafSource -notmatch 'shortTitle') { $breadcrumbPass = $false; Write-Host ('  breadcrumb leafSource does not declare chapter shortTitle: ' + $topic.Slug) }
  if ($breadcrumbDepths.Count -eq 0 -or $breadcrumbLabels.Count -eq 0) { continue }
  $topicHubPath = Join-Path $root ($topic.HubPath -replace '/', '\')
  $breadcrumbPageRecords += [pscustomobject]@{ Path = $topicHubPath; Type = 'hub'; Depth = $breadcrumbDepths['hub']; Labels = @($breadcrumbLabels['root'], $breadcrumbLabels['topic']); Hrefs = @('../../index.html') }
  $breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topic.TopicRoot 'review.html'); Type = 'review'; Depth = $breadcrumbDepths['review']; Labels = @($breadcrumbLabels['root'], $breadcrumbLabels['topic'], $breadcrumbLabels['review']); Hrefs = @('../../index.html', 'index.html') }
  $breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topic.TopicRoot 'glossary.html'); Type = 'glossary'; Depth = $breadcrumbDepths['glossary']; Labels = @($breadcrumbLabels['root'], $breadcrumbLabels['topic'], $breadcrumbLabels['glossary']); Hrefs = @('../../index.html', 'index.html') }
  foreach ($chapter in $topic.Chapters) { $breadcrumbPageRecords += [pscustomobject]@{ Path = (Join-Path $topic.TopicRoot $chapter.File); Type = 'chapter'; Depth = $breadcrumbDepths['chapter']; Labels = @($breadcrumbLabels['root'], $breadcrumbLabels['topic'], $chapter.ShortTitle); Hrefs = @('../../index.html', 'index.html'); ShortTitle = $chapter.ShortTitle } }
}
$expectedBreadcrumbPaths = @{}
foreach ($record in $breadcrumbPageRecords) { try { $expectedBreadcrumbPaths[[IO.Path]::GetFullPath($record.Path)] = $true } catch { $breadcrumbPass = $false } }
foreach ($file in @($htmlFiles | Where-Object { [IO.Path]::GetFullPath($_.FullName) -ne [IO.Path]::GetFullPath($rootIndex) })) {
  try { $actualPath = [IO.Path]::GetFullPath($file.FullName) } catch { $actualPath = $null }
  if ($null -eq $actualPath -or -not $expectedBreadcrumbPaths.ContainsKey($actualPath)) { $breadcrumbPass = $false; Write-Host ('  HTML page missing from breadcrumb contract: ' + $file.FullName) }
}
if ($htmlFiles.Count -ne ($breadcrumbPageRecords.Count + 1)) { $breadcrumbPass = $false; Write-Host ("  HTML page count mismatch: discovered={0}, expected topic union plus root={1}" -f $htmlFiles.Count, ($breadcrumbPageRecords.Count + 1)) }
foreach ($record in $breadcrumbPageRecords) {
  $breadcrumbPages++; $pageText = Read-Text $record.Path
  if ($null -eq $pageText) { $breadcrumbPass = $false; $breadcrumbMissing += (Split-Path -Leaf $record.Path); Write-Host ('  breadcrumb page missing or unreadable: ' + $record.Path); continue }
  $navs = @([regex]::Matches($pageText, '<nav\b(?=[^>]*\bclass\s*=\s*["''][^"'']*\bcrumbs\b[^"'']*["''])(?=[^>]*\baria-label\s*=\s*["'']Breadcrumb["''])[^>]*>([\s\S]*?)</nav>')); $breadcrumbNavCount += $navs.Count
  if ($navs.Count -ne 1) { $breadcrumbPass = $false; Write-Host ("  {0} breadcrumb nav count={1}; expected=1" -f (Split-Path -Leaf $record.Path), $navs.Count); continue }
  $navText = $navs[0].Groups[1].Value; $ols = @([regex]::Matches($navText, '<ol\b[^>]*>[\s\S]*?</ol>')); $lis = @([regex]::Matches($navText, '<li\b[^>]*>[\s\S]*?</li>')); $breadcrumbLiCount += $lis.Count
  if ($ols.Count -ne 1 -or $lis.Count -ne $record.Depth) { $breadcrumbPass = $false; Write-Host ("  {0} breadcrumb shape: ol={1}, li={2}; expected ol=1, li={3}" -f (Split-Path -Leaf $record.Path), $ols.Count, $lis.Count, $record.Depth) }
  $plainNavText = [regex]::Replace($navText, '<[^>]*>', '')
  if ($plainNavText -match '&rsaquo;|&gt;|&raquo;|[/>]') { $breadcrumbPass = $false; $breadcrumbSeparatorViolations++; Write-Host ('  typed breadcrumb separator found: ' + (Split-Path -Leaf $record.Path)) }
  if ($lis.Count -ne $record.Depth) { continue }
  for ($i = 0; $i -lt $lis.Count; $i++) {
    $li = $lis[$i].Value; $isLast = $i -eq ($lis.Count - 1); $anchors = @([regex]::Matches($li, '<a\b[^>]*\bhref\s*=\s*["'']([^"'']+)["''][^>]*>[\s\S]*?</a>'))
    if (-not $isLast) {
      if ($anchors.Count -ne 1) { $breadcrumbPass = $false; Write-Host ("  ancestor li lacks exactly one anchor: {0} li={1}" -f (Split-Path -Leaf $record.Path), ($i + 1)); continue }
      $breadcrumbAncestorCount++; $href = $anchors[0].Groups[1].Value
      if ($i -ge $record.Hrefs.Count -or $href -ne $record.Hrefs[$i]) { $breadcrumbPass = $false; $expectedHref = if ($i -lt $record.Hrefs.Count) { $record.Hrefs[$i] } else { 'none' }; Write-Host ("  breadcrumb ancestor href mismatch {0} li={1}: actual={2}, expected={3}" -f (Split-Path -Leaf $record.Path), ($i + 1), $href, $expectedHref) }
      $targetHref = ($href -split '#', 2)[0]; if ([string]::IsNullOrWhiteSpace($targetHref)) { $breadcrumbPass = $false; Write-Host ('  empty breadcrumb ancestor href: ' + (Split-Path -Leaf $record.Path)); continue }
      try { $targetPath = [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $record.Path) ($targetHref -replace '/', '\'))) } catch { $targetPath = $null }
      if ($null -eq $targetPath -or -not (Test-Path -LiteralPath $targetPath -PathType Leaf)) { $breadcrumbPass = $false; Write-Host ("  breadcrumb ancestor target missing {0}: {1}" -f (Split-Path -Leaf $record.Path), $href) } elseif ([IO.Path]::GetFullPath($targetPath) -eq [IO.Path]::GetFullPath($record.Path)) { $breadcrumbPass = $false; Write-Host ('  breadcrumb ancestor links to current page: ' + (Split-Path -Leaf $record.Path)) }
    } elseif ($anchors.Count -gt 0) { $breadcrumbPass = $false; Write-Host ('  breadcrumb leaf must not be an anchor: ' + (Split-Path -Leaf $record.Path)) }
  }
  $current = @([regex]::Matches($lis[$lis.Count - 1].Value, '<(?!a\b)[A-Za-z][^>]*\baria-current\s*=\s*["'']page["''][^>]*>')); $currentAnchors = @([regex]::Matches($lis[$lis.Count - 1].Value, '<a\b[^>]*\baria-current\s*=\s*["'']page["'']'))
  if ($current.Count -ne 1 -or $currentAnchors.Count -ne 0) { $breadcrumbPass = $false; Write-Host ("  breadcrumb leaf current marker invalid: {0} non-anchor={1}, anchor={2}" -f (Split-Path -Leaf $record.Path), $current.Count, $currentAnchors.Count) } else { $breadcrumbLeafCount++ }
  foreach ($a in [regex]::Matches($navText, '<a\b[^>]*\bhref\s*=\s*["'']([^"'']+)["'']')) { $targetHref = ($a.Groups[1].Value -split '#', 2)[0]; try { $targetPath = [IO.Path]::GetFullPath((Join-Path (Split-Path -Parent $record.Path) ($targetHref -replace '/', '\'))) } catch { $targetPath = $null }; if ($null -ne $targetPath -and [IO.Path]::GetFullPath($targetPath) -eq [IO.Path]::GetFullPath($record.Path)) { $breadcrumbPass = $false; Write-Host ('  breadcrumb contains self-link: ' + (Split-Path -Leaf $record.Path)) } }
  $leafText = [Net.WebUtility]::HtmlDecode(([regex]::Replace($lis[$lis.Count - 1].Value, '<[^>]*>', '')).Trim())
  if ($record.Type -eq 'chapter') { $breadcrumbLabelCount++; if ($leafText -ne $record.ShortTitle) { $breadcrumbPass = $false; Write-Host ("  breadcrumb shortTitle mismatch {0}: actual='{1}', expected='{2}'" -f (Split-Path -Leaf $record.Path), $leafText, $record.ShortTitle) } } elseif ($leafText -ne $record.Labels[$record.Labels.Count - 1]) { $breadcrumbPass = $false; Write-Host ("  breadcrumb leaf label mismatch {0}: actual='{1}', expected='{2}'" -f (Split-Path -Leaf $record.Path), $leafText, $record.Labels[$record.Labels.Count - 1]) }
}
$themeText = Read-Text (Join-Path $assetRoot 'theme.css')
$cssSeparatorPass = $null -ne $themeText -and $themeText -match '(?m)^\s*\.crumbs\s+li\s*\+\s*li::before\s*\{'
$printCssText = if ($null -ne $themeText -and $themeText.IndexOf('@media print', [StringComparison]::Ordinal) -ge 0) { $themeText.Substring($themeText.IndexOf('@media print', [StringComparison]::Ordinal)) } else { '' }
$cssPrintPass = $printCssText -match '(?s)\.crumbs\b[^{}]*\{[^{}]*display\s*:\s*none'
if (-not $cssSeparatorPass) { $breadcrumbPass = $false; Write-Host '  theme.css missing .crumbs li + li::before separator rule' }
if (-not $cssPrintPass) { $breadcrumbPass = $false; Write-Host '  theme.css print block does not hide .crumbs' }
$expectedBreadcrumbLiCount = 0
foreach ($record in $breadcrumbPageRecords) { $expectedBreadcrumbLiCount += $record.Depth }
$breadcrumbPass = $publishedTopics.Count -gt 0 -and $breadcrumbPass -and $breadcrumbPages -eq $breadcrumbPageRecords.Count -and $breadcrumbNavCount -eq $breadcrumbPageRecords.Count -and $breadcrumbLiCount -eq $expectedBreadcrumbLiCount -and $breadcrumbLeafCount -eq $breadcrumbPageRecords.Count -and $breadcrumbLabelCount -eq @($breadcrumbPageRecords | Where-Object { $_.Type -eq 'chapter' }).Count -and $breadcrumbMissing.Count -eq 0 -and $breadcrumbSeparatorViolations -eq 0
Add-Check 'breadcrumb contract' $breadcrumbPass $breadcrumbPages ("pages={0}, navs={1}, li={2}/{3}, leaves={4}, ancestors={5}, shortTitle-labels={6}, missing={7}, typed-separators={8}, css-separator={9}, print-hide={10}; root has none" -f $breadcrumbPages, $breadcrumbNavCount, $breadcrumbLiCount, $expectedBreadcrumbLiCount, $breadcrumbLeafCount, $breadcrumbAncestorCount, $breadcrumbLabelCount, $breadcrumbMissing.Count, $breadcrumbSeparatorViolations, $cssSeparatorPass, $cssPrintPass)

Write-Host ''
if ($failures -eq 0) { Write-Host ("PASS: {0} checks, 0 failures." -f $checks); exit 0 }
Write-Host ("FAIL: {0} checks, {1} failures." -f $checks, $failures)
exit 1
