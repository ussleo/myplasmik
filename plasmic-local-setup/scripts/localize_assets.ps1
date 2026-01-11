# localize_assets.ps1
# Script para localizar assets remotos de Plasmic y crear una base de datos local.

$SourceDir = "..\platform\wab\src\wab"
$PublicDir = "..\platform\wab\public"
$LocalAssetsDir = "$PublicDir\local-assets"
$BaseRemoteUrl = "https://static1.plasmic.app"

Write-Host "🚀 Iniciando Protocolo de Independencia de Assets..." -ForegroundColor Cyan

# 1. Crear directorio local si no existe
if (-not (Test-Path $LocalAssetsDir)) {
    New-Item -ItemType Directory -Force -Path $LocalAssetsDir | Out-Null
    Write-Host "📂 Directorio creado: $LocalAssetsDir" -ForegroundColor Green
}

# 2. Buscar archivos que contienen referencias a static1.plasmic.app
$files = Get-ChildItem -Path $SourceDir -Recurse -File | Select-String -Pattern "https://static1.plasmic.app/[a-zA-Z0-9/_.-]+" -AllMatches

$uniqueUrls = @{}
$fileReplacements = @{}

# 3. Analizar y Descargar Assets
foreach ($match in $files) {
    foreach ($m in $match.Matches) {
        $url = $m.Value
        if (-not $uniqueUrls.ContainsKey($url)) {
            $uniqueUrls[$url] = $true
            
            # Determinar ruta relativa y nombre de archivo
            $relativePath = $url.Replace($BaseRemoteUrl, "")
            # Limpiar query strings si existen
            if ($relativePath.Contains("?")) {
                $relativePath = $relativePath.Split("?")[0]
            }
            
            $localFilePath = "$LocalAssetsDir$relativePath"
            $localDir = Split-Path $localFilePath
            
            if (-not (Test-Path $localDir)) {
                New-Item -ItemType Directory -Force -Path $localDir | Out-Null
            }

            Write-Host "⬇️  Descargando: $relativePath" -NoNewline
            try {
                Invoke-WebRequest -Uri $url -OutFile $localFilePath
                Write-Host " [OK]" -ForegroundColor Green
            } catch {
                Write-Host " [ERROR]" -ForegroundColor Red
                Write-Host "    $($_.Exception.Message)" -ForegroundColor Gray
            }
        }
    }
}

Write-Host "`n✅ Descarga completada. Iniciando reescritura de código..." -ForegroundColor Cyan

# 4. Reemplazar referencias en el código
# Estrategia: Reemplazar 'https://static1.plasmic.app' por '/local-assets'
# Esto asume que 'platform/wab/public' es servido como root o assets estáticos.

$allSourceFiles = Get-ChildItem -Path $SourceDir -Recurse -File -Include "*.ts", "*.tsx", "*.js", "*.jsx"

foreach ($file in $allSourceFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match "https://static1.plasmic.app") {
        # Reemplazo seguro
        $newContent = $content -replace "https://static1.plasmic.app", "/local-assets"
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "📝 Actualizado: $($file.Name)" -ForegroundColor Yellow
    }
}

Write-Host "`n🎉 Protocolo finalizado. Tus assets son ahora 100% locales." -ForegroundColor Green
