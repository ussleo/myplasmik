# 🔧 Guía de Solución de Problemas (Troubleshooting) - myPlasmik

Este documento recopila soluciones probadas para errores comunes encontrados durante la ejecución de myPlasmik en entorno local (Windows).

---

## 🚨 Problemas Críticos

### 1. Pantalla Blanca al iniciar o crear proyecto
**Síntoma:** El editor carga (`http://localhost:3003`) pero muestra una pantalla totalmente blanca. La consola del navegador muestra errores 404 para archivos `.js` o `.css`.
**Causa:** El proceso de construcción (`build`) automático falló silenciosamente y no generó los artefactos necesarios en los sub-paquetes críticos.
**Solución:** Reconstruir manualmente los paquetes base. Ejecuta estos comandos en orden:

```powershell
# 1. Compilar el bundle de React Web
cd platform/react-web-bundle
yarn
$env:NODE_ENV='production'; yarn run rollup -c rollup.config.js
cd ../..

# 2. Compilar el Live Frame (Canvas)
cd platform/live-frame
yarn
$env:NODE_ENV='production'; yarn run rollup -c rollup.config.js
cd ../..

# 3. Compilar el Loader de Hidratación
cd platform/loader-html-hydrate
yarn
$env:NODE_ENV='production'; yarn run rollup -c
cd ../..

# 4. Generar Estilos CSS del Editor
cd platform/wab
yarn build-css
cd ../..

# 5. Reiniciar servicios
pm2 restart all
```

### 2. Error `EADDRINUSE` (Puertos ocupados)
**Síntoma:** PM2 muestra errores en los logs indicando que el puerto 3003 o 3004 ya está en uso.
**Causa:** Procesos huérfanos de Node.js que no se cerraron correctamente.
**Solución:**

1. Detener PM2:
   ```bash
   pm2 delete all
   ```
2. Buscar procesos ocupando el puerto (ej. 3003):
   ```bash
   netstat -ano | findstr :3003
   ```
3. Matar el proceso (reemplaza `PID` con el número que obtuviste):
   ```bash
   taskkill /F /PID <PID>
   ```

### 3. Errores de SASS / Estilos Rotos
**Síntoma:** El editor se ve "feo", sin estilos, o el log muestra errores de compilación SASS.
**Solución:** Ejecutar el script de reparación de estilos:
```powershell
powershell -ExecutionPolicy Bypass -File plasmic-local-setup/scripts/fix_styles.ps1
```

---

## 📋 Verificación de Salud del Sistema

Si tienes dudas sobre el estado del sistema, verifica que existan estos directorios clave:

*   `platform/react-web-bundle/build/`
*   `platform/live-frame/build/`
*   `platform/loader-html-hydrate/build/`
*   `platform/wab/src/wab/gen/` (Artefactos generados)
