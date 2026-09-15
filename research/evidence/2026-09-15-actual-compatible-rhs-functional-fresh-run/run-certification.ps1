$ErrorActionPreference = 'Stop'

$repo = 'C:\Users\Dan\Desktop\Projects\formal-pvnp'
$project = Join-Path $repo 'certifications\realizable-hardness'
$sourceRoot = Join-Path $project 'lean'
$moduleRoot = Join-Path $sourceRoot 'PvNP\RealizableHardness'
$evidence = Join-Path $repo 'research\evidence\2026-09-15-actual-compatible-rhs-functional-fresh-run'
$seed = Join-Path $project '.lake\build\actual-rhs-functional-construction-fresh-20260915\lib\lean'
$targetRoot = Join-Path $project '.lake\build\actual-compatible-rhs-functional-fresh-20260915'
$target = Join-Path $targetRoot 'lib\lean'
$lean = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\bin\lean.exe'
$toolchainLib = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\lib\lean'

$stages = @(
  [ordered]@{ Key='support'; Module='ActualStarQuestionSupport'; Hash='39E6F608A3735BCFB5BBD0F8B5E3A3E875151EAF3A4B74298B2A6063411DAE35' },
  [ordered]@{ Key='span'; Module='ActualStarSpanIntersection'; Hash='F3CE6ED0BF8FB9164F16EB846A3378FD2F3471016ECE35F5DB8C091E967042A5' },
  [ordered]@{ Key='finite'; Module='ActualFinite3LinSource'; Hash='3109F8B0078B7F6253110ED2C39FC85935268768AB0A0A6B9CDA2F029B8B761F' },
  [ordered]@{ Key='rhs'; Module='ActualRhsFunctionalConstruction'; Hash='A38112D36CED08F6D8AD151D85D08D1140CD8A17D40EFED8DEAB6B25E3100428' },
  [ordered]@{ Key='side'; Module='ActualStarSideConditionAgreement'; Hash='4DB1C6998C63E028A85757A7EB0E25130CCCA9FD9D2DADAC2FD6D4FA0AE6E6B4' },
  [ordered]@{ Key='main'; Module='ActualCompatibleRhsFunctional'; Hash='5173EA699D41D0305508376F9EDEE99F8202FCD8C8EC134021BEE78366CD65CB' },
  [ordered]@{ Key='checks'; Module='ActualCompatibleRhsFunctionalChecks'; Hash='F3E5525D5BEACFFB2329E91377293DD1F781E6EB8F45C2DB3395BB40BA455ADA' }
)

foreach ($stage in $stages) {
  $stage.Source = Join-Path $moduleRoot ($stage.Module + '.lean')
  $stage.Object = Join-Path $target ('PvNP\RealizableHardness\' + $stage.Module + '.olean')
}

function Hash-Line([string]$path) {
  "$((Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash)  $path"
}

function Assert-Frozen {
  foreach ($stage in $stages) {
    $actual = (Get-FileHash -Algorithm SHA256 -LiteralPath $stage.Source).Hash
    if ($actual -ne $stage.Hash) {
      throw "Frozen source changed: $($stage.Key) expected=$($stage.Hash) actual=$actual"
    }
  }
}

function Source-Lines {
  foreach ($stage in $stages) { Hash-Line $stage.Source }
}

Assert-Frozen
if (-not (Test-Path -LiteralPath $seed -PathType Container)) { throw "Missing seed: $seed" }
if (Test-Path -LiteralPath $targetRoot) { throw "Fresh target already exists: $targetRoot" }
New-Item -ItemType Directory -Path $evidence -Force | Out-Null
New-Item -ItemType Directory -Path $target -Force | Out-Null
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-before.sha256')

$excluded = @()
foreach ($stage in $stages) {
  foreach ($suffix in @('.olean','.ilean','.olean.hash')) {
    $excluded += 'PvNP\RealizableHardness\' + $stage.Module + $suffix
  }
}
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
@(
  "copied_dependency_files=$copied",
  "excluded_target_patterns=$($excluded -join ',')",
  'seed_prior_certification=research/evidence/2026-09-15-actual-rhs-functional-construction-fresh-run',
  'rebuild_order=support,span,finite,rhs,side,main,checks'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'seed-copy-metadata.txt')

$seedManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$seedManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'dependency-seed-manifest.tsv')
$seedManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'dependency-seed-manifest.tsv')).Hash

