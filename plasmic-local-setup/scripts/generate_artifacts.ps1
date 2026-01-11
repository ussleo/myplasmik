# scripts/generate_artifacts.ps1
# Script para generar artefactos críticos (código, parsers, estilos) 
# VERSIÓN NATIVA WINDOWS (Con Compilación Manual de Parsers)

Write-Host "⚙️  Generando Artefactos de Plasmic (Modo Nativo Potenciado)..." -ForegroundColor Cyan

$WabDir = "..\..\platform\wab"
if (-not (Test-Path $WabDir)) {
    Write-Host "Error: No encuentro $WabDir" -ForegroundColor Red
    exit
}
Set-Location $WabDir

# Configurar entorno
$env:NODE_OPTIONS = "--max-old-space-size=8192"
$env:NQ_SQLJS = "1" 

# Función helper para ejecutar scripts TS
function Run-TS($ScriptPath, $ArgsList = @()) {
    Write-Host "🔨 Ejecutando: $ScriptPath..." -NoNewline
    $NodeArgs = @("-r", "esbuild-register", "-r", "dotenv/config", $ScriptPath) + $ArgsList
    
    try {
        $process = Start-Process node -ArgumentList $NodeArgs -PassThru -NoNewWindow -Wait
        if ($process.ExitCode -eq 0) {
            Write-Host " [OK]" -ForegroundColor Green
        } else {
            Write-Host " [ERROR ($($process.ExitCode))]" -ForegroundColor Red
        }
    } catch {
        Write-Host " [FALLÓ]" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

# Función para compilar PEG.js
function Compile-Peg($Input, $OutputName) {
    Write-Host "🔨 Compilando Parser: $Input..." -NoNewline
    # La ruta al binario pegjs
    $PegJsBin = "node_modules\.bin\pegjs.cmd" 
    
    # Plugin de CoffeeScript necesario
    $Plugin = "--plugin pegjs-coffee-plugin"
    
    # Argumentos: --output src/wab/gen/Nombre.js --format commonjs src/wab/Nombre.pegcoffee
    $OutPath = "src/wab/gen/$OutputName.js"
    
    if (-not (Test-Path $PegJsBin)) {
        Write-Host " [ERROR: pegjs no encontrado en $PegJsBin]" -ForegroundColor Red
        return
    }

    try {
        # Ejecutamos pegjs
        $process = Start-Process $PegJsBin -ArgumentList "$Plugin --format commonjs --output $OutPath $Input" -PassThru -NoNewWindow -Wait
        if ($process.ExitCode -eq 0) {
            Write-Host " [OK]" -ForegroundColor Green
        } else {
            Write-Host " [ERROR]" -ForegroundColor Red
        }
    } catch {
        Write-Host " [FALLÓ: $($_.Exception.Message)]" -ForegroundColor Red
    }
}

# 0. Crear directorio gen si no existe
if (-not (Test-Path "src/wab/gen")) {
    New-Item -ItemType Directory -Path "src/wab/gen" | Out-Null
}

# 1. COMPILAR PARSERS (Paso Crítico Faltante)
# Estos archivos son requeridos por los generadores siguientes
Compile-Peg "src/wab/modelPegParser.pegcoffee" "modelPegParser"
Compile-Peg "src/wab/cssPegParser.pegcoffee" "cssPegParser"
Compile-Peg "src/wab/funcTplParser.pegcoffee" "funcTplParser"
Compile-Peg "src/wab/GridStyleParser.pegjs" "GridStyleParser" # Este es pegjs puro, quizás sin plugin

# 2. Generar Modelos (Ahora debería funcionar)
Run-TS "tools/gen-models.ts"

# 3. Generar Meta Componentes
Run-TS "tools/gen-react-meta.ts"

# 4. Generar Tokens de Diseño (SASS)
Run-TS "tools/gen-theo.ts" @("src/wab/styles/plasmic-tokens.theo.json", "src/wab/styles/_tokens.sass")

# 5. Generar Tokens de Diseño (TS)
Run-TS "tools/gen-theo.ts" @("src/wab/styles/plasmic-tokens.theo.json", "src/wab/styles/_tokens.ts")

Write-Host "🔍 Verificando carpeta 'gen'..."
Get-ChildItem src/wab/gen -Recurse | Select-Object Name

Write-Host "✅ Generación finalizada. Intenta arrancar los servidores de nuevo."
