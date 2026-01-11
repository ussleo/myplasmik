# 📚 ÍNDICE MAESTRO - PLASMIC LOCAL

## 🎯 Inicio Rápido

### Para Empezar Inmediatamente:

1. **🚀 [EXECUTIVE_SUMMARY.md](./EXECUTIVE_SUMMARY.md)**
   - Resumen ejecutivo completo
   - Viabilidad, requisitos, tiempos
   - **EMPEZAR AQUÍ** 👈

2. **🛠️ [README.md](./README.md)**
   - Guía completa paso a paso
   - Instalación, configuración, verificación
   - Troubleshooting integrado

3. **🤖 [setup-auto.sh](./setup-auto.sh)**
   - Script automático de instalación
   - Aplica todas las modificaciones
   - Configura entorno completo

---

## 📝 Documentación Detallada

### 📖 Guías Principales

#### [README.md](./README.md)
**Guía Master - TODO en un solo lugar**
- ✅ Requisitos previos
- ✅ Instalación base (Docker y Manual)
- ✅ Modificaciones de código (detalladas)
- ✅ Configuración local (.env files)
- ✅ Verificación de setup
- ✅ Workflow de desarrollo
- ✅ Troubleshooting

**Cuándo usar**: Primera instalación, referencia completa

---

#### [docs/USAGE_GUIDE.md](./docs/USAGE_GUIDE.md)
**Guía de Uso Diario**
- ✅ Workflow diario de desarrollo
- ✅ Iniciar/detener servicios
- ✅ Crear proyectos y componentes
- ✅ Exportar/integrar con apps
- ✅ Versionado con Git
- ✅ Mantenimiento rutinario
- ✅ Tips y trucos

**Cuándo usar**: Día a día, referencia rápida

---

#### [docs/INTEGRATION_GUIDE.md](./docs/INTEGRATION_GUIDE.md)
**Guía de Integración con Frameworks**
- ✅ Next.js (App Router y Pages)
- ✅ React (CRA, Vite)
- ✅ Gatsby
- ✅ Registrar code components
- ✅ Data sources y fetching
- ✅ Testing

**Cuándo usar**: Integrar Plasmic con tu aplicación

---

#### [docs/ARCHITECTURE.md](./docs/ARCHITECTURE.md)
**Arquitectura Técnica Profunda**
- ✅ Estructura del repositorio
- ✅ Frontend (React)
- ✅ Backend (Node.js)
- ✅ Base de datos (PostgreSQL)
- ✅ Packages y SDKs
- ✅ Flujos de trabajo
- ✅ Puntos clave para modo local

**Cuándo usar**: Entender cómo funciona, debugging avanzado, customización

---

#### [docs/FAQ.md](./docs/FAQ.md)
**Preguntas Frecuentes**
- ✅ General (qué es, por qué usar)
- ✅ Instalación (requisitos, tiempos)
- ✅ Desarrollo (hot reload, TypeScript)
- ✅ Integración (frameworks, Tailwind)
- ✅ Troubleshooting (errores comunes)
- ✅ Performance (optimizaciones)
- ✅ Versionado (Git, backups)
- ✅ Migración (desde cloud)

**Cuándo usar**: Dudas rápidas, soluciones específicas

---

#### [docs/TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)
**Solución de Problemas**
- ✅ Problemas de base de datos
- ✅ Errores de compilación
- ✅ Problemas de red/CORS
- ✅ Docker issues
- ✅ Performance issues
- ✅ Logs y debugging
- ✅ Comandos útiles

**Cuándo usar**: Cuando algo no funciona

---

#### [EXECUTIVE_SUMMARY.md](./EXECUTIVE_SUMMARY.md)
**Resumen Ejecutivo**
- ✅ Concepto y viabilidad
- ✅ Requisitos y tiempos
- ✅ Quick start
- ✅ Arquitectura visual
- ✅ Ventajas vs cloud
- ✅ Casos de uso
- ✅ Conclusiones

