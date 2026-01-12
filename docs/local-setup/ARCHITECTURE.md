# 🏗️ ARQUITECTURA TÉCNICA - PLASMIC LOCAL

## 📋 Visión General

Plasmic es un sistema complejo dividido en múltiples componentes que trabajan juntos para proporcionar un editor visual de aplicaciones web.

```
┌─────────────────────────────────────────────────────────────┐
│                        PLASMIC LOCAL                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐        ┌──────────────┐                   │
│  │   Frontend   │◄──────►│   Backend    │                   │
│  │  (React SPA) │        │ (Node.js API)│                   │
│  │              │        │              │                   │
│  │ localhost:   │        │ localhost:   │                   │
│  │    3003      │        │    3004      │                   │
│  └──────┬───────┘        └──────┬───────┘                   │
│         │                       │                           │
│         │                       │                           │
│         └───────────┬───────────┘                           │
│                     │                                       │
│                     ▼                                       │
│           ┌────────────────┐                                │
│           │   PostgreSQL   │                                │
│           │   Database     │                                │
│           │  localhost:    │                                │
│           │     5432       │                                │
│           └────────────────┘                                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🗂️ ESTRUCTURA DEL REPOSITORIO

```
plasmic/
├── platform/
│   └── wab/                    # 🎨 Plasmic Studio (editor visual)
│       ├── src/wab/
│       │   ├── client/        # Frontend React
│       │   ├── server/        # Backend Node.js
│       │   ├── shared/        # Código compartido
│       │   └── commons/       # Utilidades genéricas
│       ├── package.json
│       └── .env
│
├── packages/                   # 📦 SDKs y Libraries
│   ├── loader-core/           # Core del loader
│   ├── loader-fetcher/        # API fetcher
│   ├── loader-nextjs/         # Integración Next.js
│   ├── loader-react/          # Integración React
│   ├── loader-gatsby/         # Integración Gatsby
│   ├── host/                  # Code components host
│   ├── cli/                   # Command line tool
│   └── react-web/             # Runtime de React
│
├── plasmicpkgs/               # 🧩 Code Components
│   ├── plasmic-basic-components/
│   ├── plasmic-rich-components/
│   └── ... (componentes reutilizables)
│
├── examples/                   # 💡 Ejemplos de integración
│   ├── nextjs-example/
│   ├── react-minimal/
│   └── ...
│
├── docker-compose.yml         # 🐳 Configuración Docker
├── package.json               # Dependencies raíz
└── lerna.json                 # Monorepo config
```

---

## 🎨 FRONTEND (Client)

### Tecnologías

- **React**: Framework principal
- **TypeScript**: Type safety
- **Webpack/RSBuild**: Bundling
- **Ant Design**: Componentes UI
- **MobX**: State management

### Ubicación

```
platform/wab/src/wab/client/
├── components/
│   └── studio/              # Componentes del editor
│       ├── studio.tsx       # Componente principal
│       ├── view-editor.tsx  # Editor de vistas
│       ├── LeftPane.tsx     # Panel izquierdo
│       └── ...
├── shortcuts/               # Keyboard shortcuts
├── plasmic/                 # Componentes de Plasmic
└── styles/                  # Estilos CSS
```

### Flujo de Datos

```
Usuario
  ↓
Studio Component
  ↓
ViewCtx (contexto de vista)
  ↓
StudioCtx (contexto global)
  ↓
API Client (fetch a backend)
  ↓
