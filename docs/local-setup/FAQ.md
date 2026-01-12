# ❓ PREGUNTAS FRECUENTES - PLASMIC LOCAL

## 📋 ÍNDICE

1. [General](#general)
2. [Instalación](#instalación)
3. [Desarrollo](#desarrollo)
4. [Integración](#integración)
5. [Troubleshooting](#troubleshooting)
6. [Performance](#performance)
7. [Versionado](#versionado)
8. [Migración](#migración)

---

## GENERAL

### ¿Qué es Plasmic Local?

Plasmic Local es una configuración de Plasmic (visual builder open-source) que funciona completamente en tu máquina local sin depender de servicios cloud de Plasmic.

### ¿Por qué usar Plasmic Local?

✅ **Control total**: Tu código y datos están en tu máquina  
✅ **Sin límites de cloud**: No dependes de quotas o subscripciones  
✅ **Desarrollo offline**: Trabaja sin conexión a internet  
✅ **Versionado con Git**: Control total sobre versiones  
✅ **Privacidad**: Tus diseños nunca salen de tu infraestructura  

### ¿Qué porcentaje de funcionalidad está disponible localmente?

**95-98% funcional** para desarrollo individual.

**No disponible localmente**:
- Colaboración en tiempo real (multiplayer)
- CDN optimizado de imágenes (puedes usar local)
- Algunas integraciones cloud específicas

### ¿Es legal usar Plasmic Local?

**Sí**, Plasmic es open-source con licencia MIT (código fuera de `platform/`) y AGPL para `platform/`. Puedes usarlo, modificarlo y distribuirlo según los términos de estas licencias.

---

## INSTALACIÓN

### ¿Cuáles son los requisitos mínimos?

**Software**:
- Node.js 18+
- Yarn
- PostgreSQL 15+
- Git
- (Opcional) Docker & Docker Compose

**Hardware**:
- RAM: 8GB mínimo (16GB recomendado)
- Disco: 10GB libres
- CPU: 4 cores recomendado

### ¿Docker o instalación manual?

**Docker (recomendado)**:
- ✅ Más fácil y rápido
- ✅ Aislado del sistema
- ✅ Fácil de borrar/reinstalar
- ❌ Consume más recursos

**Manual**:
- ✅ Mejor performance
- ✅ Más control
- ❌ Más complejo de configurar
- ❌ Puede conflictuar con otras apps

### ¿Cuánto tiempo toma la instalación?

- **Con Docker**: 15-20 minutos
- **Manual**: 30-45 minutos
- Primera compilación: 5-10 minutos adicionales

### ¿Puedo usar WSL en Windows?

**Sí**, funciona perfectamente con WSL2. Recomendado usar Docker Desktop for Windows con integración WSL2.

---

## DESARROLLO

### ¿Cómo inicio Plasmic después de instalarlo?

```bash
# Opción A: Docker
cd /ruta/a/plasmic
docker-compose up -d

# Opción B: Manual
cd /ruta/a/plasmic/platform/wab
yarn dev
```

### ¿Cómo sé que está funcionando en modo local?

Verifica en el navegador (http://localhost:3003):
1. **DevTools > Console**: Debe aparecer `[Plasmic Local] API Host: http://localhost:3004`
2. **DevTools > Network**: NO debe haber requests a `*.plasmic.app`

### ¿Puedo usar componentes de npm?

**Sí**, puedes registrar cualquier componente React como "code component" y usarlo en el editor visual.

### ¿Soporta TypeScript?

**Sí**, Plasmic genera código TypeScript y soporta componentes TypeScript.

### ¿Cómo hago hot reload?

El hot reload está activado por defecto:
- Cambios en `client/` → recarga frontend automáticamente
- Cambios en `server/` → reinicia backend automáticamente

### ¿Puedo personalizar el puerto?

Sí, en `platform/wab/.env`:
```bash
PORT=3003  # Frontend
BACKEND_PORT=3004  # Backend
```

---

## INTEGRACIÓN

### ¿Qué frameworks soporta?

✅ Next.js (App Router y Pages Router)  
✅ React (CRA, Vite, etc.)  
✅ Gatsby  
✅ Remix  
✅ Angular (experimental)  
✅ Vue (experimental)  

### ¿Cómo integro con mi app Next.js?

```typescript
// plasmic-init.ts
import { initPlasmicLoader } from '@plasmicapp/loader-nextjs';

export const PLASMIC = initPlasmicLoader({
  projects: [{ id: 'PROJECT_ID', token: 'TOKEN' }],
  host: 'http://localhost:3004', // 👈 LOCAL!
});
```

Ver guía completa: `/app/plasmic-local-setup/docs/INTEGRATION_GUIDE.md`

### ¿Puedo usar con Tailwind CSS?

**Sí**, Plasmic funciona perfectamente con Tailwind. Puedes:
1. Usar clases de Tailwind en el editor
2. Registrar componentes con Tailwind
3. Mezclar estilos de Plasmic con Tailwind

### ¿Soporta Server Components de Next.js?

**Sí**, el loader de Next.js soporta React Server Components en App Router.

### ¿Puedo usar con tRPC/GraphQL?

**Sí**, puedes crear code components que usen cualquier cliente de API (tRPC, GraphQL, REST, etc.)

---

## TROUBLESHOOTING

### "Cannot connect to database"

```bash
# Verificar PostgreSQL
pg_isready -h localhost -p 5432

# Si no está corriendo:
docker-compose up -d plasmic-db
# o
sudo systemctl start postgresql
```

### "Port already in use"

```bash
# Ver qué usa el puerto
lsof -i :3003
lsof -i :3004

# Matar proceso
kill -9 <PID>
```

### "CORS error"

Verificar que `localhost` esté en `ALLOWED_ORIGINS`:
```bash
grep -A 10 "ALLOWED_ORIGINS" platform/wab/src/wab/client/components/studio/studio-frame.tsx
```

Si no está, aplicar modificación 3:
```bash
bash /app/plasmic-local-setup/scripts/apply-modification.sh 3
```

### Frontend no carga

```bash
# Limpiar cache y rebuild
cd platform/wab
rm -rf dev-build/ .cache/
yarn dev
```

### Más soluciones

Ver: `/app/plasmic-local-setup/docs/TROUBLESHOOTING.md`

---

## PERFORMANCE

### La compilación es muy lenta

```bash
# Aumentar memoria de Node.js
export NODE_OPTIONS="--max-old-space-size=8192"

# Desactivar source maps
# En platform/wab/.env:
GENERATE_SOURCEMAP=false

# Aumentar file watchers (Linux)
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### El editor se siente lento

```bash
# Desactivar features no necesarias
# En platform/wab/.env:
DISABLE_ANALYTICS=true
DISABLE_MULTIPLAYER=true
LOG_LEVEL=error
```

### PostgreSQL consume mucha RAM

```bash
# Optimizar BD
psql -h localhost -U wab wab
VACUUM ANALYZE;
REINDEX DATABASE wab;
```

---

## VERSIONADO

### ¿Cómo versiono mis proyectos?

**Opción 1: Backups de BD**
```bash
pg_dump -h localhost -U wab wab > backup-v1.0.sql
git add backup-v1.0.sql
git commit -m "Proyecto v1.0"
```

**Opción 2: Exportar JSON**
```bash
cd platform/wab
node -r esbuild-register src/wab/server/scripts/export-project.ts \
  --projectId="ID" --output="proyecto.json"
git add proyecto.json
git commit -m "Export proyecto"
```

**Opción 3: Codegen + Git**
```bash
plasmic sync
git add src/components/plasmic/
git commit -m "Update components"
```

### ¿Puedo usar branches de Git?

**Sí**, estrategia recomendada:

```bash
git checkout -b feature/nueva-pagina

# Backup antes de empezar
pg_dump -h localhost -U wab wab > backups/before-feature.sql

# ... trabajar en el editor ...

# Backup después
pg_dump -h localhost -U wab wab > backups/after-feature.sql
git add backups/
git commit -m "Feature complete"

# Merge a main
git checkout main
git merge feature/nueva-pagina

# Restaurar BD
psql -h localhost -U wab wab < backups/after-feature.sql
```

### ¿Cómo colaboro con otros desarrolladores?

Sin sistema de multiplayer, opciones:

1. **Turnos**: Una persona trabaja en el editor a la vez
2. **Backups + Git**: Compartir backups de BD vía Git
3. **Codegen**: Cada uno genera código y merge en Git
4. **Proyectos separados**: Cada dev su propia instancia + integración via código

---

## MIGRACIÓN

### ¿Puedo migrar proyectos de studio.plasmic.app?

**Sí**, opciones:

1. **Usar CLI para sincronizar**:
```bash
plasmic sync --host=http://localhost:3004
```

2. **Recrear manualmente** en tu instancia local

3. **Importar desde export** (si Plasmic provee export/import)

### ¿Puedo usar proyectos locales en producción?

**Sí**, opciones:

**Opción 1: Self-hosted**
- Deploya tu instancia de Plasmic en tu servidor
- Apunta tu app a esa instancia

**Opción 2: Codegen**
- Genera código con `plasmic sync`
- Commit el código generado
- Deploy como cualquier app React/Next.js

**Opción 3: Hybrid**
- Desarrollo en local
- Producción usa studio.plasmic.app (si tienes cuenta)

### ¿Cómo actualizo Plasmic Local?

```bash
# 1. Backup BD
pg_dump -h localhost -U wab wab > backup-before-update.sql

# 2. Actualizar código
cd /ruta/a/plasmic
git pull origin main

# 3. Reinstalar
yarn install
cd platform/wab && yarn install

# 4. Migraciones
yarn typeorm migration:run

# 5. Re-aplicar modificaciones
cd ../..
bash /app/plasmic-local-setup/setup-auto.sh --skip-install

# 6. Reiniciar
docker-compose restart
```

---

## PRODUCTIZACIÓN

### ¿Es seguro usar en producción?

**Sí**, pero considera:

✅ **Pros**:
- Control total de infraestructura
- No dependes de servicios externos
- Puedes optimizar para tu caso de uso

⚠️ **Contras**:
- Tú eres responsable de mantenimiento
- Necesitas gestionar backups
- Actualizaciones manuales

### ¿Necesito configurar HTTPS?

Para **desarrollo local**: No necesario.

Para **producción self-hosted**: Sí, usa Nginx/Caddy con Let's Encrypt.

### ¿Cómo escalo Plasmic Local?

Para múltiples usuarios/equipos:
1. Usar PostgreSQL en servidor dedicado
2. Load balancer para múltiples instancias de frontend/backend
3. Redis para sesiones compartidas
4. Object storage (S3) para assets

---

## SEGURIDAD

### ¿Está seguro mi setup local?

Por defecto, Plasmic Local:
- ✅ Solo escucha en localhost
- ✅ No envía datos a internet
- ⚠️ Usa contraseñas de desarrollo (cambiar en producción)

### ¿Cómo cambio las contraseñas por defecto?

```sql
psql -h localhost -U wab wab

-- Cambiar password de usuario
UPDATE "user" 
SET password_hash = '$2a$10$...'  -- Hash bcrypt
WHERE email = 'user@example.com';
```

O usar script:
```bash
cd platform/wab
node -r esbuild-register src/wab/server/scripts/change-password.ts
```

### ¿Debo preocuparme por la seguridad?

Si es **solo local/desarrollo**: Seguridad básica es suficiente.

Si **expones a red/internet**: 
- Cambiar todas las contraseñas
- Configurar firewall
- Usar HTTPS
- Implementar rate limiting
- Monitoreo de seguridad

---

## OTROS

### ¿Hay comunidad de Plasmic Local?

- **GitHub**: https://github.com/plasmicapp/plasmic/issues
- **Slack**: https://www.plasmic.app/slack
- **Forum**: https://forum.plasmic.app

### ¿Puedo contribuir al proyecto?

**Sí**, Plasmic es open-source. Ver:
- CONTRIBUTING.md en el repo
- https://docs.plasmic.app/learn/contributing

### ¿Dónde puedo obtener ayuda?

1. Revisa documentación en `/app/plasmic-local-setup/docs/`
2. Consulta troubleshooting guide
3. Busca en issues de GitHub
4. Pregunta en Slack/Forum de Plasmic

### ¿Cuál es la diferencia con Plasmic Cloud?

| Característica | Plasmic Cloud | Plasmic Local |
|----------------|---------------|---------------|
| Setup | Inmediato | 15-45 min |
| Costo | Freemium/Paid | Gratis (self-host) |
| Mantenimiento | Automático | Manual |
| Colaboración | Sí (real-time) | Limitada |
| Control | Limitado | Total |
| Offline | No | Sí |
| Datos | En cloud | En tu máquina |

---

## 💡 PREGUNTAS NO RESPONDIDAS

Si tu pregunta no está aquí:

1. Revisa la documentación completa
2. Busca en: https://docs.plasmic.app
3. Abre issue en: https://github.com/plasmicapp/plasmic/issues
4. Pregunta en Slack: https://www.plasmic.app/slack

---

**¡Actualizado regularmente con nuevas preguntas!** 🚀