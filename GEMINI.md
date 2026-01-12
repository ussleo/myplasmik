# myPlasmik Project Context

## Project Overview
**myPlasmik** is a specialized fork of the Plasmic Studio (`plasmicapp/plasmic`), optimized to run **100% locally on Windows** without Docker, cloud dependencies, or internet access. It is designed for a single-developer workflow, replacing cloud services with local equivalents or bypassing them entirely.

**Current Status (Jan 11, 2026):** Production Ready (Local V1.0).

## Architecture
The project is a monorepo managed by Yarn Workspaces and Lerna.

*   **Frontend (`platform/wab/src/wab/client`)**: The visual editor UI.
    *   **Port**: `3003`
    *   **Tech**: React, MobX, Ant Design.
    *   **Branding**: Updated to "myPlasmik by Gemini".
*   **Backend (`platform/wab/src/wab/server`)**: The API and persistence layer.
    *   **Port**: `3004`
    *   **Tech**: Node.js, Express, TypeORM, PostgreSQL.
    *   **Persistence**: Automatically saves projects to `projects/` JSON files for Git tracking.
*   **Host Server (`plasmic-local-setup/scripts/serve_host.js`)**:
    *   **Port**: `3005`
    *   **Role**: Serves the `host.html` required for the visual canvas, replacing the cloud dependency (`plasmic.app`).
*   **Database**: PostgreSQL.
    *   **User**: `wab` / **DB**: `wab` / **Port**: `5432`

## 🛠️ Local Windows Development Workflow

### 1. Documentation
Comprehensive documentation is located in `docs/local-setup/`, including:
*   `GETTING_STARTED.md`: Quick start guide.
*   `ARCHITECTURE.md`: Deep technical dive.
*   `USAGE_GUIDE.md`: Daily workflow instructions.

### 2. Setup Scripts (PowerShell)
Located in `plasmic-local-setup/scripts/`:
1.  **`install_dependencies.ps1`**: `yarn install`.
2.  **`setup_db.ps1`**: DB initialization.
3.  **`generate_artifacts.ps1`**: Compiles parsers (`pegjs`/`pegcoffee`) and generates models.
4.  **`start_plasmic.ps1`**: Launches Backend, Frontend, and Host Server interactively.

### 3. Running the Application (PM2 - Recommended)
The project uses PM2 to manage all three services (Frontend, Backend, Host).
```bash
pm2 start ecosystem.config.js
pm2 logs
```

## 🔑 Authentication
*   **Login URL**: `http://localhost:3003`
*   **Credentials**: `user@example.com` / `!53kr3tz!`

## 🧪 Key Modifications & Patches

### Core Logic
*   **Codegen Host**: `packages/loader-fetcher/src/api.ts` patched to point to `localhost:3004`.
*   **Host Server**: Local Node.js server (port 3005) replaces cloud host.
*   **CORS**: `studio-frame.tsx` patched to allow `localhost` origins.

### Branding
*   **UI**: "myPlasmik by Gemini" in Login screen and Top Bar.

### Configuration
*   **Env Vars**: `platform/wab/.env` configured for local Postgres.
*   **Dev Flags**: `PLASMIC_IMG_OPTIMIZATION=false` and `PLASMIC_MULTIPLAYER=false`.

## ⚠️ Known Issues
*   **SASS Errors**: Run `fix_styles.ps1` if styles break.
*   **Bash Scripts**: Avoid `yarn start`; use PowerShell wrappers or PM2.
