================================================================
ARCHIVO: src/components/form/styles.css
PROPÓSITO: Estilos visuales del formulario, campos de entrada,
           botones y el efecto de animación "wave" en los labels
================================================================

================================================================
SECCIÓN 1 — .form (el contenedor principal del formulario)
================================================================

  display: flex; flex-direction: column; gap: 10px;
  → Los elementos dentro del formulario se apilan verticalmente
    con 10px de espacio entre cada uno.

  padding-left/right: 2em; padding-bottom: 0.4em;
  → Espacio interior horizontal de 2em, poco espacio abajo.

  background-color: #171717;
  → Fondo casi negro (gris muy oscuro).

  border-radius: 25px;
  → Esquinas muy redondeadas, aspecto moderno.

  transition: 0.4s ease-in-out;
  → Suaviza la animación del hover (transform: scale).

  max-width: 350px; margin: 2rem auto;
  → El form no crece más de 350px y se centra horizontalmente.

  .form:hover { transform: scale(1.05); border: 1px solid black; }
  → Al pasar el ratón por encima, el form se agranda un 5%
    y aparece un borde negro. Efecto visual de interactividad.

================================================================
SECCIÓN 2 — #heading (el título del formulario)
================================================================

  text-align: center; margin: 2em; color: white; font-size: 1.2em;
  → El título "Iniciar Sesión" / "Registrarse" centrado, blanco y
    con buen tamaño, con margen generoso arriba y abajo.

================================================================
SECCIÓN 3 — .field (cada fila de campo: ícono + input)
================================================================

  display: flex; align-items: center; gap: 0.5em;
  → Ícono e input lado a lado, alineados verticalmente al centro.

  border-radius: 25px; padding: 0.6em;
  → La fila tiene bordes redondeados y relleno interno.

  background-color: #171717;
  box-shadow: inset 2px 5px 10px rgb(5 5 5);
  → Mismo fondo oscuro, con sombra INTERIOR (inset) para dar
    efecto de hundimiento/profundidad al campo.

  .input-icon { height: 1.3em; width: 1.3em; fill: white; }
  → Los íconos SVG son pequeños y blancos.

================================================================
SECCIÓN 4 — .input-field (el texto dentro del input)
================================================================

  background: none; border: none; outline: none;
  → Sin fondo, sin borde, sin resaltado al hacer clic.
    Hereda el fondo oscuro del contenedor .field.

  width: 100%; color: #d3d3d3;
  → Ocupa todo el ancho disponible. Texto gris claro.

================================================================
SECCIÓN 5 — .btn y botones (.button1, .button2, .button3)
================================================================

  .btn { display: flex; justify-content: center; flex-direction: row; margin-top: 2.5em; gap: 0.5em; }
  → Los botones se colocan en fila, centrados, con espacio entre ellos
    y un margen superior de 2.5em para separarse de los inputs.

  .button1 → El botón principal:
    · Fondo #252525 (gris oscuro), texto blanco, bordes redondeados
    · Hover: fondo negro total

  .button2 → Botón secundario (ej: "Registrarse" en la página de login):
    · display: inline-block (puede ser <a> o <button>)
    · Más padding horizontal (2.3em) que button1
    · Sin decoración de texto si es <a>
    · Mismo color de fondo y hover

  .button3 → Botón terciario (ej: "Olvidé mi contraseña"):
    · Sin relleno, sin fondo, solo texto
    · Color gris claro, se vuelve blanco en hover
    · Se posiciona al centro

================================================================
SECCIÓN 6 — .wave-group (el contenedor del input con animación)
================================================================

  Este es el efecto visual más elaborado del proyecto.

  .wave-group { position: relative; }
  → Contenedor relativo para que el <label> se posicione sobre el input.

  .wave-group .input { ... }
  → El campo real, con borde inferior visible (border-bottom: 1px solid #ccc)
    y texto blanco. Sin fondo, sin borde lateral. El :focus añade
    un borde inferior de color azul (highlight).

  .wave-group .bar { ... }
  → Una línea azul que aparece debajo del input al hacer foco.
    Se expande de 0 a 100% con una animación CSS.

  .wave-group .label { ... position: absolute; ... }
  → El label flota sobre el input. Cuando el input tiene contenido o
    está en foco, el label sube y se hace más pequeño (CSS :focus/:valid).

  .wave-group .label-char { ... display: inline-block; ... }
  → Cada letra del label es un span individual con:
      · transition: 0.2s ease
      · animation-delay: calc(var(--index) * 0.05s)
    Esto hace que cuando el input recibe foco, las letras suban
    una a una con un pequeño retraso escalonado = efecto "wave" (ola).

================================================================
SECCIÓN 7 — Estilos del modal (en form.astro <style>)
================================================================

  NOTA: Los estilos de los modales NO están en styles.css sino en
  la sección <style> dentro del propio form.astro. Ver form.astro.d.

================================================================
