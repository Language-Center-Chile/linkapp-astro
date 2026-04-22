================================================================
ARCHIVO: src/components/shared/footer.astro
PROPÓSITO: Pie de página que aparece en todas las páginas.
           Muestra íconos de redes sociales con efecto hover
           y el copyright del sitio.
================================================================

================================================================
ESTRUCTURA VISUAL
================================================================

  ┌─────────────────────────────────────────────────────┐
  │  [FB]  [TW]  [IG]    ← íconos de redes sociales    │
  │  Síguenos en nuestras redes     © biodiversidad.cl  │
  └─────────────────────────────────────────────────────┘

================================================================
HTML EXPLICADO
================================================================

  <div id="bloque-footer">
  → Contenedor principal del footer. Fondo muy oscuro (#170c16).

  <ul class="wrapper">
  → Lista horizontal que contiene los íconos de redes sociales.
    Usa flexbox para centrarlos.

  Cada red social es un <li class="icon facebook/twitter/instagram">:
    · <span class="tooltip">Nombre</span>  → texto que aparece al hacer hover
    · <svg>...</svg>                        → el ícono vectorial de la red

  Las tres redes presentes:
    · Facebook  → ícono del path "f" de Facebook
    · Twitter   → ícono del pájaro de Twitter
    · Instagram → ícono de la cámara de Instagram

  <div class="text">
    <span>Síguenos en nuestras redes sociales</span>
    <span id="text2">© biodiversidad.cl</span>
  </div>
  → Dos textos: el izquierdo se centra con flexbox, el derecho
    se posiciona absoluto a la derecha con right: 3vw.

  NOTA: El copyright dice "biodiversidad.cl" — puede ser un placeholder
  de un proyecto anterior que hay que actualizar a "linkApps.me".

================================================================
ESTILOS (resumen de los más importantes)
================================================================

  #bloque-footer {
    background-color: rgb(17, 12, 22); → morado muy oscuro
    color: #2272ff; → texto azul por defecto
  }

  .wrapper { justify-content: center; height: 120px; }
  → Los íconos se centran horizontalmente, con 120px de alto.

  .icon {
    border-radius: 50%;  → círculo
    background: #fff;    → fondo blanco
    box-shadow: 0 10px 10px rgba(0,0,0,0.1);
    transition: cubic-bezier(0.68,-0.55,0.265,1.55); → efecto de rebote
  }
  → Cada ícono es un círculo blanco con sombra y animación de rebote
    al hacer hover (la curva bezier crea el efecto de "saltar").

  .tooltip {
    position: absolute; top: 0;
    → Aparece encima del ícono al hacer hover.
    → Cada red tiene su propio color de fondo (.facebook → azul, etc.)
  }

  .icon:hover {
    transform: translateY(-5px); → sube el ícono 5px
    → El ícono sube y el color del tooltip y su sombra cambian.
  }

  .text { display: flex; justify-content: center; position: relative; }
  → El texto "Síguenos..." está centrado.

  .text #text2 { position: absolute; right: 3vw; top: 50%; transform: translateY(-50%); }
  → El copyright se posiciona absolutamente a la derecha, centrado verticalmente.

================================================================
