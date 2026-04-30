================================================================
ARCHIVO: src/pages/subscription.astro
PROPÓSITO: Página de planes de suscripción (/subscription)
           Muestra las 3 tarjetas de precios: Free, Plus y Business
================================================================

================================================================
ESTRUCTURA VISUAL
================================================================

  ┌──────────────────────────────────────────────────────────────┐
  │  ┌────────────┐   ┌────────────┐   ┌────────────┐           │
  │  │  Comunidad │   │    Plus    │   │  Business  │           │
  │  │  LinkApps  │   │  Creadores │   │  Empresas  │           │
  │  │            │   │            │   │            │           │
  │  │    FREE    │   │   $5.99    │   │   $9.99    │           │
  │  │  /-----/   │   │  /Mensual  │   │  /Mensual  │           │
  │  │            │   │            │   │            │           │
  │  │ ✓ Perfil   │   │ ✓ Links ∞  │   │ ✓ Todo Plus│           │
  │  │ ✓ 3 carpetas│  │ ✓ QR       │   │ ✓ Dominio  │           │
  │  │            │   │ ✓ Carpetas ∞│  │ ✓ Analytics│           │
  │  │            │   │            │   │ ✓ Sin marca│           │
  │  │[Empieza Ya]│   │[Elige Plus]│   │[Elige Bus.]│           │
  │  └────────────┘   └────────────┘   └────────────┘           │
  └──────────────────────────────────────────────────────────────┘

================================================================
COMPONENTES USADOS
================================================================

  import Carta from '../components/ui/cards/carta.astro';
  → Tarjeta con borde de gradiente verde-morado y glow en hover.
    Internamente usa texto.astro para el contenido.

================================================================
LOS 3 PLANES
================================================================

  PLAN FREE — "Comunidad LinkApps"
    price: "FREE"
    pricedescriptor: null  → no muestra período (es gratis)
    features:
      ✓ Perfil básico personal
      ✓ Hasta 3 carpetas con 2 enlaces activos
    texto: "Empieza Ahora"

  PLAN $5.99/MES — "Plus Para Creadores"
    price: "$5.99"
    pricedescriptor: "/Mensual"
    features:
      ✓ Links ilimitados en las carpetas
      ✓ Código QR premium para compartir enlaces
      ✓ Carpetas ilimitadas con links activos
    texto: "Elige Plus"

  PLAN $9.99/MES — "Business Para Empresas"
    price: "$9.99"
    pricedescriptor: "/Mensual"
    features:
      ✓ Todo lo del plan Plus
      ✓ Dominio personalizado
      ✓ Analíticas avanzadas
      ✓ Eliminación de marca
    texto: "Elige Business"

================================================================
LAYOUT DEL CONTENEDOR
================================================================

  <div class="cards-container">
  .cards-container {
    display: flex;
    flex-wrap: wrap;       → en pantallas pequeñas se apilan
    justify-content: center;
    align-items: stretch;  → todas las tarjetas tienen la misma altura
    gap: 2rem;
    padding: 2rem;
  }

  align-items: stretch → hace que las 3 tarjetas tengan la misma
  altura aunque tengan distinto número de features. El botón de
  cada carta siempre queda en la parte inferior (margin-top: auto
  en .btncontainer de texto.astro).

================================================================
ESTADO ACTUAL Y FUTURO
================================================================

  Los botones de las tarjetas (Empieza Ahora, Elige Plus, etc.)
  son solo visuales. No tienen funcionalidad de pago.

  A futuro habría que integrar:
    · Stripe o MercadoPago para el flujo de pago
    · Lógica de suscripción en Supabase (tabla subscriptions)
    · Redirect post-pago a una página de confirmación
    · Protección de rutas para features de pago

================================================================
