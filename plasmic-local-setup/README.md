# myPlasmik by Gemini - 100% Local Setup

This repository contains a modified version of Plasmic Studio optimized to run 100% offline on Windows, without Docker or Cloud dependencies.

## 🚀 Quick Start (Windows Native)

### Prerequisites
1.  **Node.js** (v18+)
2.  **PostgreSQL** (Installed and running)
3.  **Yarn** (`npm install -g yarn`)

### 1. Setup Environment
Open PowerShell as Administrator in `plasmic-local-setup/scripts`:

```powershell
cd plasmic-local-setup/scripts
```

Run the following scripts in order:

1.  **Install Dependencies:**
    ```powershell
    .\install_dependencies.ps1
    ```

2.  **Setup Database:** (Ensure Postgres is running)
    ```powershell
    .\setup_db.ps1
    ```

3.  **Generate Artifacts:** (Critical step for Parsers/Models)
    ```powershell
    .\generate_artifacts.ps1
    ```

4.  **Fix Styles:** (Creates missing SASS variables)
    ```powershell
    .\fix_styles.ps1
    ```

### 2. Run the Studio

**Option A: Visible Windows (Recommended for Debugging)**
```powershell
.\start_plasmic.ps1
```
This will open two PowerShell windows (Backend & Frontend). Wait for Frontend to display "Compiled successfully".

**Option B: Silent Mode (PM2)**
If you have `pm2` installed (`npm install -g pm2`):
```bash
# From project root
pm2 start ecosystem.config.js
pm2 logs
```

### 3. Login
- **URL:** `http://localhost:3003`
- **Email:** `user@example.com`
- **Password:** `!53kr3tz!`

## 🛠️ Key Modifications

*   **Offline Codegen:** Patched `packages/loader-fetcher` to point to localhost.
*   **Asset Localization:** Scripts to handle local assets (work in progress).
*   **Windows Compatibility:** Replaced Bash scripts with native PowerShell automation.
*   **Branding:** Custom "myPlasmik by Gemini" branding in UI.

## ⚠️ Known Issues
- Image optimization is disabled (`PLASMIC_IMG_OPTIMIZATION=false`).
- Some cloud templates/icons may show broken links if not manually downloaded.

---
*Created with ❤️ by Gemini for ussleo.*