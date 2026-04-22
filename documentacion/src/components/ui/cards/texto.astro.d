================================================================
ARCHIVO: src/components/ui/cards/texto.astro
PROPÓSITO: Contenido interno de las tarjetas de suscripción.
           Muestra título, precio, descripción, lista de features y botón.
           Es usado por carta.astro que le da el estilo exterior.
================================================================

================================================================
PROPS
================================================================

  interface Props {
    title: string;         → Nombre del plan (ej: "Plus Para Creadores")
    description: string;   → Descripción del plan
    price: string;         → Precio (ej: "FREE", "$5.99", "$9.99")
    pricedescriptor?: string; → Frecuencia (ej: "/Mensual"). Opcional.
    features: string[];    → Array de beneficios incluidos
    texto?: string;        → Texto del botón (ej: "Elige Plus")
  }

================================================================
ESTRUCTURA HTML
================================================================

  <div class="card">

    <p class="title">{title}</p>
    → Nombre del plan, texto grande y blanco centrado.

    <div class="pricecontainer">
      <p class="price">{price}</p>
      <p class="pricedescriptor">{pricedescriptor}</p>
    </div>
    → Precio en grande con fondo más oscuro (#1e1e1e) para destacarlo.
      pricedescriptor (ej: "/Mensual") se muestra debajo en gris.

    <p class="includes">{description}</p>
    → Descripción breve en gris, tamaño pequeño.

    <ul class="benefitlist">
      {features.map(feature => <li>{feature}</li>)}
    </ul>
    → Lista de beneficios. Cada feature es un string que ya
      incluye el "✓" al inicio (ej: "✓ Links ilimitados...").

    <div class="btncontainer">
      <button>{texto}</button>
    </div>
    → Botón de acción. Actualmente es un <button> sin funcionalidad
      (solo visual). En el futuro debería llevar al proceso de pago.

================================================================
ESTILOS CLAVE
================================================================

  .card {
    width: 190px;
    background: rgb(45, 45, 45);  → gris oscuro
    border-radius: 20px;
    padding-bottom: 1em;
    height: 100%;                 → ocupa toda la altura disponible
    display: flex; flex-direction: column;
  }
  → La carta crece en altura para igualar a sus hermanas en flex.

  .title { font-size: x-large; color: rgb(200,200,200); }
  → Título grande, gris claro.

  .pricecontainer { background-color: rgb(30,30,30); }
  → Fondo aún más oscuro para el precio, creando una sección diferenciada.

  .price { font-size: x-large; color: rgb(180,180,180); }
  .pricedescriptor { color: rgb(118,118,118); font-size: medium; }
  → El precio es grande, el descriptor (período) es pequeño y gris.

  .includes { color: rgb(110,110,110); font-size: small; }
  → Descripción en gris medio, pequeño.

  .benefitlist { color: rgb(85,85,85); list-style: none; font-size: small; }
  → Lista sin bullets (los "✓" van incluidos en el texto de los features).

  .btncontainer { margin-top: auto; } → empuja el botón al fondo
  button { background: white; color: black; border-radius: 0 0 20px 20px; }
  → El botón tiene bordes redondeados solo abajo para integrarse
    con la carta redondeada.

================================================================
LOS 3 PLANES DE SUSCRIPCIÓN
================================================================

  Plan FREE        → "Comunidad LinkApps"
    · Perfil básico personal
    · Hasta 3 carpetas con 2 enlaces activos

  Plan $5.99/mes   → "Plus Para Creadores"
    · Links ilimitados en carpetas
    · Código QR premium
    · Carpetas ilimitadas

  Plan $9.99/mes   → "Business Para Empresas"
    · Todo lo del plan Plus
    · Dominio personalizado
    · Analíticas avanzadas
    · Eliminación de marca

================================================================
