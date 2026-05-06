================================================================
ARCHIVO: src/pages/register.astro
PROPÓSITO: Página de registro de nuevos usuarios (/register)
           Configura el formulario con 4 campos para el modo registro
================================================================

¿QUÉ DIFERENCIA HAY CON login.astro?
  · Tiene 4 campos en vez de 2 (Username, E-mail, Password, Confirm Password)
  · Usa mode="register" (por defecto, podría omitirse)
  · No tiene botones extra (sin textoBoton2 ni textoBoton3)
  · El submit llama a /api/auth/register en vez de /api/auth/login

================================================================
CÓDIGO EXPLICADO
================================================================

  import MainLayout from "../layouts/mainLayouts.astro";
  import Form from "../components/form/form.astro";
  → Igual que login.astro: layout base y componente de formulario.

----------------------------------------------------------------

  <MainLayout
    title="Registrarse | LinkApps"
    description="Crea tu cuenta en LinkApps..."
  >
  → Layout con título y descripción para la pestaña del navegador y SEO.

  <Form
    titulo="register"
    → El título que muestra el formulario arriba.
      NOTA: Aquí dice "register" en minúsculas, lo que aparecerá literalmente
      en la página. Podrías cambiarlo a "Crear cuenta" o "Registrarse".

    input1="Username"
    → Primer campo: en modo register, input1 es el nombre de usuario
      (type="text", name="username"). El SVG del ícono es una @ (arroba).

    input2="Password"
    → Tercer campo (visualmente): la contraseña principal
      (type="password", name="password")

    input3="E-mail"
    → Segundo campo (visualmente): el email del usuario
      (type="email", name="email")
      NOTA: El orden visual es: Username → E-mail → Password → Confirm Password
      aunque en el código input3 viene después de input2.

    input4="Confirm Password"
    → Cuarto campo: confirmación de la contraseña
      (type="password", name="confirmPassword")
      El script de form.astro compara este valor con input2.
      Si no coinciden, muestra el modal de contraseñas no coinciden.

    textoBoton="Registrarse"
    → Solo hay un botón principal (submit).
      No hay textoBoton2 ni textoBoton3 en esta página.
  />

================================================================
ORDEN VISUAL DE LOS CAMPOS EN PANTALLA
================================================================

  La posición de los campos en el formulario está determinada por
  el orden en que form.astro los renderiza, NO por el orden de los props:

  1. input1  → Username      (siempre primero)
  2. input3  → E-mail        (opcional, aparece si se pasa)
  3. input2  → Password      (siempre después del bloque username/email)
  4. input4  → Confirm Pass  (opcional, aparece si se pasa)

================================================================
VALIDACIONES QUE OCURREN EN ESTE FORMULARIO
================================================================

  Todas las validaciones las hace el script de form.astro en el navegador
  ANTES de enviar la petición al servidor:

  1. ¿Algún campo está vacío?
     → No envía, muestra "Completa todos los campos" en form-message

  2. ¿Password !== Confirm Password?
     → No envía, muestra modal "password-modal"

  3. ¿Password tiene menos de 6 caracteres?
     → No envía, muestra modal "short-password-modal"

  4. Si todo está bien → envía a /api/auth/register
     → Si rate limit → muestra modal "rate-limit-modal"
     → Si otro error → muestra el mensaje en form-message
     → Si OK → muestra modal de email y redirige a /login

================================================================
