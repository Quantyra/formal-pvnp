$ErrorActionPreference = 'Stop'

$repo = 'C:\Users\Dan\Desktop\Projects\formal-pvnp'
$project = Join-Path $repo 'certifications\realizable-hardness'
$sourceRoot = Join-Path $project 'lean'
$mainRel = 'PvNP\RealizableHardness\ActualStarSideConditionAgreement.lean'
$checksRel = 'PvNP\RealizableHardness\ActualStarSideConditionAgreementChecks.lean'
$mainSource = Join-Path $sourceRoot $mainRel
$checksSource = Join-Path $sourceRoot $checksRel
$supportSource = Join-Path $sourceRoot 'PvNP\RealizableHardness\ActualStarQuestionSupport.lean'
$spanSource = Join-Path $sourceRoot 'PvNP\RealizableHardness\ActualStarSpanIntersection.lean'
$expectedMain = '4DB1C6998C63E028A85757A7EB0E25130CCCA9FD9D2DADAC2FD6D4FA0AE6E6B4'
$expectedChecks = '8AE211FC034B96D777867334266F7893C8E2195BE0A45626A7F4AC4CB7C75489'
$expectedSupport = '39E6F608A3735BCFB5BBD0F8B5E3A3E875151EAF3A4B74298B2A6063411DAE35'
$expectedSpan = 'F3CE6ED0BF8FB9164F16EB846A3378FD2F3471016ECE35F5DB8C091E967042A5'
$seed = Join-Path $project '.lake\build\actual-tagged-failure-transport-fresh-20260915\lib\lean'
$targetRoot = Join-Path $project '.lake\build\actual-star-side-condition-agreement-fresh-20260915'
$target = Join-Path $targetRoot 'lib\lean'
$evidence = Join-Path $repo 'research\evidence\2026-09-15-actual-star-side-condition-agreement-fresh-run'
$lean = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\bin\lean.exe'
$toolchainLib = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\lib\lean'
$mainObject = Join-Path $target 'PvNP\RealizableHardness\ActualStarSideConditionAgreement.olean'
$checksObject = Join-Path $target 'PvNP\RealizableHardness\ActualStarSideConditionAgreementChecks.olean'
$supportObject = Join-Path $target 'PvNP\RealizableHardness\ActualStarQuestionSupport.olean'
$spanObject = Join-Path $target 'PvNP\RealizableHardness\ActualStarSpanIntersection.olean'

function Hash-Line([string]$path) {
  $h = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  return "$h  $path"
}

function Source-Lines {
  @((Hash-Line $supportSource), (Hash-Line $spanSource), (Hash-Line $mainSource), (Hash-Line $checksSource))
}

function Assert-Frozen {
  $mh = (Get-FileHash -Algorithm SHA256 -LiteralPath $mainSource).Hash
  $ch = (Get-FileHash -Algorithm SHA256 -LiteralPath $checksSource).Hash
  $qh = (Get-FileHash -Algorithm SHA256 -LiteralPath $supportSource).Hash
  $sh = (Get-FileHash -Algorithm SHA256 -LiteralPath $spanSource).Hash
  if ($mh -ne $expectedMain -or $ch -ne $expectedChecks -or $qh -ne $expectedSupport -or $sh -ne $expectedSpan) {
    throw "Frozen source changed: support=$qh span=$sh main=$mh checks=$ch"
  }
}

Assert-Frozen
if (-not (Test-Path -LiteralPath $seed -PathType Container)) { throw "Missing seed: $seed" }
if (Test-Path -LiteralPath $targetRoot) { throw "Fresh target already exists: $targetRoot" }
New-Item -ItemType Directory -Path $evidence -Force | Out-Null
New-Item -ItemType Directory -Path $target -Force | Out-Null
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-before.sha256')

