# scripts/setup_db.ps1
# Script para inicializar la base de datos de Plasmic en Windows (PostgreSQL)

Write-Host "🐘 Configurando Base de Datos PostgreSQL para Plasmic..." -ForegroundColor Cyan

# Comprobar si psql está en el path
if (-not (Get-Command "psql" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Error: 'psql' no encontrado." -ForegroundColor Red
    Write-Host "Por favor, asegúrate de haber instalado PostgreSQL y agregado la carpeta 'bin' a tu PATH."
    Write-Host "Si usas la versión Portable, ejecuta este script desde la consola donde configuraste el entorno."
    exit 1
}

$PGPASSWORD_SUPER = Read-Host "Ingresa tu contraseña de superusuario (usuario 'postgres')"
$ENV:PGPASSWORD = $PGPASSWORD_SUPER

# Definir contraseña para los servicios de Plasmic
$PLASMIC_DB_PASS = "SEKRET"

Write-Host "⏳ Creando usuarios y bases de datos..."

# Función helper para ejecutar SQL
function Run-SQL {
    param($sql)
    psql -U postgres -c $sql
}

try {
    # 1. Crear usuarios (ignorando error si ya existen)
    Run-SQL "CREATE USER wab WITH PASSWORD '$PLASMIC_DB_PASS';" 2>$null
    Run-SQL "CREATE USER cypress WITH PASSWORD '$PLASMIC_DB_PASS';" 2>$null
    Run-SQL "CREATE USER superwab WITH PASSWORD '$PLASMIC_DB_PASS' CREATEDB CREATEROLE IN GROUP wab;" 2>$null
    Run-SQL "CREATE USER supertdbwab WITH PASSWORD '$PLASMIC_DB_PASS' CREATEDB CREATEROLE IN GROUP wab;" 2>$null

    # 2. Crear Base de Datos
    Run-SQL "CREATE DATABASE wab OWNER wab;" 2>$null

    # 3. Instalar extensión UUID (requiere superuser en la DB wab)
    # Nos conectamos a la db 'wab' para instalar la extensión
    $ENV:PGPASSWORD = $PGPASSWORD_SUPER
    psql -U postgres -d wab -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

    Write-Host "✅ Base de datos 'wab' configurada exitosamente." -ForegroundColor Green
} catch {
    Write-Host "⚠️ Ocurrió un error (tal vez ya existían los usuarios?): $($_.Exception.Message)" -ForegroundColor Yellow
}
