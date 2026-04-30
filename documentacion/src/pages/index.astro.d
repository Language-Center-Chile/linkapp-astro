================================================================
ARCHIVO: src/pages/index.astro
PROPÓSITO: Página principal del sitio (/)
           Presenta LinkApps con un título heroico y 3 tarjetas
           de características clave.
================================================================

================================================================
ESTRUCTURA VISUAL
================================================================

  ┌─────────────────────────────────────────────────────────────┐
  │              Organiza tu mundo digital                      │
  │                   con estilo                 ← gradiente   │
  │                                                             │
  │  LinkApp centraliza tus recursos...                         │
  └─────────────────────────────────────────────────────────────┘

  ┌──────────────────┬────────────────────┬────────────────────┐
  │  📂 Organización  │  🌍 Acceso         │  🔒 Privacidad     │
  │  Inteligente     │  Universal         │  Primero           │
  │  Estructura tus  │  Sincroniza tus    │  Sin rastreadores  │
  │  enlaces...      │  colecciones...    │  Tus datos...      │
  └──────────────────┴────────────────────┴────────────────────┘

================================================================
SECCIÓN HERO (section.text-center)
================================================================

  <h1 class="text-5xl md:text-7xl font-black ...">
    Organiza tu mundo digital<br />
    <span class="gradient-text">con estilo</span>
  </h1>
  → Título principal. En móvil es text-5xl (3rem), en desktop text-7xl (4.5rem).
    "con estilo" usa la clase gradient-text para un efecto de texto con gradiente
    (definida en global.css o en el propio componente).

  <p class="text-lg text-muted max-w-2xl mb-10">
    LinkApp centraliza tus recursos...
  </p>
  → Párrafo descriptivo. text-muted usa el color gris del tema.
    max-w-2xl limita el ancho para mejor legibilidad.

================================================================
SECCIÓN DE CARACTERÍSTICAS (grid md:grid-cols-3)
================================================================

  3 tarjetas en fila (en desktop) o apiladas (en móvil).
  Cada tarjeta:
    · p-8 bg-surface border border-border rounded-3xl → estilo base
    · hover:border-blue/50 hover:-translate-y-2 → sube 8px en hover
    · transition-all duration-300 → animación suave

  Tarjeta 1 — Organización Inteligente:
    📂 Estructura tus enlaces en carpetas personalizadas.

  Tarjeta 2 — Acceso Universal:
    🌍 Sincroniza y comparte tus colecciones con amigos.

  Tarjeta 3 — Privacidad Primero:
    🔒 Sin rastreadores. Tus datos te pertenecen.

================================================================
ESTADO ACTUAL
================================================================

  Esta página es la landing page pero está INCOMPLETA.
  Cosas que faltan a futuro:
    · Botón de CTA ("Empezar Gratis" → /register)
    · Sección de cómo funciona
    · Sección de precios (o link a /subscription)
    · Demo/capturas de pantalla del producto

================================================================
CLASES TAILWIND NOTABLES
================================================================

  text-5xl md:text-7xl  → responsive: tamaño diferente en móvil vs desktop
  font-black            → font-weight: 900 (el más grueso)
  leading-[1.1]         → line-height personalizada (espacio entre líneas muy cerrado)
  tracking-tight        → letter-spacing negativo, más compacto
  text-muted            → usa la variable --muted-foreground del tema (gris)
  max-w-2xl             → max-width: 42rem
  mb-24                 → margin-bottom: 6rem (96px)
  rounded-3xl           → border-radius: 1.5rem

================================================================
