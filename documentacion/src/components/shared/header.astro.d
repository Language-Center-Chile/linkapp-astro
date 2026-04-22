================================================================
ARCHIVO: src/components/shared/header.astro
PROPÓSITO: Barra de navegación superior que aparece en todas las páginas
================================================================

================================================================
ESTRUCTURA VISUAL
================================================================

  [ Logo ]  ---  [ Nosotros ]  [ Contacto ]  [ Suscripción ]  ---  [ Crear Cuenta ]

  · El logo está a la izquierda y lleva a "/"
  · Los links de navegación están en el centro (se empujan a la
    derecha del logo con margin-left: auto)
  · El botón "Crear Cuenta" está a la derecha

================================================================
COMPONENTES IMPORTADOS
================================================================

  import Button from "../ui/buttons/button-nav.astro";
  → El botón de texto animado que se usa para los links de navegación
    (Nosotros, Contacto, Suscripción). Tiene un efecto de subrayado
    rojo que se expande al pasar el cursor.

  import Button_CrearCuenta from "../ui/buttons/button.astro";
  → El botón con efecto de gradiente brillante para el CTA principal
    "Crear Cuenta". Lleva a /register.

================================================================
HTML EXPLICADO
================================================================

  <nav>
  → El contenedor principal de la barra de navegación.

  <a id="logo" href="/">
    <img src="/favicon.png" alt="LinkApps logo" height="32" />
  </a>
  → El logo del sitio. La imagen viene de /public/favicon.png
    (la misma imagen que aparece en la pestaña del navegador).
    El alt es importante para accesibilidad y SEO.

  <div id="nav-links">
    <a href="/about">   <Button text="Nosotros" />   </a>
    <a href="/contact"> <Button text="Contacto" />   </a>
    <a href="/subscription"> <Button text="Suscripción" /> </a>
  </div>
  → Los tres links de la navegación. Cada uno envuelve un <Button>
    de navegación dentro de un <a>.
    text-decoration: none; elimina el subrayado predeterminado del <a>.
    NOTA: /contact no tiene página aún (trabajo futuro).

  <a href="/register" id="btn-iniciar-session">
    <Button_CrearCuenta text="Crear Cuenta" />
  </a>
  → El botón de llamada a la acción principal. Lleva al registro.
    (El id dice "iniciar-session" pero en realidad lleva a registro,
    podría renombrarse en el futuro.)

================================================================
ESTILOS
================================================================

  nav {
    background-color: black;
    display: flex;
    align-items: center;
    padding: 0.5rem 1rem;
  }
  → La nav es un flex container horizontal. Todos los elementos
    quedan alineados verticalmente al centro. Fondo negro.

  #logo img { height: 60px; padding-left: 25px; }
  → El logo es más grande que los 32px del atributo HTML.
    El padding-left da espacio al borde izquierdo.

  #nav-links {
    display: flex;
    gap: 1.5rem;
    margin-left: auto;
  }
  → Los links se ponen en fila con espacio entre ellos.
    margin-left: auto los empuja al extremo derecho del espacio disponible
    (después del logo), creando el espacio visual central.

  #btn-iniciar-session { padding-left: 25px; }
  → Espacio entre los links de nav y el botón de crear cuenta.

================================================================