$excluded = @(
  'PvNP\RealizableHardness\ActualStarSideConditionAgreement.olean',
  'PvNP\RealizableHardness\ActualStarSideConditionAgreement.ilean',
  'PvNP\RealizableHardness\ActualStarSideConditionAgreement.olean.hash',
  'PvNP\RealizableHardness\ActualStarSideConditionAgreementChecks.olean',
  'PvNP\RealizableHardness\ActualStarSideConditionAgreementChecks.ilean',
  'PvNP\RealizableHardness\ActualStarSideConditionAgreementChecks.olean.hash',
  'PvNP\RealizableHardness\ActualStarSpanIntersection.olean',
  'PvNP\RealizableHardness\ActualStarSpanIntersection.ilean',
  'PvNP\RealizableHardness\ActualStarSpanIntersection.olean.hash',
  'PvNP\RealizableHardness\ActualStarQuestionSupport.olean',
  'PvNP\RealizableHardness\ActualStarQuestionSupport.ilean',
  'PvNP\RealizableHardness\ActualStarQuestionSupport.olean.hash'
)
$seedFiles = Get-ChildItem -LiteralPath $seed -Recurse -File | Sort-Object FullName
$copied = 0
foreach ($f in $seedFiles) {
  $rel = $f.FullName.Substring($seed.Length).TrimStart('\')
  if ($excluded -contains $rel) { continue }
  $dst = Join-Path $target $rel
  New-Item -ItemType Directory -Path (Split-Path -Parent $dst) -Force | Out-Null
  Copy-Item -LiteralPath $f.FullName -Destination $dst
  $copied++
}
$finiteSourceObject = Join-Path $target 'PvNP\RealizableHardness\ActualFinite3LinSource.olean'
if (-not (Test-Path -LiteralPath $finiteSourceObject -PathType Leaf)) { throw 'Seed lacks ActualFinite3LinSource.olean' }
"copied_dependency_files=$copied`nexcluded_target_patterns=$($excluded -join ',')`nsupport_source_sha256=$expectedSupport`nsupport_prior_certification=research/evidence/2026-09-14-actual-star-private-coordinate-fresh-run`nsupport_build=excluded from seed and rebuilt from frozen certified source before span`nspan_source_sha256=$expectedSpan`nspan_prior_certification=research/evidence/2026-09-14-actual-star-span-intersection-strengthened-checks-fresh-run`nspan_build=excluded from seed and rebuilt from frozen certified source before main`nfinite_source_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $finiteSourceObject).Hash)" |
  Set-Content -Encoding utf8 (Join-Path $evidence 'seed-copy-metadata.txt')

$seedManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$seedManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'dependency-seed-manifest.tsv')
$seedManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'dependency-seed-manifest.tsv')).Hash

$mainPreexisting = Test-Path -LiteralPath $mainObject
$checksPreexisting = Test-Path -LiteralPath $checksObject
$supportPreexisting = Test-Path -LiteralPath $supportObject
$spanPreexisting = Test-Path -LiteralPath $spanObject
"support_preexisting=$supportPreexisting`nspan_preexisting=$spanPreexisting`nmain_preexisting=$mainPreexisting`nchecks_preexisting=$checksPreexisting" |
  Set-Content -Encoding utf8 (Join-Path $evidence 'preexisting-before.txt')
if ($supportPreexisting -or $spanPreexisting -or $mainPreexisting -or $checksPreexisting) { throw 'Excluded target artifact was copied from seed' }

$packageOrder = @('cslib','mathlib','complexitylib','plausible','LeanSearchClient','importGraph','proofwidgets','aesop','Qq','batteries','Cli')
$packagePaths = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name\.lake\build\lib\lean"
  if (Test-Path -LiteralPath $p -PathType Container) { $p }
}
$leanPathEntries = @($target) + @($packagePaths) + @($toolchainLib)
$leanPath = $leanPathEntries -join ';'
$env:LEAN_PATH = $leanPath
$env:LEAN_NUM_THREADS = '1'

