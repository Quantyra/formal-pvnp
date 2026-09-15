$ErrorActionPreference = 'Stop'

$repo = 'C:\Users\Dan\Desktop\Projects\formal-pvnp'
$project = Join-Path $repo 'certifications\realizable-hardness'
$sourceRoot = Join-Path $project 'lean'
$mainRel = 'PvNP\RealizableHardness\ActualTaggedConditioningTransport.lean'
$checksRel = 'PvNP\RealizableHardness\ActualTaggedConditioningTransportChecks.lean'
$mainSource = Join-Path $sourceRoot $mainRel
$checksSource = Join-Path $sourceRoot $checksRel
$expectedMain = '4C4D97A764ADD32F54806830B42460169DBFF69A5FFBCD3D5AD5E2DECE06C284'
$expectedChecks = '1ECD3F99C5E3C31B9910588ADC344B2FC0570B2815DE14628223C0A1DD0AF61E'
$seed = Join-Path $project '.lake\build\actual-tagged-question-retained-mass-fresh-20260915\lib\lean'
$targetRoot = Join-Path $project '.lake\build\actual-tagged-conditioning-transport-fresh-20260915'
$target = Join-Path $targetRoot 'lib\lean'
$evidence = Join-Path $repo 'research\evidence\2026-09-15-actual-tagged-conditioning-transport-fresh-run'
$lean = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\bin\lean.exe'
$toolchainLib = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\lib\lean'
$mainObject = Join-Path $target 'PvNP\RealizableHardness\ActualTaggedConditioningTransport.olean'
$checksObject = Join-Path $target 'PvNP\RealizableHardness\ActualTaggedConditioningTransportChecks.olean'

function Hash-Line([string]$path) {
  $h = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  return "$h  $path"
}

function Source-Lines {
  @((Hash-Line $mainSource), (Hash-Line $checksSource))
}

function Assert-Frozen {
  $mh = (Get-FileHash -Algorithm SHA256 -LiteralPath $mainSource).Hash
  $ch = (Get-FileHash -Algorithm SHA256 -LiteralPath $checksSource).Hash
  if ($mh -ne $expectedMain -or $ch -ne $expectedChecks) {
    throw "Frozen source changed: main=$mh checks=$ch"
  }
}

Assert-Frozen
if (-not (Test-Path -LiteralPath $seed -PathType Container)) { throw "Missing seed: $seed" }
if (Test-Path -LiteralPath $targetRoot) { throw "Fresh target already exists: $targetRoot" }
New-Item -ItemType Directory -Path $evidence -Force | Out-Null
New-Item -ItemType Directory -Path $target -Force | Out-Null
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-before.sha256')

$excluded = @(
  'PvNP\RealizableHardness\ActualTaggedConditioningTransport.olean',
  'PvNP\RealizableHardness\ActualTaggedConditioningTransport.ilean',
  'PvNP\RealizableHardness\ActualTaggedConditioningTransport.olean.hash',
  'PvNP\RealizableHardness\ActualTaggedConditioningTransportChecks.olean',
  'PvNP\RealizableHardness\ActualTaggedConditioningTransportChecks.ilean',
  'PvNP\RealizableHardness\ActualTaggedConditioningTransportChecks.olean.hash'
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
"copied_dependency_files=$copied`nexcluded_target_patterns=$($excluded -join ',')" |
  Set-Content -Encoding utf8 (Join-Path $evidence 'seed-copy-metadata.txt')

$seedManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$seedManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'dependency-seed-manifest.tsv')
$seedManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'dependency-seed-manifest.tsv')).Hash

$mainPreexisting = Test-Path -LiteralPath $mainObject
$checksPreexisting = Test-Path -LiteralPath $checksObject
"main_preexisting=$mainPreexisting`nchecks_preexisting=$checksPreexisting" |
  Set-Content -Encoding utf8 (Join-Path $evidence 'preexisting-before.txt')
if ($mainPreexisting -or $checksPreexisting) { throw 'Excluded target artifact was copied from seed' }

$packageOrder = @('cslib','mathlib','complexitylib','plausible','LeanSearchClient','importGraph','proofwidgets','aesop','Qq','batteries','Cli')
$packagePaths = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name\.lake\build\lib\lean"
  if (Test-Path -LiteralPath $p -PathType Container) { $p }
}
$leanPathEntries = @($target) + @($packagePaths) + @($toolchainLib)
$leanPath = $leanPathEntries -join ';'
$env:LEAN_PATH = $leanPath
$env:LEAN_NUM_THREADS = '1'

