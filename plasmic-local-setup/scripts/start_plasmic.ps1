# scripts/start_plasmic.ps1
# Orquestador simplificado

Write-Host "🚀 Iniciando Plasmic Studio (Local Mode)..." -ForegroundColor Cyan

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Lanzar Backend
Write-Host "🔥 Lanzando ventana del Backend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-File", "$ScriptDir\run_backend.ps1"

Write-Host "⏳ Esperando 10 segundos..."
Start-Sleep -Seconds 10

# Lanzar Frontend
Write-Host "🔥 Lanzando ventana del Frontend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-File", "$ScriptDir\run_frontend.ps1"

Write-Host "🎉 Ventanas lanzadas."