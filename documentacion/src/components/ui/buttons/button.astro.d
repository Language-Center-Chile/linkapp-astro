================================================================
ARCHIVO: src/components/ui/buttons/button.astro
PROPÓSITO: Botón CTA (Call To Action) principal del sitio.
           Tiene un fondo negro con un aura de gradiente brillante
           (violeta → rosa → amarillo) que se intensifica al hacer hover.
           Siempre lleva a /register.
================================================================

================================================================
CÓMO FUNCIONA EL EFECTO VISUAL
================================================================

  El botón usa dos capas superpuestas:

  CAPA 1 — El aura de gradiente (div absoluto detrás del botón):
    class="absolute inset-0 bg-gradient-to-r from-indigo-500 via-pink-500 to-yellow-400 blur-lg"
    → Un div que cubre el mismo área del botón, con un gradiente
      de 3 colores y un blur para hacer el efecto de "glow".
    → En reposo: opacity-60 (semitransparente)
    → En hover: opacity-100 + duration-200 (se vuelve completamente visible)

  CAPA 2 — El botón real encima:
    class="relative bg-gray-900 text-white rounded-xl px-8 py-3"
    → El botón oscuro que se superpone sobre el glow.
    → En hover: hover:bg-gray-800 + hover:-translate-y-0.5
      (se oscurece un poco y sube 2px)

================================================================
HTML EXPLICADO
================================================================

  <div class="relative inline-flex items-center justify-center gap-4 group">
  → Contenedor con clase "group" para activar el hover en hijos
    desde el contenedor padre (group-hover:opacity-100).
    relative permite que la capa de aura (absolute) se posicione relativa a él.

  CAPA 1 — el aura:
    <div class="absolute inset-0 duration-1000 opacity-60 transitiona-all
                bg-gradient-to-r from-indigo-500 via-pink-500 to-yellow-400
                rounded-xl blur-lg filter
                group-hover:opacity-100 group-hover:duration-200">
    </div>
    → Transición lenta (1000ms) para salir del hover, rápida (200ms) al entrar.

  CAPA 2 — el botón:
    <a role="button" href="register" class="group relative ...">
      Crea una Cuenta
      <svg>...</svg>   ← flecha →
    </a>
    · Es un <a> con role="button" para semántica.
    · href="register" → va a /register (sin barra inicial).
    · La flecha SVG tiene dos partes:
        - El palo horizontal (opacity-0 en reposo, visible en hover)
        - La punta de flecha (se desplaza 3px a la derecha en hover)

================================================================
CLASES DE TAILWIND USADAS
================================================================

  bg-gradient-to-r          → gradiente de izquierda a derecha
  from-indigo-500           → comienza en azul índigo
  via-pink-500              → pasa por rosa
  to-yellow-400             → termina en amarillo
  blur-lg                   → desenfoque grande (crea el glow)
  rounded-xl                → bordes muy redondeados
  group-hover:opacity-100   → el aura se vuelve opaco cuando el grupo hace hover
  hover:-translate-y-0.5    → el botón sube 2px en hover
  hover:shadow-gray-600/30  → sombra gris semitransparente en hover

================================================================
PROPS
================================================================

  Este componente NO tiene props explícitos en el código actual.
  El texto "Crea una Cuenta" y el href="/register" están hardcodeados.
  Si quisieran hacerlo reutilizable, habría que añadir:
    const { text, href } = Astro.props;

================================================================
