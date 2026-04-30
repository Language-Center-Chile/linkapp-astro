================================================================
ARCHIVO: src/pages/api/auth/register.ts
PROPÓSITO: Endpoint del servidor que registra un usuario nuevo
           en Supabase y guarda su nombre de usuario en la BD
================================================================

¿EN QUÉ SE DIFERENCIA DEL LOGIN?
  El login VERIFICA si un usuario existe.
  El register CREA un usuario nuevo en Supabase y también guarda
  su `username` en una tabla llamada "Users" de tu base de datos.

================================================================
LÍNEA A LÍNEA
================================================================

  import type { APIRoute } from "astro";
  import { createClient } from "@/lib/supabase";
  → Lo mismo que en login.ts: tipo de Astro y nuestro cliente Supabase.

----------------------------------------------------------------

  export const POST: APIRoute = async ({ request, cookies }) => {
  → Endpoint que responde a peticiones POST en /api/auth/register.

  const supabase = createClient({ request, cookies });
  → Creamos el cliente de Supabase para este request.

----------------------------------------------------------------

  const { username, email, password } = await request.json();
  → Extraemos los 3 campos que manda el formulario de registro:
      · username → nombre de usuario visible (ej: "juanito123")
      · email    → correo electrónico
      · password → contraseña elegida

  if (!username || !email || !password) { ... return 400 }
  → Si falta cualquiera de los 3 campos, rechazamos la petición.

----------------------------------------------------------------

  const { data, error } = await supabase.auth.signUp({ email, password });
  → Le pedimos a Supabase que CREE el usuario con ese email y contraseña.
    Devuelve dos cosas:
      · data  → contiene `data.user` (info del usuario creado)
                          `data.session` (sesión activa si email no requiere confirmación)
      · error → si algo salió mal (email ya existe, contraseña débil, rate limit, etc.)

  if (error) { ... return 400 con error.message }
  → Si Supabase devuelve error, lo reenviamos al frontend.
    Ejemplos de errores de Supabase:
      - "User already registered"       → ese email ya existe
      - "Email rate limit exceeded"     → demasiados registros seguidos (testing)
      - "Password should be at least..."→ contraseña muy débil

----------------------------------------------------------------

  if (data.user) {
    await supabase.from("Users").insert([{ id: data.user.id, username }]);
  }
  → Si el usuario fue creado exitosamente, guardamos su username en la
    tabla "Users" de tu base de datos de Supabase.
    El campo `id` usa el mismo ID que Supabase asignó al usuario de auth,
    así ambas tablas quedan vinculadas.

  → El comentario dice "No bloqueamos el registro si falla la inserción":
    significa que si por algún motivo este INSERT falla, el registro
    en auth.users ya ocurrió y no lo cancelamos. El usuario puede
    funcionar aunque falte el username en la tabla.

----------------------------------------------------------------

  const needsConfirmation = !data.session;
  → Supabase puede estar configurado para requerir confirmación por email.
    Si `data.session` es null → el usuario debe confirmar su email antes de poder entrar.
    Si `data.session` existe  → el usuario ya está activo (sin confirmación por email).

  return 200 con mensaje diferente según needsConfirmation
  → Si necesita confirmar: "Cuenta creada. Revisa tu email..."
  → Si no necesita:        "Cuenta creada correctamente"

  catch (err) { console.error + return 500 }
  → Atrapa errores inesperados. El console.error("[register]", err) imprime
    el error en los logs del servidor para que puedas depurar.

================================================================
TABLA "Users" EN SUPABASE
================================================================

  La tabla "Users" que usamos guarda datos EXTRA del usuario que
  la autenticación de Supabase no guarda por defecto.

  Supabase Auth guarda: email, password (hasheado), timestamps
  Tu tabla "Users" guarda: id (mismo del auth), username

  Estructura esperada de la tabla:
    Users {
      id       (uuid, FK → auth.users.id)
      username (text)
    }

================================================================
FLUJO COMPLETO
================================================================

  Usuario rellena: Username + E-mail + Password + Confirm Password
    → El formulario llama a POST /api/auth/register
      → Valida que no falten campos
        → supabase.auth.signUp(email, password)
          → Guarda username en tabla Users
            → Responde 200 con mensaje apropiado
              → Frontend muestra modal "Revisa tu correo" y redirige a /login

================================================================
RESPUESTAS POSIBLES
================================================================

  Status 400 → "Faltan campos obligatorios"
  Status 400 → mensaje de Supabase (email ya existe, rate limit, etc.)
  Status 200 → "Cuenta creada. Revisa tu email..." (con confirmación)
  Status 200 → "Cuenta creada correctamente"       (sin confirmación)
  Status 500 → "Error interno del servidor"

================================================================