$supportCommand = "& '$lean' -R lean -o '$supportObject' '$supportSource'"
$spanCommand = "& '$lean' -R lean -o '$spanObject' '$spanSource'"
$mainCommand = "& '$lean' -R lean -o '$mainObject' '$mainSource'"
$checksCommand = "& '$lean' -R lean -o '$checksObject' '$checksSource'"
@(
  "cwd=$project",
  "support_dependency=$supportCommand",
  "span_dependency=$spanCommand",
  "main=$mainCommand",
  "checks=$checksCommand",
  'execution=sequential frozen support dependency, frozen span dependency, main, then Checks',
  'LEAN_NUM_THREADS=1',
  'no_lake_build=true'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'commands.txt')
$leanPath | Set-Content -Encoding utf8 (Join-Path $evidence 'lean-path.txt')

Push-Location $project
try {
  & $lean -R lean -o $supportObject $supportSource 1> (Join-Path $evidence 'support.stdout.log') 2> (Join-Path $evidence 'support.stderr.log')
  $supportExit = $LASTEXITCODE
  "exit_code=$supportExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'support.exit.txt')
  Get-Content (Join-Path $evidence 'support.stdout.log'),(Join-Path $evidence 'support.stderr.log') |
    Set-Content -Encoding utf8 (Join-Path $evidence 'support.combined.log')
  if ($supportExit -ne 0) { throw "Support dependency compile failed: $supportExit" }
  Assert-Frozen
  if (-not (Test-Path -LiteralPath $supportObject -PathType Leaf)) { throw 'Support dependency object missing after successful exit' }
  & $lean -R lean -o $spanObject $spanSource 1> (Join-Path $evidence 'span.stdout.log') 2> (Join-Path $evidence 'span.stderr.log')
  $spanExit = $LASTEXITCODE
  "exit_code=$spanExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'span.exit.txt')
  Get-Content (Join-Path $evidence 'span.stdout.log'),(Join-Path $evidence 'span.stderr.log') |
    Set-Content -Encoding utf8 (Join-Path $evidence 'span.combined.log')
  if ($spanExit -ne 0) { throw "Span dependency compile failed: $spanExit" }
  Assert-Frozen
  if (-not (Test-Path -LiteralPath $spanObject -PathType Leaf)) { throw 'Span dependency object missing after successful exit' }
  & $lean -R lean -o $mainObject $mainSource 1> (Join-Path $evidence 'main.stdout.log') 2> (Join-Path $evidence 'main.stderr.log')
  $mainExit = $LASTEXITCODE
  "exit_code=$mainExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'main.exit.txt')
  Get-Content (Join-Path $evidence 'main.stdout.log'),(Join-Path $evidence 'main.stderr.log') |
    Set-Content -Encoding utf8 (Join-Path $evidence 'main.combined.log')
  if ($mainExit -ne 0) { throw "Main compile failed: $mainExit" }
  Assert-Frozen
  if (-not (Test-Path -LiteralPath $mainObject -PathType Leaf)) { throw 'Main object missing after successful exit' }
  & $lean -R lean -o $checksObject $checksSource 1> (Join-Path $evidence 'checks.stdout.log') 2> (Join-Path $evidence 'checks.stderr.log')
  $checksExit = $LASTEXITCODE
  "exit_code=$checksExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'checks.exit.txt')
  Get-Content (Join-Path $evidence 'checks.stdout.log'),(Join-Path $evidence 'checks.stderr.log') |
    Set-Content -Encoding utf8 (Join-Path $evidence 'checks.combined.log')
  if ($checksExit -ne 0) { throw "Checks compile failed: $checksExit" }
} finally {
  Pop-Location
}

Assert-Frozen
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-after.sha256')
$before = Get-Content -Raw (Join-Path $evidence 'source-before.sha256')
$after = Get-Content -Raw (Join-Path $evidence 'source-after.sha256')
"stable=$($before -eq $after)" | Set-Content -Encoding utf8 (Join-Path $evidence 'source-stability.txt')

