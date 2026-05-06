================================================================
ARCHIVO: src/layouts/mainLayouts.astro
PROPÓSITO: Layout base que envuelve TODAS las páginas del sitio.
           Provee el HTML completo, los estilos globales, header,
           footer y el fondo animado con líneas flotantes.
================================================================

¿QUÉ ES UN LAYOUT EN ASTRO?
  Un layout es un componente que "envuelve" el contenido de una página.
  En vez de repetir el <html>, <head>, Header y Footer en cada página,
  los ponemos aquí una sola vez. Las páginas usan <slot /> para
  insertar su propio contenido en el lugar correcto.

================================================================
LÍNEA A LÍNEA
================================================================

  import "../styles/global.css";
  → Importa los estilos globales del proyecto (tipografía, reset, colores base).

  import Header from "../components/shared/header.astro";
  → La barra de navegación superior del sitio.

  import Footer from "../components/shared/footer.astro";
  → El pie de página del sitio.

  import FloatingLines from "@/components/shared/FloatingLines";
  → Componente React que dibuja las líneas animadas del fondo.
    Se importa sin la extensión porque puede ser .jsx o .tsx.
    El @/ es el alias de src/.

----------------------------------------------------------------

  interface Props {
    title?: string;       → Título para la pestaña del navegador
    description?: string; → Descripción para SEO (Google, redes sociales)
  }

----------------------------------------------------------------

  HTML GENERADO POR ESTE LAYOUT:

  <!doctype html>
  <html lang="es">
  → Declara que el documento es HTML5 y está en español.

  <head>
    <meta charset="UTF-8" />
    → Codificación de caracteres. Sin esto, las ñ, tildes, etc. se rompen.

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    → Hace el sitio responsive. Sin esto, en móvil se vería todo pequeño.

    <title>{Astro.props.title}</title>
    → El título de la pestaña del navegador. Viene del prop `title`.

    <link rel="icon" href="/favicon.png" type="image/png" />
    → El ícono pequeño que aparece en la pestaña del navegador.
      Debe existir un archivo favicon.png en la carpeta /public/.

    <meta name="description" content={Astro.props.description} />
    → Para SEO: los motores de búsqueda leen esto para el resumen
      de la página en los resultados de búsqueda.
  </head>

  <body>
    <div class="site-bg">
      <div class="floating-lines-wrap">
        <FloatingLines client:load ... />
      </div>
    </div>
    → El fondo animado está en un div con position:fixed detrás de todo
      (z-index:-1) para que no interfiera con el contenido.

      client:load → Esta directiva de Astro le dice que este componente
      React se hidrate (active el JavaScript) tan pronto como la página carga.
      Sin esto, el componente sería solo HTML estático y sin animaciones.

      Props de FloatingLines (personalización del fondo):
        · linesGradient       → Colores de las líneas: morado (#e945f5), gris
        · animationSpeed      → Velocidad de movimiento de las líneas (5)
        · interactive         → true = reaccionan al ratón
        · bendRadius/Strength → Curvatura de las líneas
        · mouseDamping        → Qué tan suave sigue al ratón (0.01 = muy suave)
        · parallax            → Efecto de paralaje al mover el ratón
        · parallaxStrength     → Intensidad del paralaje
        · topWavePosition     → Posición y rotación de la línea superior
        · middleWavePosition  → Posición y rotación de la línea media

    <Header />
    → Renderiza el header en la parte superior.

    <main class="site-main">
      <slot />
    </main>
    → <slot /> es el "hueco" donde se inserta el contenido de cada página.
      Por ejemplo, la página login.astro tiene su <Form> que va aquí.

    <Footer />
    → Renderiza el footer en la parte inferior.
  </body>

================================================================
ESTILOS INTERNOS DEL LAYOUT
================================================================

  .site-bg {
    position: fixed; inset: 0; z-index: -1; pointer-events: none;
  }
  → El contenedor del fondo está FIJO (no se mueve al hacer scroll),
    cubre toda la pantalla (inset:0 = top/right/bottom/left: 0),
    está detrás de todo (z-index:-1) y no captura clics del ratón.

  .floating-lines-wrap { width: 100%; height: 100%; }
  → El componente de líneas ocupa todo el contenedor del fondo.

  .site-main {
    position: relative; z-index: 1;
    min-height: calc(100vh - <altura del header> - <altura del footer>);
  }
  → El contenido principal está encima del fondo (z-index:1) y
    tiene una altura mínima para que el footer quede al fondo
    incluso cuando hay poco contenido.

================================================================