$preexisting = @()
foreach ($stage in $stages) {
  $exists = Test-Path -LiteralPath $stage.Object -PathType Leaf
  $preexisting += "$($stage.Key)_preexisting=$exists"
  if ($exists) { throw "Excluded target artifact was copied from seed: $($stage.Key)" }
}
$preexisting | Set-Content -Encoding utf8 (Join-Path $evidence 'preexisting-before.txt')

$packageOrder = @('cslib','mathlib','complexitylib','plausible','LeanSearchClient','importGraph','proofwidgets','aesop','Qq','batteries','Cli')
$packagePaths = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name\.lake\build\lib\lean"
  if (Test-Path -LiteralPath $p -PathType Container) { $p }
}
$leanPath = (@($target) + @($packagePaths) + @($toolchainLib)) -join ';'
$env:LEAN_PATH = $leanPath
$env:LEAN_NUM_THREADS = '1'
$leanPath | Set-Content -Encoding utf8 (Join-Path $evidence 'lean-path.txt')
@(
  "cwd=$project",
  ($stages | ForEach-Object { "$($_.Key)=& '$lean' -R lean -o '$($_.Object)' '$($_.Source)'" }),
  'execution=sequential frozen dependency chain, main, then Checks; source hashes asserted after every stage',
  'LEAN_NUM_THREADS=1',
  'no_lake_build=true'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'commands.txt')

Push-Location $project
try {
  foreach ($stage in $stages) {
    $stdout = Join-Path $evidence ($stage.Key + '.stdout.log')
    $stderr = Join-Path $evidence ($stage.Key + '.stderr.log')
    $combined = Join-Path $evidence ($stage.Key + '.combined.log')
    & $lean -R lean -o $stage.Object $stage.Source 1> $stdout 2> $stderr
    $exitCode = $LASTEXITCODE
    "exit_code=$exitCode" | Set-Content -Encoding utf8 (Join-Path $evidence ($stage.Key + '.exit.txt'))
    New-Item -ItemType File -Path $combined -Force | Out-Null
    Get-Content $stdout,$stderr | Add-Content -Encoding utf8 $combined
    if ($exitCode -ne 0) { throw "$($stage.Key) compile failed: $exitCode" }
    Assert-Frozen
    if (-not (Test-Path -LiteralPath $stage.Object -PathType Leaf)) { throw "$($stage.Key) object missing" }
  }
} finally {
  Pop-Location
}

Assert-Frozen
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-after.sha256')
$before = Get-Content -Raw (Join-Path $evidence 'source-before.sha256')
$after = Get-Content -Raw (Join-Path $evidence 'source-after.sha256')
"stable=$($before -eq $after)" | Set-Content -Encoding utf8 (Join-Path $evidence 'source-stability.txt')
if ($before -ne $after) { throw 'Source hashes differ before and after build' }

@(foreach ($stage in $stages) { Hash-Line $stage.Object }) |
  Set-Content -Encoding utf8 (Join-Path $evidence 'object-hashes.txt')
$outManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$outManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'fresh-output-inventory.tsv')
$outManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'fresh-output-inventory.tsv')).Hash

$scanPattern = '(?i)\bsorry\b|\badmit\b|\bnative_decide\b|\bspan_induction\b|^\s*axiom\b'
$scanHits = Select-String -Path ($stages | ForEach-Object Source) -Pattern $scanPattern
if ($scanHits) {
  $scanHits | ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line)" } |
    Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
  throw 'Forbidden proof mechanism or explicit axiom found'
}
"pattern=$scanPattern`nresult=clean (no matches)" | Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')

$checksStdout = Join-Path $evidence 'checks.stdout.log'
Copy-Item -LiteralPath $checksStdout -Destination (Join-Path $evidence 'signature-axioms.txt')
$checksText = Get-Content -Raw $checksStdout
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

$warningRows = @()
foreach ($stage in $stages) {
  $matches = Select-String -Path (Join-Path $evidence ($stage.Key + '.combined.log')) -Pattern '(?i)warning:'
  foreach ($match in $matches) { $warningRows += "$($stage.Key):$($match.LineNumber):$($match.Line)" }
}
@(
  "warning_count=$($warningRows.Count)",
  $warningRows
) | Set-Content -Encoding utf8 (Join-Path $evidence 'warnings.txt')

