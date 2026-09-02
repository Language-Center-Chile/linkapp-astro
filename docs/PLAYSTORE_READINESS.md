# LinkApp — Play Store Readiness

## Estado actual

La aplicación es una app web Astro 7 con `output: "server"` y `@astrojs/node`. Usa endpoints SSR propios (`/api/auth/*`, `/api/folders`) y Supabase SSR. Por ello, el build actual NO es un sitio estático que pueda copiarse directamente a `webDir` de Capacitor sin una decisión de arquitectura.

## Objetivo Android

- Formato de publicación: Android App Bundle (`.aab`).
- Preparar `targetSdk` 36 para nuevas publicaciones a partir del 31-08-2026.
- Publicar primero en Internal Testing.
- Mantener keystore y credenciales de firma fuera de Git.

## Decisión arquitectónica requerida antes de `npx cap add android`

### Opción A — Shell Android + backend SSR hospedado

Mantener Astro SSR desplegado en un dominio HTTPS controlado por LinkApp. El contenedor Android carga/consume el frontend/backend hospedado. Requiere validar experiencia móvil, navegación, deep links, política de red y que la app aporte una experiencia adecuada para Play Store.

### Opción B — App empaquetada + backend separado

Separar/refactorizar las rutas SSR hacia un backend/API hospedado y generar frontend estático compatible con `webDir`. Es más trabajo, pero deja los assets principales dentro del AAB y reduce dependencia del shell remoto.

No se debe cambiar `output: "server"` a estático sin migrar primero los endpoints y flujos SSR.

## Identidad pendiente

Definir ANTES de crear la app en Play Console:

- Nombre visible: LinkApp / LinkApps (por confirmar).
- `applicationId` definitivo, por ejemplo `me.linkapps.app` (NO adoptar hasta aprobación).
- `versionCode`: 1 inicial.
- `versionName`: 1.0.0 inicial.

El `applicationId` debe tratarse como permanente una vez publicado.

## Checklist técnico

- [x] Node >= 22.12 definido en `package.json`.
- [x] Astro 7 y `@astrojs/node` 11 actualizados; build local reproducible y auditoría runtime con 0 vulnerabilidades.
- [x] `.env` deja de versionarse en rama de preparación.
- [x] `.env.example` sin credenciales reales.
- [x] Keystores excluidos por `.gitignore`.
- [x] CI de build y auditoría de dependencias runtime agregado.
- [x] CI completamente verde (verificado el 02-09-2026).
- [ ] Revisar historial por secretos y rotar credenciales si corresponde.
- [ ] Elegir arquitectura Android A o B.
- [ ] Añadir Capacitor después de la decisión.
- [ ] Crear proyecto `android/`.
- [ ] Configurar `targetSdk` 36.
- [ ] Configurar icono adaptativo y splash.
- [ ] Revisar permisos Android y eliminarlos si no son necesarios.
- [ ] Configurar HTTPS/deep links si aplica.
- [ ] Probar login, registro, dashboard, folders, perfil, suscripción y logout en dispositivo.
- [ ] Generar keystore de release fuera del repositorio.
- [ ] Generar `.aab` release firmado.
- [ ] Smoke del AAB instalado desde Internal Testing.

## Checklist Play Console

- [ ] Cuenta de desarrollador y datos verificados.
- [ ] App creada con package name definitivo.
- [ ] Política de privacidad pública HTTPS.
- [ ] Data Safety alineado con Supabase/Auth y cualquier analytics futuro.
- [ ] Declaración de acceso a cuenta y eliminación de cuenta si la app permite crear cuentas.
- [ ] Clasificación de contenido.
- [ ] Público objetivo.
- [ ] Ads: declarar correctamente si hay o no anuncios.
- [ ] App access: entregar credenciales/instrucciones de revisión si hay contenido protegido.
- [ ] Ícono 512x512, feature graphic y screenshots Android.
- [ ] Internal Testing antes de producción.

## Gates de publicación

No subir a producción hasta tener: build verde, audit runtime sin high/critical no aceptados, AAB firmado, smoke en dispositivo, política de privacidad/Data Safety revisadas y rollback/versionado claro.
