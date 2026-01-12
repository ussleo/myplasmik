<!-- AUTO-GENERATED-CONTENT:START (STARTER) -->
<p align="center">
  <img alt="myPlasmik" role="img" src="https://static1.plasmic.app/brand/2023/logo-cropped.png" width="120">
</p>
<h1 align="center">
  myPlasmik by Gemini
</h1>
<h3 align="center">
  The 100% Local Visual Builder for Single-Dev Workflows.
</h3>
<p align="center">
  A specialized fork of Plasmic Studio optimized to run fully offline on your machine.
</p>
<p align="center">
  No cloud dependencies. No mandatory collaboration features. Just you, your code, and your design.
</p>

<p align="center">
  <a href="docs/local-setup/INDEX.md"><img alt="Status" src="https://img.shields.io/badge/status-stable--v1.1-green" /></a>
  <a href="LICENSE.md"><img alt="License" src="https://img.shields.io/github/license/plasmicapp/plasmic" /></a>
  <a href="docs/local-setup/USAGE_GUIDE.md"><img alt="Docs" src="https://img.shields.io/badge/docs-local--setup-blue" /></a>
</p>

## 🎯 Executive Summary

**myPlasmik** is a configuration of Plasmic (visual builder open-source) that works completely on your local machine without depending on Plasmic cloud services.

### Why myPlasmik Local?

✅ **Total Control**: Your code and data reside 100% on your machine (PostgreSQL).
✅ **No Cloud Limits**: Freedom from quotas or subscription tiers.
✅ **Offline Development**: Work without an internet connection.
✅ **Git Versioning**: Full control over versioning via file system dumps and JSON exports.
✅ **Privacy**: Your designs never leave your infrastructure.

### Viability: 95-98%

**What works 100% Locally:**
- **Visual Editor**: Full drag & drop, styles, variants.
- **Codegen**: Generates React/TypeScript code locally.
- **Integration**: Works with Next.js, React, custom code components.
- **Data**: All projects stored in local PostgreSQL.

**What is NOT included (and not needed for single-dev):**
- Real-time collaboration (multiplayer).
- Cloud Image CDN (local file storage is used).
- Automated Cloud Deploys (you use Git & your own CI/CD).

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 15+
- Yarn
- Git

### Installation

This project comes with automated setup scripts for Windows (PowerShell).

1.  **Install Dependencies:**
    ```powershell
    .\plasmic-local-setup\scripts\install_dependencies.ps1
    ```

2.  **Setup Database:**
    ```powershell
    .\plasmic-local-setup\scripts\setup_db.ps1
    ```

3.  **Generate Artifacts (Critical):**
    ```powershell
    .\plasmic-local-setup\scripts\generate_artifacts.ps1
    ```

4.  **Start Services:**
    ```powershell
    .\plasmic-local-setup\scripts\start_plasmic.ps1
    ```
    *Or use PM2 for background execution:*
    ```bash
    pm2 start ecosystem.config.js
    ```

### Access
- **Studio UI:** http://localhost:3003
- **API Backend:** http://localhost:3004
- **Host Server:** http://localhost:3005

## 📚 Documentation

Detailed documentation for this local fork can be found in `docs/local-setup/`:

- **[🏠 Start Here](docs/local-setup/GETTING_STARTED.md)**
- **[🔧 Troubleshooting](docs/local-setup/TROUBLESHOOTING.md)** - **READ THIS if you see a White Screen.**
- **[🏗 Architecture](docs/local-setup/ARCHITECTURE.md)** - How the local stack works.
- **[📋 Executive Summary](docs/local-setup/EXECUTIVE_SUMMARY.md)** - High-level overview.
- **[❓ FAQ](docs/local-setup/FAQ.md)** - Common questions and answers.

## 📁 Repository Structure

```
myPlasmik/
├── platform/
│   └── wab/                    # 🎨 Plasmic Studio (visual editor)
├── plasmic-local-setup/        # 🛠️ Custom scripts & tools for local setup
│   └── scripts/                # PowerShell scripts for Windows
├── docs/
│   └── local-setup/            # 📚 Detailed local documentation
├── ecosystem.config.js         # 🚀 PM2 configuration
└── ...
```

## Contributing

This is a specialized fork for local development. Contributions are welcome, especially those that improve the offline experience or Windows compatibility.

## License

Based on Plasmic OSS.
- Content outside `platform/`: MIT License.
- `platform/`: AGPL License.