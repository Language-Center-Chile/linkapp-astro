================================================================
DOCUMENTACIÓN DEL PROYECTO — linkapps.me
================================================================
Cada archivo .d explica en detalle uno de los archivos del proyecto.
Lee este índice para entender el flujo general y luego abre el .d
del archivo que te interese.
================================================================

================================================================
MAPA DE ARCHIVOS .d  (espejo de la estructura del proyecto)
================================================================

  documentacion/
  ├── INDICE.d                                    ← este archivo
  ├── astro.config.mjs.d                          ← Plugins, SSR, adapter Node.js
  │
  └── src/
      │
      ├── styles/
      │   └── global.css.d                        ← Estilos globales, tema claro/oscuro, Tailwind
      │
      ├── lib/
      │   ├── supabase.ts.d                       ← Cliente Supabase SSR (cookies, sesiones)
      │   └── utils.ts.d                          ← Función cn() para combinar clases Tailwind
      │
      ├── layouts/
      │   └── mainLayouts.astro.d                 ← Layout base: HTML, head, header, footer, fondo
      │
      ├── components/
      │   ├── shared/
      │   │   ├── FloatingLines.jsx.d             ← Fondo animado con WebGL/Three.js + shaders
      │   │   ├── header.astro.d                  ← Barra de navegación superior
      │   │   └── footer.astro.d                  ← Pie de página con redes sociales
      │   │
      │   ├── form/
      │   │   ├── form.astro.d                    ← Formulario multi-modo + 5 modales de error
      │   │   ├── input.astro.d                   ← Input con animación wave en el label
      │   │   ├── button.astro.d                  ← Botón <button> o <a> según props
      │   │   └── styles.css.d                    ← Estilos del form, wave, botones
      │   │
      │   └── ui/
      │       ├── button.tsx.d                    ← Botón shadcn/ui con variantes y tamaños
      │       ├── buttons/
      │       │   ├── button-nav.astro.d          ← Botón de nav con efecto texto animado
      │       │   └── button.astro.d              ← Botón CTA con glow de gradiente
      │       └── cards/
      │           ├── carta.astro.d               ← Tarjeta con borde gradiente verde-morado
      │           └── texto.astro.d               ← Contenido interior (precio, features, botón)
      │
      └── pages/
          ├── index.astro.d                       ← Página principal / (hero + 3 features)
          ├── about.astro.d                       ← Página /about (vacía, por completar)
          ├── subscription.astro.d                ← Página /subscription (3 planes de precios)
          ├── login.astro.d                       ← Página /login
          ├── register.astro.d                    ← Página /register
          └── api/
              └── auth/
                  ├── login.ts.d                  ← POST /api/auth/login
                  └── register.ts.d               ← POST /api/auth/register

================================================================
FLUJO GENERAL DEL SISTEMA DE AUTENTICACIÓN
================================================================

  ┌─────────────────────────────────────────────────────────────┐
  │                       NAVEGADOR                             │
  │                                                             │
  │  /login            /register                               │
  │  login.astro  →  register.astro                            │
  │       ↓                 ↓                                  │
  │       └────── form.astro (mode="login"|"register") ────────┘
  │                    ↓ (submit)
  │             JavaScript (script en form.astro)
  │              1. Valida campos localmente
  │              2. Muestra modal si hay error local
  │              3. Si todo ok → fetch al API
  └─────────────────────────────────────────────────────────────┘
                          ↓ fetch POST
  ┌─────────────────────────────────────────────────────────────┐
  │                       SERVIDOR                              │
  │                                                             │
  │  /api/auth/login.ts  o  /api/auth/register.ts              │
  │        ↓                        ↓                          │
  │  createClient()          createClient()                    │
  │  (supabase.ts)           (supabase.ts)                     │
  │        ↓                        ↓                          │
  │  signInWithPassword()    signUp() + INSERT en tabla Users   │
  └─────────────────────────────────────────────────────────────┘
                          ↓ respuesta JSON
  ┌─────────────────────────────────────────────────────────────┐
  │                    DE VUELTA EN EL NAVEGADOR                │
  │                                                             │
  │  Si error  → muestra el modal correspondiente               │
  │  Si OK login    → redirige a "/"                            │
  │  Si OK register → muestra modal "revisa tu correo"          │
  │                   → al cerrar, redirige a /login            │
  └─────────────────────────────────────────────────────────────┘

================================================================
ERRORES Y SUS MODALES
================================================================

  ┌──────────────────────────────┬──────────────────────────────┐
  │ Situación                    │ Modal mostrado               │
  ├──────────────────────────────┼──────────────────────────────┤
  │ Registro exitoso (con email) │ email-modal                  │
  │ Contraseñas no coinciden     │ password-modal               │
  │ Credenciales incorrectas     │ incorrect-password-modal     │
  │ Contraseña < 6 caracteres    │ short-password-modal         │
  │ Rate limit de Supabase       │ rate-limit-modal             │
  └──────────────────────────────┴──────────────────────────────┘

================================================================
TECNOLOGÍAS USADAS
================================================================

  Astro v6          → Framework web (SSR, componentes, routing)
  Supabase          → Backend as a Service (auth + base de datos)
  @supabase/ssr     → Adaptador de Supabase para SSR (cookies)
  React             → Para el componente FloatingLines del fondo
  Three.js          → Renderizado WebGL del fondo animado
  GLSL (shaders)    → Código que corre en la GPU para las líneas
  Tailwind CSS      → Utilidades de CSS
  shadcn/ui         → Componentes React pre-construidos (Button, etc.)
  class-variance-authority → Sistema de variantes para componentes
  clsx + twMerge    → Utilidades para combinar clases Tailwind
  Geist Variable    → Fuente tipográfica del proyecto (de Vercel)
  TypeScript        → Tipado estático

================================================================
VARIABLES DE ENTORNO NECESARIAS (.env)
================================================================

  PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
  PUBLIC_SUPABASE_PUBLISHABLE_KEY=eyJ...

  Estas se obtienen en: supabase.com → Tu proyecto → Settings → API

================================================================
