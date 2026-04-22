================================================================
ARCHIVO: src/components/form/form.astro
PROPÓSITO: Componente de formulario REUTILIZABLE que funciona tanto
           para Login como para Registro, con sistema de modales de error
================================================================

¿QUÉ ES UN COMPONENTE ASTRO?
  Es un bloque de interfaz que puedes usar en varias páginas pasándole
  "props" (parámetros) para personalizarlo. Como una función, pero
  para HTML. El archivo tiene 3 secciones:
    1. Frontmatter (---): código TypeScript que corre en el servidor
    2. HTML: la estructura visual
    3. <script>: código JavaScript que corre en el NAVEGADOR
    4. <style>: estilos CSS solo para este componente

================================================================
SECCIÓN 1 — FRONTMATTER (código de servidor)
================================================================

  interface Props { ... }
  → Define qué parámetros acepta este componente cuando lo usas.
    Los opcionales tienen ? al final.

    · titulo        → El texto grande arriba del formulario
    · input1        → Label del primer campo (Username o Email según modo)
    · input2        → Label del campo de contraseña
    · input3?       → Label del tercer campo (Email, solo en registro)
    · input4?       → Label para "Confirmar contraseña" (solo en registro)
    · textoBoton    → Texto del botón principal (submit)
    · textoBoton2?  → Texto del segundo botón (opcional, ej: "Registrarse")
    · textoBoton3?  → Texto del tercer botón (opcional, ej: "Olvidé contraseña")
    · href2?        → URL a la que lleva el botón 2
    · href3?        → URL a la que lleva el botón 3
    · mode?         → "login" | "register" — controla el comportamiento

  const { titulo, input1, ... mode = "register" } = Astro.props;
  → Destructuramos los props. `mode = "register"` significa que si
    no se pasa mode, por defecto es "register".

================================================================
SECCIÓN 2 — HTML (estructura visual)
================================================================

  <form id="auth-form" data-mode={mode}>
  → El formulario principal. Le ponemos data-mode para que el script
    del navegador sepa si estamos en modo login o registro.

  PRIMER CAMPO (input1):
    → Si mode === "login": muestra campo Email (type="email", name="email")
    → Si mode === "register": muestra campo Username (type="text", name="username")
    → Cada campo tiene un ícono SVG decorativo a la izquierda.
    → Usa el componente <Input> (de input.astro) para el campo en sí.

  CAMPO input3 (solo si se pasa):
    → En modo registro, este es el campo de Email.
    → Solo aparece si el padre pasó la prop input3.
    → Tiene name="email" y type="email" siempre.

  CAMPO input2 (contraseña):
    → Siempre aparece. Es el campo de Password.
    → name="password", type="password".

  CAMPO input4 (solo si se pasa):
    → En modo registro, es el campo de Confirmar Contraseña.
    → name="confirmPassword", type="password".

  BOTONES:
    → <Button textoBoton={textoBoton} type="submit" /> → botón principal
    → textoBoton2 (opcional) → segundo botón (puede ser link con href)
    → textoBoton3 (opcional) → tercer botón (siempre link)

  <p id="form-message"></p>
  → Párrafo vacío donde el script puede escribir mensajes de estado
    (ej: "¡Bienvenido!" antes de redirigir).

================================================================
SECCIÓN 3 — MODALES DE ERROR
================================================================

  Son 5 modales en total, cada uno para un tipo de error diferente:

  ┌─────────────────────────────┬──────────────────────────────────────────┐
  │ ID del modal                │ Cuándo aparece                           │
  ├─────────────────────────────┼──────────────────────────────────────────┤
  │ email-modal                 │ Registro exitoso con email de confirm.   │
  │ password-modal              │ Las contraseñas no coinciden             │
  │ incorrect-password-modal    │ Email/contraseña incorrectos en login    │
  │ short-password-modal        │ Contraseña tiene menos de 6 caracteres  │
  │ rate-limit-modal            │ Supabase bloqueó por demasiados intentos │
  └─────────────────────────────┴──────────────────────────────────────────┘

  Todos los modales tienen la misma estructura:
    <div class="modal-overlay" aria-hidden="true">  ← fondo oscuro
      <div class="modal-box">                       ← caja blanca central
        <div class="modal-icon"> ... SVG ... </div> ← ícono grande
        <h2>Título del error</h2>
        <p>Descripción del error</p>
        <button id="...-close">Entendido</button>   ← botón para cerrar
      </div>
    </div>

  aria-hidden="true" → Por accesibilidad: oculto para lectores de pantalla
  cuando no está activo.

  modal-overlay = fondo negro semitransparente que cubre toda la pantalla
  modal-box     = la caja centrada con el mensaje

