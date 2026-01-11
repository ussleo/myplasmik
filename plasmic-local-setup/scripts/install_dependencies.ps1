# scripts/install_dependencies.ps1
Write-Host "📦 Instalando dependencias de Plasmic WAB..." -ForegroundColor Cyan

$WabDir = "..\..\platform\wab"
if (-not (Test-Path $WabDir)) {
    Write-Host "Error: No encuentro $WabDir" -ForegroundColor Red
    exit
}
Set-Location $WabDir

Write-Host "📂 Directorio actual: $PWD"

# Verificar si yarn está disponible
if (-not (Get-Command "yarn" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Error: 'yarn' no encontrado. Instálalo con 'npm install -g yarn'" -ForegroundColor Red
    exit
}

Write-Host "⏳ Ejecutando 'yarn install' (esto puede tardar unos minutos)..."
yarn install

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Dependencias instaladas correctamente." -ForegroundColor Green
} else {
    Write-Host "❌ Hubo un error al instalar las dependencias." -ForegroundColor Red
}

Write-Host "Presiona Enter para salir..."
Read-Host
