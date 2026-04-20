mi-proyecto/
├─ public/
│  ├─ favicon.svg
│  └─ images/
│     ├─ hero.jpg
│     └─ logo.svg
├─ src/
│  ├─ assets/
│  │  └─ icons/
│  │     └─ logo.svg
│  ├─ components/
│  │  ├─ shared/
│  │  │  ├─ Header.astro
│  │  │  ├─ Footer.astro
│  │  │  ├─ Background.astro
│  │  │  └─ SeoHead.astro
│  │  ├─ ui/
│  │  │  ├─ Button.astro
│  │  │  ├─ NavButton.astro
│  │  │  ├─ Card.astro
│  │  │  ├─ Input.astro
│  │  │  ├─ AuthForm.astro
│  │  │  └─ SectionTitle.astro
│  │  └─ sections/
│  │     ├─ home/
│  │     │  ├─ Hero.astro
│  │     │  ├─ Features.astro
│  │     │  ├─ Testimonials.astro
│  │     │  └─ CTA.astro
│  │     ├─ about/
│  │     │  ├─ AboutHero.astro
│  │     │  ├─ Mission.astro
│  │     │  └─ Team.astro
│  │     ├─ contact/
│  │     │  ├─ ContactHero.astro
│  │     │  └─ ContactForm.astro
│  │     └─ subscriptions/
│  │        ├─ PricingHero.astro
│  │        └─ Plans.astro
│  ├─ layouts/
│  │  ├─ MainLayout.astro
│  │  ├─ AuthLayout.astro
│  │  └─ SimpleLayout.astro
│  ├─ pages/
│  │  ├─ index.astro
│  │  ├─ about.astro
│  │  ├─ contact.astro
│  │  ├─ subscriptions.astro
│  │  ├─ login.astro
│  │  ├─ register.astro
│  │  └─ 404.astro
│  ├─ styles/
│  │  ├─ global.css
│  │  ├─ variables.css
│  │  └─ utilities.css
│  ├─ data/
│  │  ├─ navigation.ts
│  │  ├─ features.ts
│  │  ├─ testimonials.ts
│  │  └─ plans.ts
│  └─ content/
│     └─ config.ts
├─ astro.config.mjs
├─ package.json
└─ tsconfig.json



Esta estructura funciona bien porque separa responsabilidades con claridad: rutas en pages, estructura compartida en layouts, bloques reutilizables en components, y contenido repetible en data o content. Esa organización hace que el proyecto sea más fácil de leer, escalar y mantener.

Qué hace cada carpeta
pages/
Aquí viven las rutas del sitio. En Astro, index.astro será /, about.astro será /about, contact.astro será /contact, y así sucesivamente.

Cada archivo en pages representa una página real y debería tener contenido propio, usar un layout y mantener una jerarquía semántica clara con un <h1> por página. Esa claridad es importante en sitios informativos para que el usuario sepa dónde está y qué puede hacer ahí.

layouts/
Aquí van los layouts generales. Un layout define la estructura común: <html>, <head>, estilos globales, header, footer y <slot />.

No deberías tener un layout para cada página, sino para cada tipo de página. Por ejemplo, MainLayout para páginas normales, AuthLayout para login y register, y quizá SimpleLayout para una página especial o muy minimalista.

components/shared/
Aquí pones piezas globales que pueden aparecer en varias páginas, como Header, Footer, Background o un componente SEO. Esto tiene sentido porque navegación, footer y elementos globales deben ser reutilizables y consistentes.

components/ui/
Aquí van componentes pequeños y reutilizables: botones, tarjetas, inputs, wrappers y títulos. En vez de tener card1, card2, card3, lo correcto es tener un Card.astro configurable por props.

components/sections/
Aquí van bloques grandes específicos de una página, como Hero, Features, Mission, Plans o ContactForm. Esta organización funciona bien en Astro porque pages queda limpia y solo se dedica a ensamblar secciones.

data/
Aquí puedes guardar arrays y objetos con navegación, planes, features o testimonios. Eso evita hardcodear listas dentro de cada componente y hace más simple editar contenido después.

styles/
Aquí centralizas estilos globales, variables y utilidades. En sitios informativos se recomienda una tipografía clara, jerarquía sólida, navegación simple y consistencia visual; tener un archivo global ayuda bastante a sostener eso.

Cómo se conectan
La lógica sería esta:

pages/index.astro importa MainLayout.

MainLayout.astro importa Header, Footer y estilos globales.

index.astro importa secciones como Hero, Features y CTA.

Los componentes pequeños como Button o Card se usan dentro de esas secciones.

Eso deja la arquitectura mucho más limpia, porque cada nivel hace una sola cosa. Astro funciona especialmente bien cuando pages compone y components encapsula.