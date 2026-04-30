================================================================
ARCHIVO: src/components/ui/cards/carta.astro
PROPÓSITO: Tarjeta contenedora con borde de gradiente animado.
           Envuelve al componente Texto y añade el efecto visual exterior.
           Se usa en la página de suscripción.
================================================================

================================================================
RELACIÓN CON texto.astro
================================================================

  carta.astro es el CONTENEDOR con el estilo visual del borde.
  texto.astro es el CONTENIDO con los datos (título, precio, features).

  El componente está partido en dos para separar responsabilidades:
    carta.astro → apariencia exterior (borde gradiente, sombra verde)
    texto.astro → contenido interior (texto, lista, botón)

================================================================
PROPS (se reciben y se pasan a Texto)
================================================================

  Astro.props.title       → nombre del plan (ej: "Comunidad LinkApps")
  Astro.props.description → descripción breve del plan
  Astro.props.price       → precio (ej: "FREE", "$5.99")
  Astro.props.features    → array de características (ej: ["✓ ...", "✓ ..."])
  Astro.props.texto       → texto del botón de acción (ej: "Empieza Ahora")

  Todos se re-pasan directamente al componente <Texto>.

================================================================
HTML EXPLICADO
================================================================

  <div class="card">         ← el contenedor exterior (gradiente)
    <div class="card2">      ← el contenedor interior oscuro
      <Texto ... />          ← el contenido
    </div>
  </div>

================================================================
EFECTO VISUAL — CÓMO FUNCIONA EL BORDE GRADIENTE
================================================================

  .card {
    background-image: linear-gradient(163deg, #00ff75 0%, #3700ff 100%);
    border-radius: 20px;
  }
  → El contenedor exterior tiene un gradiente verde→morado como fondo.
    Como el contenedor interior (.card2) es casi del mismo tamaño,
    solo se ve el borde del gradiente alrededor.

  .card2 {
    background-color: #1a1a1a;  → oscuro casi negro
    border-radius: 20px;
    width: 190px;
  }
  → El interior cubre casi todo el gradiente, dejando solo el
    borde visible. Es como un "truco" de borde gradiente usando
    dos capas de divs.

  .card2:hover { transform: scale(0.98); }
  → Al hacer hover, el interior se reduce levemente, mostrando más
    del borde gradiente. Da sensación de que la carta "respira".

  .card:hover {
    box-shadow: 0px 0px 30px 1px rgba(0, 255, 117, 0.30);
  }
  → Al hacer hover, aparece un glow verde difuso alrededor de la carta.

================================================================
EJEMPLO DE USO (en subscription.astro)
================================================================

  <Carta
    title="Comunidad LinkApps"
    description="Perfil básico personal con acceso a funciones limitadas."
    price="FREE"
    pricedescriptor={null}
    texto="Empieza Ahora"
    features={['✓ Perfil básico personal', '✓ Hasta 3 carpetas']}
  />

================================================================
