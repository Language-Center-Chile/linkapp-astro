================================================================
ARCHIVO: src/pages/login.astro
PROPÓSITO: Página de inicio de sesión (/login)
           Solo configura el layout y el formulario con los props
           correctos para el modo login
================================================================

¿QUÉ ES UNA PÁGINA EN ASTRO?
  Cualquier archivo .astro dentro de src/pages/ se convierte
  automáticamente en una ruta de tu sitio web.
  Este archivo → URL: /login

================================================================
CÓDIGO COMPLETO EXPLICADO
================================================================

  import MainLayout from '../layouts/mainLayouts.astro';
  → Importa el layout base que envuelve TODA la página.
    Da el <html>, <head>, header, footer y el fondo animado.

  import Form from '../components/form/form.astro';
  → Importa el componente de formulario reutilizable.

----------------------------------------------------------------

  <MainLayout
    title="Iniciar Sesión | LinkApps"
    description="Accede a tu cuenta en LinkApps..."
  >
  → Usa el layout pasándole:
      · title       → El texto que aparece en la pestaña del navegador
      · description → Para SEO (motores de búsqueda y redes sociales)

  <Form
    titulo="Iniciar Sesión"
    → Texto del encabezado del formulario

    input1="Email"
    → Primer campo: en modo login, input1 es el Email
      (El componente Form detecta mode="login" y lo pone como type="email")

    input2="Password"
    → Segundo campo: la contraseña

    textoBoton="Iniciar Sesión"
    → Botón principal (submit)

    textoBoton2="Registrarse"
    href2="/register"
    → Segundo botón que lleva a /register (se renderiza como <a>)

    textoBoton3="Olvidé mi contraseña"
    → Tercer botón pequeño (actualmente sin href, como placeholder)

    mode="login"
    → Le dice al componente Form que estamos en modo LOGIN.
      Esto afecta:
        · El primer campo usa name="email" y type="email"
        · El script del formulario llama a /api/auth/login
        · No aparecen los campos input3 ni input4 (email y confirmPass)
        · En error muestra el modal de credenciales incorrectas
  />

================================================================
¿QUÉ NO HACE ESTA PÁGINA?
================================================================

  Esta página es muy sencilla a propósito.
  Toda la lógica de autenticación está en:
    · form.astro   → maneja el submit y los modales de error
    · api/auth/login.ts → verifica las credenciales con Supabase

  Si quisieras añadir protección (redirigir si ya estás logueado)
  habría que agregar código en el frontmatter (---) que lea la sesión
  con Supabase y redirija con Astro.redirect("/").

================================================================
