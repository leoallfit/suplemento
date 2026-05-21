param([string]$Message)

Set-Location $PSScriptRoot

if (-not $Message) {
  $Message = "Update $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}

git add -A
$staged = git diff --cached --name-only
if (-not $staged) {
  Write-Host "No hay cambios para subir." -ForegroundColor Yellow
  exit 0
}

Write-Host "Subiendo: $Message" -ForegroundColor Cyan
git commit -m $Message
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
git push origin main
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Listo. La web se actualiza en 1-2 minutos en:" -ForegroundColor Green
Write-Host "  https://leoallfit.github.io/suplemento/" -ForegroundColor Green