**Cuándo usar**: Overview rápido, presentaciones

---

## 🛠️ Scripts

### Scripts Principales

#### [setup-auto.sh](./setup-auto.sh)
**Setup Automático Completo**
- ✅ Valida requisitos
- ✅ Crea backups
- ✅ Aplica todas las modificaciones
- ✅ Configura variables de entorno
- ✅ Instala dependencias
- ✅ Crea scripts auxiliares

**Uso**:
```bash
cd /ruta/a/plasmic
bash /app/plasmic-local-setup/setup-auto.sh
```

---

#### [scripts/quick-start.sh](./scripts/quick-start.sh)
**Quick Start Guiado**
- ✅ Setup interactivo paso a paso
- ✅ Pregunta Docker vs Manual
- ✅ Valida en cada paso
- ✅ Muestra progreso

**Uso**:
```bash
bash /app/plasmic-local-setup/scripts/quick-start.sh
```

---

#### [scripts/test-setup.sh](./scripts/test-setup.sh)
**Test Suite Completo**
- ✅ Verifica directorios
- ✅ Prueba servicios
- ✅ Valida modificaciones
- ✅ Chequea variables de entorno
- ✅ Prueba base de datos
- ✅ Verifica API endpoints
- ✅ Reporte detallado

**Uso**:
```bash
cd /ruta/a/plasmic
bash /app/plasmic-local-setup/scripts/test-setup.sh
```

---

#### [scripts/apply-modification.sh](./scripts/apply-modification.sh)
**Aplicar Modificación Específica**
- ✅ Aplicar cambios individuales
- ✅ Crea backups automáticos
- ✅ Valida archivos

**Uso**:
```bash
# Modificación 1: API Loader
bash /app/plasmic-local-setup/scripts/apply-modification.sh 1

# Modificación 2: CLI
bash /app/plasmic-local-setup/scripts/apply-modification.sh 2

# etc...
```

---

#### [scripts/restore-backup.sh](./scripts/restore-backup.sh)
**Restaurar Backups**
- ✅ Lista backups disponibles
- ✅ Restaura archivos originales
- ✅ Interactivo

**Uso**:
```bash
bash /app/plasmic-local-setup/scripts/restore-backup.sh
```

---

## 📝 Parches de Código

### [modifications/](./modifications/)

Archivos `.patch` con modificaciones exactas:

1. **[01-api-loader.patch](./modifications/01-api-loader.patch)**
   - Modificación de `packages/loader-fetcher/src/api.ts`
   - Cambiar host a localhost

2. **[02-cli-api.patch](./modifications/02-cli-api.patch)**
   - Modificación de `packages/cli/src/api.ts`
   - Configurar host local en CLI

3. **[03-studio-frame.patch](./modifications/03-studio-frame.patch)**
   - Modificación de `platform/wab/.../studio-frame.tsx`
   - Agregar localhost a ALLOWED_ORIGINS

4. **[04-devflags.patch](./modifications/04-devflags.patch)**
   - Modificación de `platform/wab/.../devflags.ts`
   - Desactivar features cloud (opcional)

**Cada archivo incluye**:
- ✅ Código ANTES (original)
- ✅ Código DESPUÉS (modificado)
- ✅ Comandos para aplicar

---

## 📊 Flujo de Trabajo Recomendado

### Para Primera Vez:

```
1. Leer: EXECUTIVE_SUMMARY.md (5 min)
   ↓
2. Ejecutar: setup-auto.sh (15-45 min)
   ↓
3. Verificar: scripts/test-setup.sh (2 min)
   ↓
4. Abrir: http://localhost:3003
   ↓
5. Consultar: docs/USAGE_GUIDE.md (uso diario)
```

### Para Integración:

```
1. Leer: docs/INTEGRATION_GUIDE.md
   ↓
2. Seguir ejemplo de tu framework
   ↓
3. Configurar plasmic-init.ts con host local
   ↓
4. Probar componente en tu app
```

