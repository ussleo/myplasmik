# myPlasmik Project Context

## Project Overview
**myPlasmik** is a specialized fork of the Plasmic Studio (`plasmicapp/plasmic`), optimized to run **100% locally on Windows** without Docker, cloud dependencies, or internet access. It is designed for a single-developer workflow, replacing cloud services with local equivalents or bypassing them entirely.

## Architecture
The project is a monorepo managed by Yarn Workspaces and Lerna.

*   **Frontend (`platform/wab/src/wab/client`)**: The visual editor UI.
    *   **Port**: `3003`
    *   **Tech**: React, MobX, Ant Design.
    *   **Build Tool**: `rsbuild` (Webpack successor).
*   **Backend (`platform/wab/src/wab/server`)**: The API and persistence layer.
    *   **Port**: `3004`
    *   **Tech**: Node.js, Express, TypeORM, PostgreSQL.
    *   **Role**: Handles authentication, project storage, and local code generation.
*   **Database**: PostgreSQL.
    *   **User**: `wab`
    *   **DB**: `wab`
    *   **Port**: `5432`
*   **Codegen**: The mechanism that syncs visual designs to code.
    *   **Original**: `codegen.plasmic.app`
    *   **Modified**: `localhost:3004` (Patched in `packages/loader-fetcher`).

## 🛠️ Local Windows Development Workflow

This project includes a custom suite of PowerShell scripts in `plasmic-local-setup/scripts/` to handle the complex build process on Windows natively, bypassing the original Bash scripts.

### 1. Prerequisites
*   Node.js (v18+)
*   PostgreSQL (Running locally)
*   Yarn (`npm install -g yarn`)
*   PowerShell (Run as Administrator for setup)

### 2. Setup Scripts (Run in Order)
Located in `plasmic-local-setup/scripts/`:

1.  **`install_dependencies.ps1`**: Runs `yarn install` in the critical `platform/wab` workspace.
2.  **`setup_db.ps1`**: Creates the `wab` user and database in your local PostgreSQL instance.
3.  **`generate_artifacts.ps1`**: **CRITICAL**. Compiles PEG.js parsers (CoffeeScript/JS), generates database models (`gen-models.ts`), and builds styling tokens. *Note: Includes a custom manual compilation step for `.pegcoffee` files.*
4.  **`fix_styles.ps1`**: Generates missing SASS variables (e.g., `$selectionControlsColor`) and empty placeholder files (`.txt`) required by the frontend build.

### 3. Running the Application

#### Option A: Interactive Mode (Debug)
```powershell
.\plasmic-local-setup\scripts\start_plasmic.ps1
```
Launches two separate PowerShell windows (Backend & Frontend) to view logs in real-time. Use this for development.

#### Option B: Silent Mode (PM2)
```bash
pm2 start ecosystem.config.js
pm2 logs
```
Runs the stack in the background using Process Manager 2.

## 🔑 Authentication
*   **Login URL**: `http://localhost:3003`
*   **Credentials**:
    *   Email: `user@example.com`
    *   Password: `!53kr3tz!`
*   **Auth Method**: `passport-local` (Email/Password). Google Auth is present but disabled/unconfigured for local use.

## 🧪 Key Modifications & Patches

### Core Logic
*   **Codegen Host**: `packages/loader-fetcher/src/api.ts` patched to default to `process.env.PLASMIC_HOST` or `localhost:3004`.
*   **Parser Compilation**: Custom logic in `generate_artifacts.ps1` to compile `.pegcoffee` grammars without the original broken build chain.

### Branding
*   **UI**: `platform/wab/src/wab/client/components/pages/IntakeFlowForm.tsx` modified to display "myPlasmik by Gemini" on the login screen.

### Configuration
*   **Env Vars**: `platform/wab/.env` configured for local Postgres (`postgres://wab:SEKRET@localhost:5432/wab`).
*   **Dev Flags**: `PLASMIC_IMG_OPTIMIZATION=false` and `PLASMIC_MULTIPLAYER=false` to remove cloud dependencies.

## ⚠️ Known Issues / Troubleshooting
*   **SASS Errors**: If build fails with `Undefined variable`, run `fix_styles.ps1` again.
*   **Missing Modules**: If `Cannot find module '@/wab/gen/...'`, run `generate_artifacts.ps1`.
*   **Bash Errors**: Never run `yarn start` or `yarn backend` directly on Windows; they call `bash` scripts. Always use the PowerShell wrappers or `pm2`.
