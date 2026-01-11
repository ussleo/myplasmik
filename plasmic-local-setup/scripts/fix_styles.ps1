# scripts/fix_styles.ps1
# Script para reparar los problemas de estilos SASS y archivos faltantes (Versión 2.0)

Write-Host "🎨 Reparando Estilos y Assets (Definitivo)..." -ForegroundColor Cyan

$WabDir = "..\..\platform\wab"
if (-not (Test-Path $WabDir)) {
    Write-Host "Error: No encuentro $WabDir" -ForegroundColor Red
    exit
}
Set-Location $WabDir

# 1. Asegurar directorio de destino para estilos estáticos
$StaticStylesDir = "src/wab/gen/static/styles"
if (-not (Test-Path $StaticStylesDir)) {
    New-Item -ItemType Directory -Force -Path $StaticStylesDir | Out-Null
    Write-Host "📂 Directorio creado: $StaticStylesDir"
}

# 2. Crear archivos .txt faltantes (usados por raw-loader)
$MissingFiles = @(
    "react-web-css.txt",
    "tinymce-content-css.txt",
    "prismjs-css.txt"
)

foreach ($file in $MissingFiles) {
    $path = "$StaticStylesDir\$file"
    if (-not (Test-Path $path)) {
        Write-Host "➕ Creando dummy: $file"
        Set-Content -Path $path -Value "/* CSS Placeholder para $file */"
    }
}

# 3. Arreglar css-variables.scss
# Basado en los errores encontrados y css-variables.json
$StylesDir = "src/wab/styles"
$CssVariablesFile = "$StylesDir\css-variables.scss"

Write-Host "🔨 Generando css-variables.scss con valores por defecto..."

# Contenido que define las variables que faltan para que SASS compile
$Content = @"
// Variables generadas automáticamente para reparación local
@import 'tokens';

// Variables requeridas por la UI del Studio
`$selectionControlsColor: #1890ff;
`$gridSpacing: 8px;
`$inverseZoom: 1;
`$hoverBoxTagHeight: 25px;
`$node-outline-color: `$selectionControlsColor;

// Otras variables comunes que podrían faltar
`$bg-color: #ffffff;
`$text-color: #333333;
"@

Set-Content -Path $CssVariablesFile -Value $Content
Write-Host "✅ css-variables.scss regenerado con variables críticas."

# Verificar archivos generados
Write-Host "🔍 Estado de estilos:"
Get-ChildItem $StylesDir -File | Select-Object Name
Get-ChildItem $StaticStylesDir -File | Select-Object Name

Write-Host "🎉 Reparación completada. Intenta arrancar de nuevo."