### Para Troubleshooting:

```
1. Identificar problema
   ↓
2. Buscar en: docs/FAQ.md
   ↓
3. Si no está: docs/TROUBLESHOOTING.md
   ↓
4. Aún no resuelto: scripts/test-setup.sh
   ↓
5. Revisar logs detalladamente
```

---

## 🔍 Búsqueda Rápida

### ¿Buscas...?

**Instalación rápida** → `setup-auto.sh` o `scripts/quick-start.sh`

**Guía completa** → `README.md`

**Uso diario** → `docs/USAGE_GUIDE.md`

**Integrar con Next.js/React** → `docs/INTEGRATION_GUIDE.md`

**Entender cómo funciona** → `docs/ARCHITECTURE.md`

**Resolver problema** → `docs/TROUBLESHOOTING.md`

**Pregunta específica** → `docs/FAQ.md`

**Overview ejecutivo** → `EXECUTIVE_SUMMARY.md`

**Verificar setup** → `scripts/test-setup.sh`

**Aplicar cambio manual** → `scripts/apply-modification.sh`

**Ver modificación exacta** → `modifications/*.patch`

---

## 📌 Comandos Esenciales

```bash
# Setup completo
bash /app/plasmic-local-setup/setup-auto.sh

# Verificar instalación
bash /app/plasmic-local-setup/scripts/test-setup.sh

# Iniciar (Docker)
cd /ruta/a/plasmic && docker-compose up -d

# Iniciar (Manual)
cd /ruta/a/plasmic/platform/wab && yarn dev

# Ver logs (Docker)
docker-compose logs -f plasmic-wab

# Detener (Docker)
docker-compose down

# Backup BD
pg_dump -h localhost -U wab wab > backup.sql

# Restaurar BD
psql -h localhost -U wab wab < backup.sql
```

---

## 🔗 Enlaces Útiles

### Externos:

- **Plasmic GitHub**: https://github.com/plasmicapp/plasmic
- **Plasmic Docs**: https://docs.plasmic.app
- **Plasmic Slack**: https://www.plasmic.app/slack
- **Plasmic Forum**: https://forum.plasmic.app

### Locales:

```
/app/plasmic-local-setup/
├── README.md                 # 📖 Guía master
├── EXECUTIVE_SUMMARY.md      # 🎯 Resumen ejecutivo
├── INDEX.md                  # 📚 Este archivo
├── setup-auto.sh             # 🤖 Setup automático
├── docs/
│   ├── USAGE_GUIDE.md        # 📘 Uso diario
│   ├── INTEGRATION_GUIDE.md  # 🔌 Integrar frameworks
│   ├── ARCHITECTURE.md       # 🏗️ Arquitectura técnica
│   ├── FAQ.md                # ❓ Preguntas frecuentes
│   └── TROUBLESHOOTING.md    # 🔧 Resolver problemas
├── scripts/
│   ├── quick-start.sh        # 🚀 Setup guiado
│   ├── test-setup.sh         # 🧪 Test suite
│   ├── apply-modification.sh # 📝 Aplicar cambios
│   └── restore-backup.sh     # 🔄 Restaurar
└── modifications/            # 📦 Parches
    ├── 01-api-loader.patch
    ├── 02-cli-api.patch
    ├── 03-studio-frame.patch
    └── 04-devflags.patch
```

---

## ✨ Actualizaciones

**Versión**: 1.0  
**Fecha**: 2025  
**Estado**: Completo y testeado  
**Cobertura**: Plasmic OSS (latest main branch)  

---

## 💬 Feedback

Si encuentras errores o tienes sugerencias:

1. Revisa si ya está en FAQ o Troubleshooting
2. Abre issue en: https://github.com/plasmicapp/plasmic/issues
3. Comparte en Slack: https://www.plasmic.app/slack

---

**¡Navega la documentación y construye con Plasmic Local!** 🚀

---