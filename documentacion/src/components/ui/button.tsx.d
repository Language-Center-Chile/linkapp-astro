================================================================
ARCHIVO: src/components/ui/button.tsx
PROPÓSITO: Componente de botón de shadcn/ui con múltiples variantes
           y tamaños. Generado por shadcn. Se usa como base para
           botones en partes de la UI que usen React.
================================================================

¿QUÉ ES SHADCN/UI?
  shadcn/ui es una colección de componentes React de alta calidad.
  No es una librería instalada como dependencia tradicional, sino
  que el código se copia directamente al proyecto (src/components/ui/).
  Esto significa que puedes modificarlo libremente.

================================================================
LIBRERÍAS USADAS
================================================================

  import { cva, type VariantProps } from "class-variance-authority"
  → cva (class-variance-authority) es una utilidad que genera
    clases CSS de Tailwind de forma organizada según variantes.
    Permite definir "si variant=outline, usa estas clases; si es ghost, estas otras".

  import { Slot } from "radix-ui"
  → Slot de Radix permite que el componente Button "se fusione" con
    otro elemento (asChild=true). Por ejemplo, si pasas asChild y
    un <a> como hijo, el Button aplica sus estilos al <a> en vez
    de renderizar un <button>. Útil para links con estilo de botón.

  import { cn } from "@/lib/utils"
  → Función que combina clases de Tailwind evitando conflictos.
    Ver utils.ts.d para más detalles.

================================================================
VARIANTES DISPONIBLES
================================================================

  variant:
  ┌─────────────┬────────────────────────────────────────────────┐
  │ default     │ Fondo oscuro, texto claro (botón principal)    │
  │ outline     │ Borde visible, fondo transparente              │
  │ secondary   │ Fondo gris secundario                         │
  │ ghost       │ Sin fondo, solo cambia en hover               │
  │ destructive │ Rojo suave (para acciones peligrosas)         │
  │ link        │ Como un <a>, con subrayado en hover           │
  └─────────────┴────────────────────────────────────────────────┘

  size:
  ┌──────────┬────────────────────────────────────────────────────┐
  │ default  │ Altura 8 (32px), padding horizontal estándar      │
  │ xs       │ Altura 6, texto muy pequeño                       │
  │ sm       │ Altura 7, texto pequeño                           │
  │ lg       │ Altura 9, más grande que default                  │
  │ icon     │ Cuadrado 8x8 (para botones de solo ícono)        │
  │ icon-xs  │ Cuadrado 6x6                                      │
  │ icon-sm  │ Cuadrado 7x7                                      │
  │ icon-lg  │ Cuadrado 9x9                                      │
  └──────────┴────────────────────────────────────────────────────┘

================================================================
CLASES BASE (siempre aplicadas sin importar variante)
================================================================

  inline-flex shrink-0 items-center justify-center
  → Flex horizontal, centrado, no se encoge.

  rounded-lg border border-transparent
  → Bordes redondeados, borde transparente por defecto
    (algunas variantes lo hacen visible).

  text-sm font-medium whitespace-nowrap
  → Texto pequeño, semibold, sin salto de línea.

  transition-all outline-none select-none
  → Transiciones suaves, sin outline al hacer foco por defecto
    (tiene focus-visible: en su lugar para accesibilidad).

  focus-visible:ring-3 focus-visible:ring-ring/50
  → Al navegar con teclado, muestra un anillo de foco accesible.

  disabled:pointer-events-none disabled:opacity-50
  → Cuando está deshabilitado: no reacciona a clics, semitransparente.

  aria-invalid:border-destructive aria-invalid:ring-destructive/20
  → Si el campo que activa el botón tiene error, se pone rojo.

================================================================
FUNCIÓN Button
================================================================

  function Button({ className, variant, size, asChild, ...props })
  → Los props principales más cualquier prop nativo de <button>
    (onClick, type, disabled, etc.) gracias al tipo ComponentProps<"button">.

  const Comp = asChild ? Slot.Root : "button"
  → Si asChild es true, usa el Slot de Radix (fusiona con el hijo).
    Si no, usa un <button> normal.

  data-slot="button"     → Atributo para CSS/testing que identifica el tipo
  data-variant={variant} → Permite estilizar externamente según variante
  data-size={size}       → Permite estilizar externamente según tamaño

================================================================
EXPORTACIONES
================================================================

  export { Button, buttonVariants }
  → Se exportan ambos para poder usar buttonVariants en otros
    componentes que quieran las mismas clases sin renderizar un Button.

================================================================