================================================================
SECCIÓN 4 — SCRIPT (JavaScript del navegador)
================================================================

  Este código corre en el CLIENTE (navegador), no en el servidor.

  --- REFERENCIAS A ELEMENTOS DEL DOM ---

  const form    = document.getElementById("auth-form");
  → Obtiene el formulario del HTML.

  const message = document.getElementById("form-message");
  → El párrafo de mensajes de estado.

  const mode    = form?.dataset.mode ?? "register";
  → Lee el atributo data-mode del formulario para saber si es login/register.
    El ?? "register" es un fallback si no existe.

  const passwordModal            = ...getElementById("password-modal")
  const incorrectPasswordModal   = ...getElementById("incorrect-password-modal")
  const shortPasswordModal       = ...getElementById("short-password-modal")
  const rateLimitModal           = ...getElementById("rate-limit-modal")
  → Referencias a los 4 modales de error (el de email se obtiene más abajo
    porque solo se necesita al final del registro exitoso).

  --- BOTONES DE CERRAR MODALES ---

  passwordModalClose?.addEventListener("click", () => { ... quita modal-visible })
  incorrectPasswordModalClose?.addEventListener("click", () => { ... })
  shortPasswordModalClose?.addEventListener("click", () => { ... })
  rateLimitModalClose?.addEventListener("click", () => { ... })
  → Cada botón "Entendido" escucha el click y cierra su modal
    removiendo la clase modal-visible y poniendo aria-hidden="true".

  --- SUBMIT DEL FORMULARIO ---

  form?.addEventListener("submit", async (e) => {
    e.preventDefault();  ← Cancela el envío normal del formulario
                           (que haría un reload de página)

    const formData = new FormData(form);
    → Lee todos los campos del formulario como pares nombre→valor.

    ┌─── MODO LOGIN ─────────────────────────────────────────────┐
    │                                                              │
    │  const email    = formData.get("email")                     │
    │  const password = formData.get("password")                  │
    │                                                              │
    │  Si faltan campos → muestra incorrect-password-modal        │
    │                                                              │
    │  fetch("POST /api/auth/login", { email, password })         │
    │    → Si !response.ok → muestra incorrect-password-modal     │
    │    → Si ok → escribe "¡Bienvenido!" y redirige a "/"        │
    └──────────────────────────────────────────────────────────────┘

    ┌─── MODO REGISTER ───────────────────────────────────────────┐
    │                                                              │
    │  const username        = formData.get("username")            │
    │  const email           = formData.get("email")               │
    │  const password        = formData.get("password")            │
    │  const confirmPassword = formData.get("confirmPassword")     │
    │                                                              │
    │  Validaciones en ORDEN (el primero que falle corta):         │
    │    1. Si algún campo vacío → mensaje en form-message         │
    │    2. Si password !== confirmPassword → password-modal       │
    │    3. Si password.length < 6 → short-password-modal         │
    │                                                              │
    │  fetch("POST /api/auth/register", { username, email, pw })  │
    │    → Si !response.ok:                                        │
    │        · Si mensaje incluye "rate limit" → rate-limit-modal  │
    │        · Sino → escribe error en form-message               │
    │    → Si ok:                                                  │
    │        · Escribe "Cuenta creada correctamente"               │
    │        · Resetea el formulario (form.reset())                │
    │        · Pone el email en modal-email                        │
    │        · Muestra email-modal (revisa tu correo)              │
    │        · Al cerrar ese modal → redirige a /login             │
    └──────────────────────────────────────────────────────────────┘

================================================================
SECCIÓN 5 — ESTILOS (<style>)
================================================================

  Los estilos del modal están en la sección <style> de este mismo
  archivo. Ver styles.css.d para los estilos del form y los inputs.

  .modal-overlay         → display:none por defecto (oculto)
  .modal-overlay.modal-visible → display:flex (visible, con animación)
  .modal-box             → caja oscura centrada, con bordes redondeados
  .modal-btn             → botón azul-violeta "Entendido"
  fadeIn / slideUp       → animaciones CSS de entrada del modal

================================================================
