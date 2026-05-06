================================================================
ARCHIVO: src/components/ui/buttons/button-nav.astro
PROPÓSITO: Botón de navegación con efecto de texto animado en hover.
           Las letras cambian de azul a rojo con un efecto de "barrido".
           Se usa en el header para los links Nosotros/Contacto/Suscripción.
================================================================

================================================================
CÓMO FUNCIONA EL EFECTO
================================================================

  El botón tiene texto azul en reposo. Al hacer hover:
    1. Una línea roja se expande de izquierda a derecha debajo del texto.
    2. El texto encima de esa línea cambia de azul a rojo.

  El truco CSS:
    · El texto visible es el <p> con color azul (--primary-color).
    · Hay un pseudo-elemento p::before con content: attr(data-text)
      que duplica el texto en color rojo (--hovered-color).
    · Este pseudo-elemento tiene width: 0% y overflow: hidden.
    · En hover, su width hace transición a 100% → revela el texto rojo.
    · Simultáneamente, button::after (la línea) crece de width:0 a 100%.

================================================================
HTML Y PROPS
================================================================

  const { text } = Astro.props;
  → Solo recibe una prop: el texto del botón.

  <button data-text={text}>
    <p>{text}</p>
  </button>
  → data-text es necesario para el CSS: el pseudo-elemento ::before
    usa content: attr(data-text) para leer ese atributo y duplicar
    el texto sin repetirlo en el HTML.

================================================================
ESTILOS CLAVE
================================================================

  button {
    --primary-color: #2272FF;    → azul
    --hovered-color: #c84747;    → rojo
    font-size: 20px; font-weight: 600;
    background: none; border: none;
    display: flex; align-items: center;
  }

  button p { color: var(--primary-color); } → texto azul por defecto

  button::after {
    content: "";
    position: absolute; bottom: -7px; left: 0;
    width: 0; height: 2px;
    background: var(--hovered-color);
    transition: 0.3s ease-out;
  }
  → La línea roja debajo del texto, invisible al inicio (width: 0).

  button p::before {
    content: attr(data-text);
    position: absolute; inset: 0;
    color: var(--hovered-color);
    width: 0%; overflow: hidden;
    transition: 0.3s ease-out;
  }
  → El texto rojo superpuesto, oculto al inicio.

  button:hover::after { width: 100%; }
  → En hover, la línea crece al 100%.

  (Se asume también button:hover p::before { width: 100%; } para el texto)

================================================================
DIFERENCIA CON button.astro (el otro botón de /ui/buttons/)
================================================================

  button-nav.astro → Texto animado, sin fondo, para links de navegación
  button.astro     → Botón CTA con gradiente brillante, para "Crear Cuenta"

================================================================
