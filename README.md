# linkapps.me

Gestor de colecciones de enlaces y recursos. Organiza, comparte y muestra colecciones curadas con una interfaz limpia y de tema oscuro.

## Stack Tecnológico

**Framework** — Astro v6 (SSR) + React  
**Estilos** — Tailwind CSS v4 + shadcn/ui (radix-nova)  
**Auth y Datos** — Supabase (SSR)  
**Runtime** — Node.js ≥22.12 (standalone)

## Estructura del Proyecto

```
src/
├── pages/
│   ├── api/auth/       # Endpoints de auth (login, register)
│   ├── api/folders.ts  # CRUD de colecciones
│   ├── dashboard.astro # Panel principal
│   ├── view.astro      # Vista pública de colección
│   ├── settings.astro  # Perfil y avatar
│   ├── subscription.astro
│   └── index.astro     # Landing page
├── components/
│   ├── shared/         # Header, footer, fondo Three.js
│   ├── form/           # Formularios de auth
│   └── ui/             # Botones y tarjetas (shadcn)
├── layouts/
├── lib/
│   ├── supabase.ts     # Fábricas de cliente SSR y browser
│   └── dashboard.js    # Lógica cliente legada
└── styles/
    └── global.css      # Tailwind v4 @theme + variables CSS
```

## Desarrollo

```bash
npm run dev      # Iniciar servidor de desarrollo
npm run build    # Build de producción
npm run preview  # Previsualizar build
```
