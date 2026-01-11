# PowerShell Setup Script for Local Plasmic

Write-Host "🚀 Starting Plasmic Local Setup..."

# 1. Modify packages/loader-fetcher/src/api.ts
$apiFile = "..\packages\loader-fetcher\src\api.ts"
if (Test-Path $apiFile) {
    $content = Get-Content $apiFile -Raw
    $newContent = $content -replace 'this.host = opts.host \?\? "https://codegen.plasmic.app";', 'this.host = opts.host ?? process.env.PLASMIC_HOST ?? "http://localhost:3004";'
    Set-Content -Path $apiFile -Value $newContent
    Write-Host "✅ Patched api.ts to allow local codegen host."
} else {
    Write-Host "❌ Error: api.ts not found at $apiFile"
}

# 2. Modify platform/wab/src/wab/shared/devflags.ts (Optional but recommended)
$devFlagsFile = "..\platform\wab\src\wab\shared\devflags.ts"
if (Test-Path $devFlagsFile) {
    # This is a bit more complex, we might just want to ensure specific flags are set.
    # For now, we'll leave it as manual or advanced step, or just rely on env vars if possible.
    # Plasmic often loads these from env.
    Write-Host "ℹ️  Remember to check devflags.ts for disabling multiplayer if needed."
}

# 3. Create/Update .env file for platform/wab
$envFile = "..\platform\wab\.env"
$envContent = @"
PORT=3003
react_app_socket_host=http://localhost:3004
PLASMIC_HOST=http://localhost:3004
DATABASE_URI=postgres://postgres:postgres@localhost:5432/plasmic
WAB_DBNAME=plasmic
WAB_DBPASSWORD=postgres
NODE_ENV=development
# Disable features
PLASMIC_MULTIPLAYER=false
"@
Set-Content -Path $envFile -Value $envContent
Write-Host "✅ Created .env configuration for WAB platform."

Write-Host "🎉 Setup scripts generated. Now run 'docker-compose up' in the root directory!"