Backend API
```

### Puntos Clave

1. **StudioCtx**: Contexto global que mantiene estado de la app
2. **ViewCtx**: Contexto de la vista actual (arena, frame, etc.)
3. **Observables (MobX)**: Reactividad automática
4. **Canvas**: Iframe donde se renderizan los componentes

---

## 🔧 BACKEND (Server)

### Tecnologías

- **Node.js**: Runtime
- **Express**: Web framework
- **TypeORM**: ORM para PostgreSQL
- **TypeScript**: Type safety

### Ubicación

```
platform/wab/src/wab/server/
├── routes/                  # API endpoints
├── db/                      # Database models y migrations
│   ├── DbInit.ts           # Seed database
│   └── migrations/         # TypeORM migrations
├── loader/                  # Codegen y bundling
│   ├── gen-code-bundle.ts  # Genera código React
│   └── module-bundler.ts   # Bundle de módulos
├── workers/                 # Background jobs
└── main.ts                  # Entry point
```

### APIs Principales

#### 1. Proyectos
```
GET  /api/v1/projects          # Listar proyectos
GET  /api/v1/projects/:id      # Obtener proyecto
POST /api/v1/projects          # Crear proyecto
PUT  /api/v1/projects/:id      # Actualizar proyecto
DEL  /api/v1/projects/:id      # Eliminar proyecto
```

#### 2. Componentes
```
GET  /api/v1/projects/:id/components
POST /api/v1/projects/:id/components
PUT  /api/v1/components/:id
```

#### 3. Loader / Codegen
```
GET  /api/v1/loader/code/published?projectId=xxx
GET  /api/v1/loader/code/preview?projectId=xxx
GET  /api/v1/loader/html?component=xxx
```

### Base de Datos

#### Entidades Principales

```sql
-- Proyectos
CREATE TABLE project (
  id VARCHAR PRIMARY KEY,
  name VARCHAR NOT NULL,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  bundle JSONB  -- Contiene toda la estructura del proyecto
);

-- Usuarios
CREATE TABLE "user" (
  id VARCHAR PRIMARY KEY,
  email VARCHAR UNIQUE,
  password_hash VARCHAR,
  first_name VARCHAR,
  last_name VARCHAR
);

-- Componentes
CREATE TABLE component (
  id VARCHAR PRIMARY KEY,
  project_id VARCHAR REFERENCES project(id),
  name VARCHAR,
  type VARCHAR,  -- 'page' | 'component' | 'global'
  data JSONB
);

-- Tokens de API
CREATE TABLE api_token (
  id VARCHAR PRIMARY KEY,
  project_id VARCHAR REFERENCES project(id),
  token VARCHAR UNIQUE,
  created_at TIMESTAMP
);
```

---

## 📦 PACKAGES (SDKs)

### Loader Architecture

```
@plasmicapp/loader-nextjs
         ↓
@plasmicapp/loader-react
         ↓
@plasmicapp/loader-core
         ↓
@plasmicapp/loader-fetcher  → API (codegen.plasmic.app)
```

### loader-fetcher (Modificado para local)

```typescript
// packages/loader-fetcher/src/api.ts

export class Api {
  private host: string;
  
  constructor(opts) {
    // ✅ MODIFICADO: Apunta a localhost en desarrollo
    this.host = opts.host ?? 
                process.env.PLASMIC_HOST ?? 
                'http://localhost:3004';  // 👈 LOCAL
  }
  
  async fetchLoaderData(projectIds: string[]) {
    const url = `${this.host}/api/v1/loader/code/published?projectId=${projectIds[0]}`;
    const response = await fetch(url, {
      headers: this.makeGetHeaders(),
    });
    return await response.json();
  }
}
```

### loader-nextjs

Wrapper para Next.js que provee:

```typescript
// Inicialización
export function initPlasmicLoader(opts: {
  projects: { id: string; token: string }[];
  host?: string;  // 👈 Apuntar a localhost:3004
  preview?: boolean;
})

// Componentes
export function PlasmicComponent(props: { component: string })
export function PlasmicRootProvider(props: { loader, children })

// Fetching
export async function fetchPages()
export async function fetchComponentData(component: string)
```

---

## 🔄 FLUJO DE TRABAJO COMPLETO

### 1. Crear Componente en Editor

```
Usuario arrastra elementos en canvas
  ↓
Frontend actualiza estado (MobX)
  ↓
StudioCtx.saveProject()
  ↓
POST /api/v1/projects/:id
  ↓