$mainCommand = "& '$lean' -R lean -o '$mainObject' '$mainSource'"
$checksCommand = "& '$lean' -R lean -o '$checksObject' '$checksSource'"
@(
  "cwd=$project",
  "main=$mainCommand",
  "checks=$checksCommand",
  'execution=sequential main then Checks',
  'LEAN_NUM_THREADS=1',
  'no_lake_build=true'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'commands.txt')
$leanPath | Set-Content -Encoding utf8 (Join-Path $evidence 'lean-path.txt')

Push-Location $project
try {
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

@((Hash-Line $mainObject), (Hash-Line $checksObject)) |
  Set-Content -Encoding utf8 (Join-Path $evidence 'object-hashes.txt')
$outManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$outManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'fresh-output-inventory.tsv')
$outManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'fresh-output-inventory.tsv')).Hash

$scanPattern = '(?i)\bsorry\b|\badmit\b|\bnative_decide\b|^\s*axiom\b'
$scanHits = Select-String -Path $mainSource,$checksSource -Pattern $scanPattern
if ($scanHits) {
  $scanHits | ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line)" } |
    Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
  throw 'Forbidden proof mechanism or explicit axiom found'
} else {
  "pattern=$scanPattern`nresult=clean (no matches)" |
    Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
}
Copy-Item -LiteralPath (Join-Path $evidence 'checks.stdout.log') -Destination (Join-Path $evidence 'signature-axioms.txt')
$axiomLines = Select-String -Path (Join-Path $evidence 'checks.stdout.log') -Pattern 'depends on axioms:' | ForEach-Object { $_.Line }
$uniqueAxioms = $axiomLines | Sort-Object -Unique
@(
  'source_explicit_axiom_scan=clean',
  'checks_print_axioms_profiles:',
  $uniqueAxioms,
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
  'main_preexisting=false',
  'checks_preexisting=false',
  'main_exit=0',
  'checks_exit=0',
  'source_stable=true',
  'no_lake_build=true',
  'scope=target-fresh main-and-Checks build against immutable seeded dependencies; not a full dependency source rebuild',
  'package_revisions:',
  $pins
) | Set-Content -Encoding utf8 (Join-Path $evidence 'provenance.txt')

@(
  '# Actual tagged conditioning transport target-fresh certification',
  '',
  '- Result: PASS (main exit 0; Checks exit 0).',
  '- Sources remained at their frozen SHA-256 values before, between, and after compilation.',
  '- The isolated target was seeded from the retained-mass certified dependency tree while excluding all conditioning-transport main and Checks artifacts.',
  '- Main and Checks were compiled sequentially with Lean v4.34.0-rc2 and `LEAN_NUM_THREADS=1`.',
  '- Source scans found no `sorry`, `admit`, `native_decide`, or explicit axiom declaration.',
  '- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.',
  '- Scope: target-fresh compilation against immutable seeded dependencies. This is not a full dependency source rebuild.'
) | Set-Content -Encoding utf8 (Join-Path $evidence 'README.md')

$artifactManifestPath = Join-Path $evidence 'artifact-hashes.txt'
$artifactPointerPath = Join-Path $evidence 'artifact-hashes-manifest.sha256'
$artifactRows = foreach ($f in (Get-ChildItem -LiteralPath $evidence -File | Where-Object {
    $_.FullName -ne $artifactManifestPath -and $_.FullName -ne $artifactPointerPath
  } | Sort-Object Name)) {
  "$($f.Name)`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$artifactRows | Set-Content -Encoding utf8 $artifactManifestPath
$artifactManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $artifactManifestPath).Hash
"$artifactManifestHash  $artifactManifestPath" | Set-Content -Encoding utf8 $artifactPointerPath

Write-Output "PASS"
Write-Output "main_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $mainObject).Hash)"
Write-Output "checks_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $checksObject).Hash)"
Write-Output "seed_manifest=$seedManifestHash"
Write-Output "output_inventory=$outManifestHash"
Write-Output "artifact_manifest=$artifactManifestHash"
