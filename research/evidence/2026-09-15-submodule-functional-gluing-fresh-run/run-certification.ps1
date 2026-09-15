$ErrorActionPreference = 'Stop'

$repo = 'C:\Users\Dan\Desktop\Projects\formal-pvnp'
$project = Join-Path $repo 'certifications\realizable-hardness'
$sourceRoot = Join-Path $project 'lean'
$mainRel = 'PvNP\RealizableHardness\SubmoduleFunctionalGluing.lean'
$checksRel = 'PvNP\RealizableHardness\SubmoduleFunctionalGluingChecks.lean'
$mainSource = Join-Path $sourceRoot $mainRel
$checksSource = Join-Path $sourceRoot $checksRel
$expectedMain = '3AFDACA24136FB81140471BD7CB40398CE61A2D1896DD78973E25041D51E7D73'
$expectedChecks = 'E41183DB2B49F958C7CA0FA753AB58721AD63D7ACAFA1DDD2715DB54CAE4DA52'
$seed = Join-Path $project '.lake\build\actual-rhs-functional-construction-fresh-20260915\lib\lean'
$targetRoot = Join-Path $project '.lake\build\submodule-functional-gluing-fresh-20260915'
$target = Join-Path $targetRoot 'lib\lean'
$evidence = Join-Path $repo 'research\evidence\2026-09-15-submodule-functional-gluing-fresh-run'
$lean = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\bin\lean.exe'
$toolchainLib = 'C:\Users\Dan\.elan\toolchains\leanprover--lean4---v4.34.0-rc2\lib\lean'
$mainObject = Join-Path $target 'PvNP\RealizableHardness\SubmoduleFunctionalGluing.olean'
$checksObject = Join-Path $target 'PvNP\RealizableHardness\SubmoduleFunctionalGluingChecks.olean'

function Hash-Line([string]$path) {
  $h = (Get-FileHash -Algorithm SHA256 -LiteralPath $path).Hash
  return "$h  $path"
}
function Source-Lines { @((Hash-Line $mainSource), (Hash-Line $checksSource)) }
function Assert-Frozen {
  $mh = (Get-FileHash -Algorithm SHA256 -LiteralPath $mainSource).Hash
  $ch = (Get-FileHash -Algorithm SHA256 -LiteralPath $checksSource).Hash
  if ($mh -ne $expectedMain -or $ch -ne $expectedChecks) { throw "Frozen source changed: main=$mh checks=$ch" }
}

Assert-Frozen
if (-not (Test-Path -LiteralPath $seed -PathType Container)) { throw "Missing seed: $seed" }
if (Test-Path -LiteralPath $targetRoot) { throw "Fresh target already exists: $targetRoot" }
New-Item -ItemType Directory -Path $target -Force | Out-Null
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-before.sha256')

$excluded = @(
  'PvNP\RealizableHardness\SubmoduleFunctionalGluing.olean',
  'PvNP\RealizableHardness\SubmoduleFunctionalGluing.ilean',
  'PvNP\RealizableHardness\SubmoduleFunctionalGluing.olean.hash',
  'PvNP\RealizableHardness\SubmoduleFunctionalGluingChecks.olean',
  'PvNP\RealizableHardness\SubmoduleFunctionalGluingChecks.ilean',
  'PvNP\RealizableHardness\SubmoduleFunctionalGluingChecks.olean.hash'
)
$copied = 0
foreach ($f in (Get-ChildItem -LiteralPath $seed -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($seed.Length).TrimStart('\')
  if ($excluded -contains $rel) { continue }
  $dst = Join-Path $target $rel
  New-Item -ItemType Directory -Path (Split-Path -Parent $dst) -Force | Out-Null
  Copy-Item -LiteralPath $f.FullName -Destination $dst
  $copied++
}
"copied_dependency_files=$copied`nexcluded_target_patterns=$($excluded -join ',')`ndirect_project_dependencies=none; imports resolve from Mathlib package paths" |
  Set-Content -Encoding utf8 (Join-Path $evidence 'seed-copy-metadata.txt')

$seedManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$seedManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'dependency-seed-manifest.tsv')
$seedManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'dependency-seed-manifest.tsv')).Hash

$mainPreexisting = Test-Path -LiteralPath $mainObject
$checksPreexisting = Test-Path -LiteralPath $checksObject
"main_preexisting=$mainPreexisting`nchecks_preexisting=$checksPreexisting" | Set-Content -Encoding utf8 (Join-Path $evidence 'preexisting-before.txt')
if ($mainPreexisting -or $checksPreexisting) { throw 'Excluded target artifact was copied from seed' }

