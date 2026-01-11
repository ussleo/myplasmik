# Plasmic Local Project Context

## Project Overview
This directory contains a clone of the [Plasmic](https://github.com/plasmicapp/plasmic) repository, a visual builder for the web. The primary objective of this specific workspace is to establish a **100% local, offline-capable version of Plasmic Studio** for a single developer, removing dependencies on `plasmic.app` cloud services (codegen, auth, assets).

## Architecture
The project is a **monorepo** managed with Lerna and Yarn Workspaces.
- **`platform/wab/`**: The core "Studio" application (Web App Builder). Contains the React frontend and Node.js backend.
- **`packages/`**: Contains SDKs and loaders (e.g., `loader-nextjs`, `loader-react`, `loader-fetcher`).
- **`plasmicpkgs/`**: Reusable code components.
- **`docker-compose.yml`**: Configured to run the Studio (`wab`) and a local PostgreSQL database (`plasmic-db`).

## Local Setup Status (Custom)
A custom local setup has been initialized to support offline development.

### Key Modifications
1.  **Codegen Host Patch:** `packages/loader-fetcher/src/api.ts` has been patched to allow `PLASMIC_HOST` env var override, defaulting to `http://localhost:3004` instead of `codegen.plasmic.app`.
2.  **Environment Config:** A `.env` file has been created in `platform/wab/.env` pointing to the local PostgreSQL instance.
3.  **Setup Scripts:** Helper scripts are located in `plasmic-local-setup/`.

## Building and Running

### Docker (Recommended)
To start the full stack (Database + Studio):
```bash
docker-compose up
```
*   **Studio URL:** `http://localhost:3003`
*   **API URL:** `http://localhost:3004`
*   **DB Port:** `5432`

### Manual Setup (Dependencies)
To install dependencies for the monorepo:
```bash
yarn install
yarn build
```

### Database
- **User:** `wab` (or `postgres` in some contexts)
- **Password:** `SEKRET`
- **DB Name:** `wab`

## Key Files for This Context
- **`plasmic-local-setup/README.md`**: Detailed guide on the specific offline modifications made in this workspace.
- **`platform/wab/package.json`**: Scripts for the main Studio app.
- **`packages/loader-fetcher/src/api.ts`**: Contains the critical patch for local codegen.

## Development Conventions
- **Authentication:** Local `passport-local` strategy is enabled. Default credentials should be established via `yarn seed` or manually in the DB.
- **Asset Handling:** Cloud asset dependencies (icons, image optimizer) are currently bypassed or fail gracefully; local SVG replacements are recommended for a cleaner UI.
- **Version Control:** Git is used for versioning the project state; the cloud "History" feature is not utilized.