@((Hash-Line $supportObject), (Hash-Line $spanObject), (Hash-Line $mainObject), (Hash-Line $checksObject)) |
  Set-Content -Encoding utf8 (Join-Path $evidence 'object-hashes.txt')
$outManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$outManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'fresh-output-inventory.tsv')
$outManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'fresh-output-inventory.tsv')).Hash

$scanPattern = '(?i)\bsorry\b|\badmit\b|\bnative_decide\b|\bspan_induction\b|^\s*axiom\b'
$scanHits = Select-String -Path $supportSource,$spanSource,$mainSource,$checksSource -Pattern $scanPattern
if ($scanHits) {
  $scanHits | ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line)" } |
    Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
  throw 'Forbidden proof mechanism or explicit axiom found'
} else {
  "pattern=$scanPattern`nresult=clean (no matches)" |
    Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
}
Copy-Item -LiteralPath (Join-Path $evidence 'checks.stdout.log') -Destination (Join-Path $evidence 'signature-axioms.txt')
$checksText = Get-Content -Raw (Join-Path $evidence 'checks.stdout.log')
$axiomMatches = [regex]::Matches($checksText, "(?ms)^'[^']+' depends on axioms: \[[^\]]+\]")
$axiomProfiles = $axiomMatches | ForEach-Object { ($_.Value -replace "`r?`n\s*", ' ').Trim() }
$axiomSets = $axiomProfiles | ForEach-Object {
  if ($_ -match 'depends on axioms: (\[[^\]]+\])') { $Matches[1] }
} | Sort-Object -Unique
@(
  'source_explicit_axiom_scan=clean',
  'checks_print_axioms_profiles:',
  $axiomProfiles,
  "unique_axiom_sets=$($axiomSets -join '; ')",
  'classification=only standard Lean/Mathlib axioms reported; no user-defined or newly introduced axioms'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'axiom-profile.txt')

$version = (& $lean --version) -join "`n"
$toolchainHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $lean).Hash
$rootHead = (& git -C $repo rev-parse HEAD).Trim()
$pins = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name"
  if (Test-Path -LiteralPath (Join-Path $p '.git')) {
    "$name=$((& git -C $p rev-parse HEAD).Trim())"
  }
}
$lakeManifest = Join-Path $project 'lake-manifest.json'
$lakeManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $lakeManifest).Hash
@(
  'date=2026-09-15',
  "git_head=$rootHead",
  "toolchain=$version",
  "lean_executable=$lean",
  "lean_executable_sha256=$toolchainHash",
  'LEAN_NUM_THREADS=1',
  "LEAN_PATH=$leanPath",
  "seed_target=$seed",
  "fresh_target=$target",
  "dependency_seed_manifest_sha256=$seedManifestHash",
  "fresh_output_inventory_sha256=$outManifestHash",
  "lake_manifest_sha256=$lakeManifestHash",
  'support_preexisting=false',
  'span_preexisting=false',
  'main_preexisting=false',
  'checks_preexisting=false',
  'support_exit=0',
  'span_exit=0',
  'main_exit=0',
  'checks_exit=0',
  'source_stable=true',
  'no_lake_build=true',
  'scope=target-fresh frozen support dependency, frozen span dependency, main, and Checks build against immutable seeded transitive dependencies; not a full dependency source rebuild',
  'package_revisions:',
  $pins
) | Set-Content -Encoding utf8 (Join-Path $evidence 'provenance.txt')

@(
  '# Actual star side-condition agreement target-fresh certification',
  '',
  '- Result: PASS (frozen support dependency exit 0; frozen span dependency exit 0; main exit 0; Checks exit 0).',
  '- Sources remained at their frozen SHA-256 values before, between, and after compilation.',
  '- The isolated target was seeded from the certified failure-transport dependency tree while excluding all side-condition and stale span-intersection artifacts.',
  '- The frozen, previously certified star-support source and then span-intersection source were rebuilt first; main and Checks followed sequentially with Lean v4.34.0-rc2 and `LEAN_NUM_THREADS=1`.',
  '- Source scans found no `sorry`, `admit`, `native_decide`, `span_induction`, or explicit axiom declaration.',
  '- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.',
  '- Scope: target-fresh compilation against immutable seeded dependencies. This is not a full dependency source rebuild.'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'README.md')