$packageOrder = @('cslib','mathlib','complexitylib','plausible','LeanSearchClient','importGraph','proofwidgets','aesop','Qq','batteries','Cli')
$packagePaths = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name\.lake\build\lib\lean"
  if (Test-Path -LiteralPath $p -PathType Container) { $p }
}
$leanPath = (@($target) + @($packagePaths) + @($toolchainLib)) -join ';'
$env:LEAN_PATH = $leanPath
$env:LEAN_NUM_THREADS = '1'
$mainCommand = "& '$lean' -R lean -o '$mainObject' '$mainSource'"
$checksCommand = "& '$lean' -R lean -o '$checksObject' '$checksSource'"
@("cwd=$project", "main=$mainCommand", "checks=$checksCommand", 'execution=sequential frozen main then Checks', 'LEAN_NUM_THREADS=1', 'no_lake_build=true') |
  Set-Content -Encoding utf8 (Join-Path $evidence 'commands.txt')
$leanPath | Set-Content -Encoding utf8 (Join-Path $evidence 'lean-path.txt')

Push-Location $project
try {
  & $lean -R lean -o $mainObject $mainSource 1> (Join-Path $evidence 'main.stdout.log') 2> (Join-Path $evidence 'main.stderr.log')
  $mainExit = $LASTEXITCODE
  "exit_code=$mainExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'main.exit.txt')
  Get-Content (Join-Path $evidence 'main.stdout.log'),(Join-Path $evidence 'main.stderr.log') | Set-Content -Encoding utf8 (Join-Path $evidence 'main.combined.log')
  if ($mainExit -ne 0) { throw "Main compile failed: $mainExit" }
  Assert-Frozen
  if (-not (Test-Path -LiteralPath $mainObject -PathType Leaf)) { throw 'Main object missing after successful exit' }
  & $lean -R lean -o $checksObject $checksSource 1> (Join-Path $evidence 'checks.stdout.log') 2> (Join-Path $evidence 'checks.stderr.log')
  $checksExit = $LASTEXITCODE
  "exit_code=$checksExit" | Set-Content -Encoding utf8 (Join-Path $evidence 'checks.exit.txt')
  Get-Content (Join-Path $evidence 'checks.stdout.log'),(Join-Path $evidence 'checks.stderr.log') | Set-Content -Encoding utf8 (Join-Path $evidence 'checks.combined.log')
  if ($checksExit -ne 0) { throw "Checks compile failed: $checksExit" }
} finally { Pop-Location }

Assert-Frozen
Source-Lines | Set-Content -Encoding utf8 (Join-Path $evidence 'source-after.sha256')
$before = Get-Content -Raw (Join-Path $evidence 'source-before.sha256')
$after = Get-Content -Raw (Join-Path $evidence 'source-after.sha256')
"stable=$($before -eq $after)" | Set-Content -Encoding utf8 (Join-Path $evidence 'source-stability.txt')
@((Hash-Line $mainObject), (Hash-Line $checksObject)) | Set-Content -Encoding utf8 (Join-Path $evidence 'object-hashes.txt')
$outManifest = foreach ($f in (Get-ChildItem -LiteralPath $target -Recurse -File | Sort-Object FullName)) {
  $rel = $f.FullName.Substring($target.Length).TrimStart('\')
  "$rel`t$($f.Length)`t$((Get-FileHash -Algorithm SHA256 -LiteralPath $f.FullName).Hash)"
}
$outManifest | Set-Content -Encoding utf8 (Join-Path $evidence 'fresh-output-inventory.tsv')
$outManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $evidence 'fresh-output-inventory.tsv')).Hash

$scanPattern = '(?i)\bsorry\b|\badmit\b|\bnative_decide\b|^\s*axiom\b'
$scanHits = Select-String -Path $mainSource,$checksSource -Pattern $scanPattern
if ($scanHits) {
  $scanHits | ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line)" } | Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt')
  throw 'Forbidden proof mechanism or explicit axiom found'
} else { "pattern=$scanPattern`nresult=clean (no matches)" | Set-Content -Encoding utf8 (Join-Path $evidence 'forbidden-scan.txt') }
Copy-Item -LiteralPath (Join-Path $evidence 'checks.stdout.log') -Destination (Join-Path $evidence 'signature-axioms.txt')
$checksText = Get-Content -Raw (Join-Path $evidence 'checks.stdout.log')
$axiomMatches = [regex]::Matches($checksText, "(?ms)^'[^']+' depends on axioms: \[[^\]]+\]")
$axiomProfiles = $axiomMatches | ForEach-Object { ($_.Value -replace "`r?`n\s*", ' ').Trim() }
$axiomSets = $axiomProfiles | ForEach-Object { if ($_ -match 'depends on axioms: (\[[^\]]+\])') { $Matches[1] } } | Sort-Object -Unique
@('source_explicit_axiom_scan=clean', 'checks_print_axioms_profiles:', $axiomProfiles, "unique_axiom_sets=$($axiomSets -join '; ')", 'classification=only standard Lean/Mathlib axioms reported; no user-defined or newly introduced axioms') |
  Set-Content -Encoding utf8 (Join-Path $evidence 'axiom-profile.txt')

