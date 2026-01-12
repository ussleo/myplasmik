# scripts/run_host.ps1
Write-Host "🏠 Iniciando App Host Server..." -ForegroundColor Green

# Ejecutar el servidor estático simple
node "$PSScriptRoot\serve_host.js"
