================================================================
ARCHIVO: src/styles/global.css
PROPÓSITO: Estilos globales que se aplican a TODAS las páginas.
           Define la tipografía, colores del tema (claro/oscuro),
           resets básicos y variables CSS del sistema de diseño.
================================================================

================================================================
SECCIÓN 1 — IMPORTS
================================================================

  @import "tailwindcss";
  → Activa todas las clases utilitarias de Tailwind (flex, grid, text-*, etc.)

  @import "tw-animate-css";
  → Añade animaciones predefinidas como animate-fade-in, animate-slide-up, etc.
    Son las animaciones que usa shadcn/ui en sus componentes (modales, dropdowns).

  @import "shadcn/tailwind.css";
  → Importa los estilos base de shadcn/ui: variables CSS del tema,
    estilos de focus, etc.

  @import "@fontsource-variable/geist";
  → Importa la fuente Geist Variable (de Vercel).
    Es una fuente moderna sans-serif que se usa en todo el sitio.
    Es "variable" significa que tiene diferentes pesos en un solo archivo.

================================================================
SECCIÓN 2 — @custom-variant dark
================================================================

  @custom-variant dark (&:is(.dark *));
  → Define cómo Tailwind detecta el "modo oscuro" en este proyecto.
    En vez de detectar la preferencia del sistema (prefers-color-scheme),
    usa la clase .dark en el HTML. Si un elemento padre tiene clase "dark",
    los estilos dark: de Tailwind se activan.

================================================================
SECCIÓN 3 — RESET Y LAYOUT BASE
================================================================

  html, body { height: 100%; margin: 0; padding: 0; overflow-x: hidden; }
  → Elimina márgenes y rellenos predeterminados del navegador.
    overflow-x: hidden evita scroll horizontal no deseado.

  body {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }
  → El body es un flex column que ocupa al menos la ventana completa.
    Esto es necesario para que el footer siempre esté al fondo.

  main { flex: 1; }
  → El <main> crece para ocupar todo el espacio entre header y footer.
    Si hay poco contenido, el footer igual queda al fondo de la pantalla.

================================================================
SECCIÓN 4 — @theme inline (variables del sistema de diseño)
================================================================

  Esta sección mapea los nombres de variables de Tailwind a las
  variables CSS del tema. Permite usar clases como text-primary,
  bg-card, etc. en Tailwind.

  Variables de fuente:
  --font-heading: var(--font-sans);  → headings usan la misma fuente
  --font-sans: 'Geist Variable', sans-serif; → fuente principal

  Variables de color:
    Se mapean todos los colores del tema: background, foreground,
    card, primary, secondary, muted, accent, destructive, border,
    input, ring, y colores de charts y sidebar.

  Variables de radio (border-radius):
    --radius-sm, --radius-md, --radius-lg, --radius-xl, etc.
    Todas derivan de --radius (0.625rem base).

================================================================
SECCIÓN 5 — :root (tema claro, modo por defecto)
================================================================

  Define los valores de todas las variables CSS para el modo CLARO.
  Usa el espacio de color oklch (más perceptualmente uniforme que hex/hsl).

  Variables clave:
    --background: oklch(1 0 0)       → blanco puro
    --foreground: oklch(0.145 0 0)   → casi negro
    --primary: oklch(0.205 0 0)      → muy oscuro
    --secondary: oklch(0.97 0 0)     → casi blanco
    --muted: oklch(0.97 0 0)         → gris muy claro
    --destructive: oklch(0.577...)   → rojo para errores
    --border: oklch(0.922 0 0)       → gris claro para bordes
    --radius: 0.625rem               → border-radius base (≈ 10px)

================================================================
SECCIÓN 6 — .dark (tema oscuro)
================================================================

  Los mismos nombres de variables pero con valores oscuros.
  Se activan cuando algún ancestro tiene clase "dark".

  Diferencias clave con el tema claro:
    --background: oklch(0.145 0 0)   → casi negro
    --foreground: oklch(0.985 0 0)   → casi blanco
    --primary: oklch(0.922 0 0)      → casi blanco (invertido)
    --border: oklch(1 0 0 / 10%)     → blanco semitransparente
    --input: oklch(1 0 0 / 15%)      → blanco más opaco

================================================================
SECCIÓN 7 — @layer base
================================================================

  * { @apply border-border outline-ring/50; }
  → Todos los elementos tienen el color de borde y outline del tema.

  body { @apply bg-background text-foreground; }
  → El body usa las variables de fondo y texto del tema activo.

  html { @apply font-sans; }
  → Todo el sitio usa Geist Variable como fuente por defecto.

================================================================
