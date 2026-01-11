# scripts/run_frontend.ps1
Write-Host "🎨 Iniciando Frontend..." -ForegroundColor Magenta

$WabDir = "..\..\platform\wab"
if (-not (Test-Path $WabDir)) {
    Write-Host "Error: No encuentro $WabDir" -ForegroundColor Red
    exit
}
Set-Location $WabDir

# Configurar Variables de Entorno
$env:PORT = "3003"
$env:react_app_socket_host = "http://localhost:3004"
$env:PLASMIC_HOST = "http://localhost:3004"
$env:DATABASE_URI = "postgres://wab:SEKRET@localhost:5432/wab"
$env:WAB_DBNAME = "wab"
$env:WAB_DBPASSWORD = "SEKRET"
$env:NODE_ENV = "development"
$env:PLASMIC_MULTIPLAYER = "false"
$env:PLASMIC_IMG_OPTIMIZATION = "false"
$env:REACT_APP_DEFAULT_HOST_URL = "http://localhost:3005/static/host.html"
$env:REACT_APP_PUBLIC_URL = "http://localhost:3003"
$env:PUBLIC_URL = "http://localhost:3003"
$env:NODE_OPTIONS = "--max-old-space-size=16384"

# Ejecutar Yarn
yarn rsbuild dev