Backend serializa y guarda en PostgreSQL
  ↓
Respuesta con bundle actualizado
  ↓
Frontend actualiza UI
```

### 2. Integrar en App Next.js

```
App Next.js llama PLASMIC.fetchComponentData('Homepage')
  ↓
@plasmicapp/loader-nextjs
  ↓
@plasmicapp/loader-core
  ↓
@plasmicapp/loader-fetcher
  ↓
GET http://localhost:3004/api/v1/loader/code/published
  ↓
Backend genera bundle de código
  ↓
Devuelve { modules, components, projects }
  ↓
Loader renderiza componente
  ↓
App muestra componente en página
```

### 3. Codegen (Alternativa)

```
$ plasmic sync
  ↓
CLI lee plasmic.json
  ↓
GET http://localhost:3004/api/v1/loader/code/published
  ↓
Backend genera código React
  ↓
CLI escribe archivos en src/components/plasmic/
  ↓
Importas directamente en tu código:
import { Homepage } from './components/plasmic/Homepage'
```

---

## 🔐 AUTENTICACIÓN Y SEGURIDAD

### Autenticación

```typescript
// Login
POST /api/v1/auth/login
Body: { email, password }
Response: { token, user }

// Headers en requests subsecuentes
Authorization: Bearer <token>
```

### API Tokens

Para integrar con loader:

```typescript
const PLASMIC = initPlasmicLoader({
  projects: [{
    id: 'PROJECT_ID',
    token: 'PROJECT_TOKEN',  // Token de API del proyecto
  }],
});
```

Generar token:
```sql
INSERT INTO api_token (id, project_id, token) 
VALUES (gen_random_uuid(), 'PROJECT_ID', gen_random_uuid());
```

---

## 🎯 PUNTOS CLAVE PARA MODO LOCAL

### 1. Modificaciones Críticas

```typescript
// packages/loader-fetcher/src/api.ts
this.host = process.env.PLASMIC_HOST || 'http://localhost:3004';

// platform/wab/src/wab/client/components/studio/studio-frame.tsx
const ALLOWED_ORIGINS = [
  'http://localhost:3003',
  'http://localhost:3004',
  // ...
];
```

### 2. Variables de Entorno

```bash
# platform/wab/.env
PLASMIC_LOCAL_MODE=true
PLASMIC_HOST=http://localhost:3004
CODEGEN_HOST=http://localhost:3004
```

### 3. No Cloud Dependencies

Todo funciona sin conectar a:
- ❌ studio.plasmic.app
- ❌ codegen.plasmic.app
- ❌ Plasmic CDN

---

## 📊 PERFORMANCE Y ESCALABILIDAD

### Caching

```typescript
// Loader cachea bundles
const cache = new Map<string, LoaderBundleOutput>();

if (cache.has(cacheKey)) {
  return cache.get(cacheKey);
}
```

### Optimizaciones

1. **Incremental builds**: Solo recompila lo cambiado
2. **Code splitting**: Genera chunks separados
3. **Tree shaking**: Elimina código no usado
4. **Memoization**: Cache de renderizado

### Límites Conocidos

- **Proyectos grandes (>1000 componentes)**: Puede ser lento
- **Bundle size**: Genera código verboso
- **First compile**: 5-10 minutos

---

## 🧪 TESTING

### Backend Tests

```bash
cd platform/wab
yarn test
```

### Frontend Tests

```bash
cd platform/wab
yarn test:frontend
```

### E2E Tests

```bash
cd platform/wab
yarn cypress:open
```

---

## 📚 RECURSOS PARA PROFUNDIZAR

- **Código fuente**: https://github.com/plasmicapp/plasmic
- **Docs oficiales**: https://docs.plasmic.app
- **Technical overview**: https://docs.plasmic.app/learn/technical-overview
- **Contributing**: https://github.com/plasmicapp/plasmic/blob/master/CONTRIBUTING.md

---

**Esta arquitectura permite que Plasmic funcione 100% localmente** 🚀