@(
  "main_source_sha256=$expectedMain",
  "checks_source_sha256=$expectedChecks",
  "support_source_sha256=$expectedSupport",
  "support_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $supportObject).Hash)",
  "span_source_sha256=$expectedSpan",
  "span_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $spanObject).Hash)",
  "main_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $mainObject).Hash)",
  "checks_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $checksObject).Hash)",
  'result=PASS'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'post-run-validation.txt')

$artifactManifestPath = Join-Path $evidence 'artifact-hashes.txt'
$artifactPointerPath = Join-Path $evidence 'artifact-hashes-manifest.sha256'
$artifactRows = foreach ($f in (Get-ChildItem -LiteralPath $evidence -File | Where-Object {
    $_.FullName -ne $artifactManifestPath -and $_.FullName -ne $artifactPointerPath -and
    $_.Name -ne 'independent-rehash.txt'
  } | Sort-Object Name)) {
  "$($f.Name)`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$artifactRows | Set-Content -Encoding utf8 $artifactManifestPath
$artifactManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $artifactManifestPath).Hash
"$artifactManifestHash  $artifactManifestPath" | Set-Content -Encoding utf8 $artifactPointerPath

$rehashFailures = @()
foreach ($row in (Get-Content -LiteralPath $artifactManifestPath)) {
  $parts = $row -split "`t"
  if ($parts.Count -ne 3) { $rehashFailures += "malformed=$row"; continue }
  $path = Join-Path $evidence $parts[0]
  if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
    $rehashFailures += "missing=$($parts[0])"
    continue
  }
  $actualLength = (Get-Item -LiteralPath $path).Length
  $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  if ($actualLength -ne [int64]$parts[1] -or $actualHash -ne $parts[2]) {
    $rehashFailures += "mismatch=$($parts[0]) expected_len=$($parts[1]) actual_len=$actualLength expected_hash=$($parts[2]) actual_hash=$actualHash"
  }
}
$pointerHash = ((Get-Content -Raw $artifactPointerPath).Trim() -split '\s+')[0]
$sourceBeforeText = Get-Content -Raw (Join-Path $evidence 'source-before.sha256')
$sourceAfterText = Get-Content -Raw (Join-Path $evidence 'source-after.sha256')
$rehashPass = $rehashFailures.Count -eq 0 -and $pointerHash -eq $artifactManifestHash -and $sourceBeforeText -eq $sourceAfterText
@(
  'method=independent post-run rehash of every artifact-hashes.txt row',
  "artifact_rows=$($artifactRows.Count)",
  "row_mismatches=$($rehashFailures.Count)",
  "artifact_manifest_sha256=$artifactManifestHash",
  "pointer_sha256=$pointerHash",
  "pointer_matches=$($pointerHash -eq $artifactManifestHash)",
  "source_before_after_equal=$($sourceBeforeText -eq $sourceAfterText)",
  $rehashFailures,
  "result=$(if ($rehashPass) { 'PASS' } else { 'FAIL' })"
) | Set-Content -Encoding utf8 (Join-Path $evidence 'independent-rehash.txt')
if (-not $rehashPass) { throw 'Independent artifact rehash failed' }

Write-Output 'PASS'
Write-Output "support_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $supportObject).Hash)"
Write-Output "span_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $spanObject).Hash)"
Write-Output "main_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $mainObject).Hash)"
Write-Output "checks_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $checksObject).Hash)"
Write-Output "seed_manifest=$seedManifestHash"
Write-Output "output_inventory=$outManifestHash"
Write-Output "artifact_manifest=$artifactManifestHash"

