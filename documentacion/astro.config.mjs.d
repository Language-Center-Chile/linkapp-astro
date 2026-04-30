================================================================
ARCHIVO: astro.config.mjs
PROPÓSITO: Configuración principal del proyecto Astro.
           Define cómo se construye, qué plugins usa y cómo se despliega.
================================================================

================================================================
LÍNEA A LÍNEA
================================================================

  // @ts-check
  → Activa la comprobación de tipos de TypeScript en este archivo
    JavaScript. Ayuda a detectar errores sin necesidad de renombrarlo a .ts.

  import { defineConfig } from "astro/config";
  → Importa la función que define la configuración de Astro.
    Usar defineConfig (en vez de exportar un objeto crudo) da
    autocompletado e intellisense en el editor.

  import tailwindcss from "@tailwindcss/vite";
  → Plugin de Tailwind CSS para Vite. Procesa las clases utilitarias
    de Tailwind (como text-white, flex, rounded, etc.) en el CSS final.

  import node from "@astrojs/node";
  → Adaptador de Node.js para Astro. Permite que el proyecto se ejecute
    como un servidor Node.js real (Express-like) en producción.
    Necesario para el modo SSR (renderizado en servidor).

  import react from "@astrojs/react";
  → Integración de React para Astro. Permite usar componentes React (.jsx/.tsx)
    dentro de los archivos .astro, como el componente FloatingLines.

----------------------------------------------------------------

  export default defineConfig({

    vite: {
      plugins: [tailwindcss()],
    },
    → Configura Vite (el bundler que usa Astro internamente).
      Añadimos Tailwind como plugin de Vite para que procese las clases CSS.

    integrations: [react()],
    → Activa la integración de React. Sin esto, no podríamos usar
      componentes .jsx/.tsx ni la directiva client:load.

    output: "server",
    → MODO SSR (Server-Side Rendering).
      Significa que las páginas se generan en el servidor en cada petición,
      no de forma estática en build time.
      Es obligatorio para poder usar los endpoints de API (/api/auth/*)
      que leen cookies y se comunican con Supabase.
      Alternativas:
        · "static"  → sitio estático, sin servidor (no sirve para auth)
        · "hybrid"  → algunas páginas estáticas, otras SSR

    adapter: node({
      mode: "standalone",
    }),
    → Le dice a Astro cómo empaquetar el servidor para producción.
      mode: "standalone" → genera un servidor Node.js independiente
      que puedes ejecutar con `node dist/server/entry.mjs`.
      No necesita ningún servidor web externo (como Nginx).
      El output del build va a la carpeta /dist/.

  });

================================================================
RESUMEN DE LA CONFIGURACIÓN
================================================================

  ┌─────────────────────┬────────────────────────────────────────┐
  │ Opción              │ Qué hace                               │
  ├─────────────────────┼────────────────────────────────────────┤
  │ vite.plugins        │ Activa Tailwind CSS                    │
  │ integrations        │ Activa soporte para componentes React  │
  │ output: "server"    │ Modo SSR (páginas dinámicas)           │
  │ adapter: node       │ Servidor Node.js standalone            │
  └─────────────────────┴────────────────────────────────────────┘

================================================================
COMANDOS RELACIONADOS (del package.json)
================================================================

  npm run dev     → Inicia el servidor de desarrollo (localhost:4321)
  npm run build   → Construye el proyecto para producción en /dist/
  npm run preview → Previsualiza el build de producción localmente

================================================================