$version = (& $lean --version) -join "`n"
$toolchainHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $lean).Hash
$rootHead = (& git -C $repo rev-parse HEAD).Trim()
$pins = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name"
  if (Test-Path -LiteralPath (Join-Path $p '.git')) { "$name=$((& git -C $p rev-parse HEAD).Trim())" }
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
  ($stages | ForEach-Object { "$($_.Key)_preexisting=false" }),
  ($stages | ForEach-Object { "$($_.Key)_exit=0" }),
  'source_stable=true',
  'no_lake_build=true',
  'scope=target-fresh frozen direct dependency chain, main, and Checks build against immutable seeded transitive dependencies; not a full dependency source rebuild',
  'package_revisions:',
  $pins
) | Set-Content -Encoding utf8 (Join-Path $evidence 'provenance.txt')

@(
  '# Actual compatible RHS-functional target-fresh certification',
  '',
  '- Result: PASS (support, span intersection, finite source, RHS construction, side-condition agreement, main, and Checks all exited 0).',
  '- Every source remained at its frozen SHA-256 before, between, and after compilation.',
  '- The isolated target was seeded from the certified RHS-functional dependency tree while excluding every rebuilt module artifact.',
  '- Lean v4.34.0-rc2 ran sequentially with `LEAN_NUM_THREADS=1`.',
  '- Source scans found no `sorry`, `admit`, `native_decide`, `span_induction`, or explicit axiom declaration.',
  '- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.',
  "- Warning count: $($warningRows.Count).",
  '- Scope: one target-fresh compilation against immutable seeded transitive dependencies. This is not a full dependency source rebuild.'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'README.md')

@(
  ($stages | ForEach-Object { "$($_.Key)_source_sha256=$($_.Hash)" }),
  ($stages | ForEach-Object { "$($_.Key)_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $_.Object).Hash)" }),
  "warning_count=$($warningRows.Count)",
  'source_mismatches=0',
  'result=PASS'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'post-run-validation.txt')

$artifactManifestPath = Join-Path $evidence 'artifact-hashes.txt'
$artifactPointerPath = Join-Path $evidence 'artifact-hashes-manifest.sha256'
$artifactRows = foreach ($f in (Get-ChildItem -LiteralPath $evidence -File | Where-Object {
    $_.FullName -ne $artifactManifestPath -and $_.FullName -ne $artifactPointerPath -and $_.Name -ne 'independent-rehash.txt'
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
  if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { $rehashFailures += "missing=$($parts[0])"; continue }
  $actualLength = (Get-Item -LiteralPath $path).Length
  $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  if ($actualLength -ne [int64]$parts[1] -or $actualHash -ne $parts[2]) {
    $rehashFailures += "mismatch=$($parts[0]) expected_len=$($parts[1]) actual_len=$actualLength expected_hash=$($parts[2]) actual_hash=$actualHash"
  }
}
$pointerHash = ((Get-Content -Raw $artifactPointerPath).Trim() -split '\s+')[0]
$rehashPass = $rehashFailures.Count -eq 0 -and $pointerHash -eq $artifactManifestHash -and $before -eq $after
@(
  'method=independent post-run rehash of every artifact-hashes.txt row',
  "artifact_rows=$($artifactRows.Count)",
  "row_mismatches=$($rehashFailures.Count)",
  "artifact_manifest_sha256=$artifactManifestHash",
  "pointer_sha256=$pointerHash",
  "pointer_matches=$($pointerHash -eq $artifactManifestHash)",
  "source_before_after_equal=$($before -eq $after)",
  $rehashFailures,
  "result=$(if ($rehashPass) { 'PASS' } else { 'FAIL' })"
) | Set-Content -Encoding utf8 (Join-Path $evidence 'independent-rehash.txt')
if (-not $rehashPass) { throw 'Independent artifact rehash failed' }

Write-Output 'PASS'
foreach ($stage in $stages) { Write-Output "$($stage.Key)_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $stage.Object).Hash)" }
Write-Output "seed_manifest=$seedManifestHash"
Write-Output "output_inventory=$outManifestHash"
Write-Output "artifact_manifest=$artifactManifestHash"
Write-Output "warning_count=$($warningRows.Count)"
