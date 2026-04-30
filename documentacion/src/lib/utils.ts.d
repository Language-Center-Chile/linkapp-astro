================================================================
ARCHIVO: src/lib/utils.ts
PROPÓSITO: Función utilitaria para combinar clases CSS de Tailwind
           sin conflictos. Generada por shadcn/ui.
================================================================

================================================================
LIBRERÍAS USADAS
================================================================

  import { clsx, type ClassValue } from "clsx"
  → clsx es una utilidad que combina strings, arrays y objetos en
    una sola cadena de clases CSS.
    Ejemplos:
      clsx("foo", "bar")             → "foo bar"
      clsx("foo", { bar: true })     → "foo bar"
      clsx("foo", { bar: false })    → "foo"
      clsx(["foo", undefined, "bar"])→ "foo bar"

  import { twMerge } from "tailwind-merge"
  → twMerge es una utilidad que RESUELVE CONFLICTOS entre clases
    de Tailwind. Si pasas "text-red-500 text-blue-500", en CSS normal
    gana el que está más abajo en el CSS. Con twMerge, gana el ÚLTIMO
    que pasas, como se esperaría.
    Ejemplo:
      twMerge("px-4 px-8")    → "px-8"    (el último gana)
      twMerge("text-red text-blue") → "text-blue" (el último gana)

================================================================
FUNCIÓN cn (className)
================================================================

  export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs))
  }

  → Recibe cualquier número de argumentos (strings, objetos, arrays).
  → Primero los procesa con clsx para convertirlos a un string limpio.
  → Luego los pasa por twMerge para resolver conflictos de Tailwind.
  → Devuelve un string con todas las clases unidas y sin duplicados.

  EJEMPLO DE USO:
    cn("px-4 py-2", isActive && "bg-blue-500", className)
    → Si isActive es true:  "px-4 py-2 bg-blue-500"
    → Si isActive es false: "px-4 py-2"
    → Si el usuario pasa className="px-8", resulta: "py-2 bg-blue-500 px-8"
      (px-4 fue reemplazado por px-8 porque twMerge detectó el conflicto)

================================================================
¿POR QUÉ NECESITAMOS ESTO?
================================================================

  En React y componentes UI con Tailwind es muy común que quieras:
    · Tener clases base del componente
    · Más clases condicionales según props
    · Más clases que el usuario puede pasar desde fuera (className prop)

  Sin cn(), si el usuario pasa "px-8" para sobreescribir el "px-4"
  del componente, ambas clases estarían en el HTML y la que gane
  depende del orden en el CSS compilado (impredecible).

  Con cn(), twMerge detecta que son la misma propiedad CSS (padding-x)
  y solo deja la última.

================================================================
DÓNDE SE USA EN EL PROYECTO
================================================================

  · src/components/ui/button.tsx → cn(buttonVariants({ variant, size, className }))

================================================================