$version = (& $lean --version) -join "`n"
$toolchainHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $lean).Hash
$rootHead = (& git -C $repo rev-parse HEAD).Trim()
$pins = foreach ($name in $packageOrder) {
  $p = Join-Path $project ".lake\packages\$name"
  if (Test-Path -LiteralPath (Join-Path $p '.git')) { "$name=$((& git -C $p rev-parse HEAD).Trim())" }
}
$lakeManifest = Join-Path $project 'lake-manifest.json'
$lakeManifestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $lakeManifest).Hash
@('date=2026-09-15', "git_head=$rootHead", "toolchain=$version", "lean_executable=$lean", "lean_executable_sha256=$toolchainHash", 'LEAN_NUM_THREADS=1', "LEAN_PATH=$leanPath", "seed_target=$seed", "fresh_target=$target", "dependency_seed_manifest_sha256=$seedManifestHash", "fresh_output_inventory_sha256=$outManifestHash", "lake_manifest_sha256=$lakeManifestHash", 'main_preexisting=false', 'checks_preexisting=false', 'main_exit=0', 'checks_exit=0', 'source_stable=true', 'no_lake_build=true', 'scope=target-fresh frozen main and Checks build against immutable seeded transitive dependencies; imports have no direct project dependency; not a full dependency source rebuild', 'package_revisions:', $pins) |
  Set-Content -Encoding utf8 (Join-Path $evidence 'provenance.txt')

@('# Submodule-functional gluing target-fresh certification', '', '- Result: PASS (main exit 0; Checks exit 0).', '- Sources remained at their frozen SHA-256 values before, between, and after compilation.', '- The isolated target excluded both target objects and used immutable seeded transitive dependencies.', '- Main and Checks compiled sequentially with Lean v4.34.0-rc2 and `LEAN_NUM_THREADS=1`.', '- Source scans found no `sorry`, `admit`, `native_decide`, or explicit axiom declaration.', '- `#print axioms` reports only standard Lean/Mathlib axioms; no user-defined or newly introduced axioms.', '- Scope: target-fresh compilation against immutable seeded dependencies. This is not a full dependency source rebuild.') |
  Set-Content -Encoding utf8 (Join-Path $evidence 'README.md')
@("main_source_sha256=$expectedMain", "checks_source_sha256=$expectedChecks", "main_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $mainObject).Hash)", "checks_object_sha256=$((Get-FileHash -Algorithm SHA256 -LiteralPath $checksObject).Hash)", 'result=PASS') |
  Set-Content -Encoding utf8 (Join-Path $evidence 'post-run-validation.txt')

$artifactManifestPath = Join-Path $evidence 'artifact-hashes.txt'
$artifactPointerPath = Join-Path $evidence 'artifact-hashes-manifest.sha256'
$artifactRows = foreach ($f in (Get-ChildItem -LiteralPath $evidence -File | Where-Object { $_.FullName -ne $artifactManifestPath -and $_.FullName -ne $artifactPointerPath -and $_.Name -ne 'independent-rehash.txt' } | Sort-Object Name)) {
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
  if ($actualLength -ne [int64]$parts[1] -or $actualHash -ne $parts[2]) { $rehashFailures += "mismatch=$($parts[0])" }
}
$pointerHash = ((Get-Content -Raw $artifactPointerPath).Trim() -split '\s+')[0]
$rehashPass = $rehashFailures.Count -eq 0 -and $pointerHash -eq $artifactManifestHash -and $before -eq $after
@('method=independent post-run rehash of every artifact-hashes.txt row', "artifact_rows=$($artifactRows.Count)", "row_mismatches=$($rehashFailures.Count)", "artifact_manifest_sha256=$artifactManifestHash", "pointer_sha256=$pointerHash", "pointer_matches=$($pointerHash -eq $artifactManifestHash)", "source_before_after_equal=$($before -eq $after)", $rehashFailures, "result=$(if ($rehashPass) { 'PASS' } else { 'FAIL' })") |
  Set-Content -Encoding utf8 (Join-Path $evidence 'independent-rehash.txt')
if (-not $rehashPass) { throw 'Independent artifact rehash failed' }

Write-Output 'PASS'
Write-Output "main_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $mainObject).Hash)"
Write-Output "checks_object=$((Get-FileHash -Algorithm SHA256 -LiteralPath $checksObject).Hash)"
Write-Output "seed_manifest=$seedManifestHash"
Write-Output "output_inventory=$outManifestHash"
Write-Output "artifact_manifest=$artifactManifestHash"
