================================================================
ARCHIVO: src/pages/api/auth/login.ts
PROPÓSITO: Endpoint del servidor que recibe las credenciales del
           usuario y las verifica contra Supabase para iniciar sesión
================================================================

¿QUÉ ES UN ENDPOINT DE API?
  Es una "puerta" del servidor. El navegador le manda datos (email +
  contraseña) y el servidor los procesa y responde "ok" o "error".
  La URL de esta puerta es: POST /api/auth/login

================================================================
LÍNEA A LÍNEA
================================================================

  import type { APIRoute } from "astro";
  → Solo el TIPO de APIRoute. Le dice a TypeScript que esta función
    es un endpoint de Astro (para que nos ayude con autocompletado).

  import { createClient } from "@/lib/supabase";
  → Importa nuestra función createClient del archivo supabase.ts.
    El @/ es un alias de ruta que apunta a src/.

----------------------------------------------------------------

  export const POST: APIRoute = async ({ request, cookies }) => {
  → Exportamos una función llamada POST (en mayúsculas = método HTTP).
    Esto le dice a Astro: "cuando llegue una petición POST a esta ruta,
    ejecuta esta función".
    Recibe:
      · request → la petición HTTP completa (contiene el body con JSON)
      · cookies → para leer/escribir cookies (Supabase guarda la sesión aquí)

  const supabase = createClient({ request, cookies });
  → Creamos el cliente de Supabase pasándole request y cookies.
    A partir de aquí podemos usar supabase.auth.xxx para autenticar.

----------------------------------------------------------------

  BLOQUE try/catch
  → Todo está envuelto en try/catch para manejar errores inesperados
    (como si el body no es JSON válido, etc.)

  const { email, password } = await request.json();
  → Lee el cuerpo de la petición como JSON y extrae email y password.
    El frontend manda: { "email": "...", "password": "..." }

  if (!email || !password) { ... return status 400 }
  → Validación básica: si faltan campos, respondemos con error 400
    (Bad Request) antes de siquiera llamar a Supabase.
    Esto evita peticiones innecesarias al servicio externo.

----------------------------------------------------------------

  const { error } = await supabase.auth.signInWithPassword({ email, password });
  → Llamamos a Supabase para verificar las credenciales.
    · Si son correctas → Supabase crea una sesión y la guarda en cookies.
      `error` será null.
    · Si son incorrectas → `error` tendrá un mensaje de error.
      No se crea sesión.

  if (error) { ... return status 400 }
  → Si Supabase devolvió error (credenciales malas, email no confirmado,
    etc.), respondemos con 400 y el mensaje de error de Supabase.

  return new Response(JSON.stringify({ message: "Sesión iniciada" }), { status: 200 })
  → Si todo fue bien, respondemos con 200 (OK).
    El frontend recibe este OK y redirige al usuario a la página principal.

  catch { ... return status 500 }
  → Si algo explotó inesperadamente (error de red, JSON mal formado, etc.),
    respondemos con 500 (Internal Server Error).

================================================================
FLUJO COMPLETO
================================================================

  Usuario hace clic en "Iniciar Sesión"
    → El formulario llama a POST /api/auth/login con { email, password }
      → El endpoint valida que no estén vacíos
        → Llama a supabase.auth.signInWithPassword
          → Si OK:  responde 200, el frontend redirige a "/"
          → Si MAL: responde 400, el frontend muestra modal de error

================================================================
RESPUESTAS POSIBLES
================================================================

  Status 400 → "Ingresa tu email y contraseña"  (campos vacíos)
  Status 400 → mensaje de Supabase              (credenciales incorrectas)
  Status 200 → "Sesión iniciada correctamente"  (todo bien)
  Status 500 → "Error interno del servidor"     (algo explotó)

================================================================
