================================================================
ARCHIVO: src/lib/supabase.ts
PROPÓSITO: Crear el cliente de Supabase para usarlo en el servidor
================================================================

¿QUÉ ES SUPABASE?
  Supabase es el servicio externo que usamos como base de datos y sistema
  de autenticación (usuarios, sesiones, etc.). Piensa en él como el
  "motor" que guarda usuarios y contraseñas.

================================================================
LÍNEA A LÍNEA
================================================================

  import { createServerClient, parseCookieHeader } from "@supabase/ssr";
  → Importamos dos herramientas del paquete oficial de Supabase para SSR
    (Server-Side Rendering, es decir, código que corre en el servidor):
      · createServerClient  → Crea la conexión con Supabase desde el servidor
      · parseCookieHeader   → Convierte el texto crudo de las cookies
                              en un array de objetos { name, value }

  import type { AstroCookies } from "astro";
  → Solo importamos el TIPO (no código real) de AstroCookies para que
    TypeScript sepa cómo se ve ese objeto y no nos dé errores.

----------------------------------------------------------------

  const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
  → Lee la URL de tu proyecto Supabase desde el archivo .env
    Ejemplo: https://abcxyz.supabase.co
    El prefijo PUBLIC_ significa que esta variable es segura de exponer
    al navegador (no contiene secretos).

  const supabasePublishableKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  → Lee la clave pública (anon key) de Supabase desde .env
    Esta clave identifica tu proyecto pero NO tiene permisos de admin.
    También lleva PUBLIC_ porque es segura de exponer.

----------------------------------------------------------------

  export function createClient({ request, cookies })
  → Exportamos una función llamada createClient que recibe:
      · request  → El objeto Request de HTTP (la petición del usuario).
                   Lo necesitamos para leer las cookies que el navegador
                   mandó en la cabecera "Cookie".
      · cookies  → El objeto AstroCookies de Astro, que nos permite
                   ESCRIBIR cookies nuevas en la respuesta al usuario.

  → Esta función devuelve un cliente de Supabase configurado para
    el entorno de servidor.

----------------------------------------------------------------

  return createServerClient(supabaseUrl, supabasePublishableKey, { cookies: { ... } })
  → Crea y devuelve el cliente. Los parámetros son:
      1. supabaseUrl         → A dónde conectarse
      2. supabasePublishableKey → Con qué credenciales
      3. { cookies: {...} }  → Cómo leer y escribir cookies (ver abajo)

  BLOQUE cookies.getAll():
    → Supabase necesita leer las cookies del usuario para saber si ya
      tiene una sesión activa. Aquí le decimos CÓMO hacerlo.
    → Leemos la cabecera "Cookie" de la petición HTTP con request.headers.get("Cookie")
    → parseCookieHeader() la convierte de texto a array: [{ name, value }, ...]
    → El ?? "" garantiza que si no hay cookies, usamos string vacío (no falla)

  BLOQUE cookies.setAll(cookiesToSet):
    → Cuando Supabase necesita guardar una sesión (después de login),
      llama a esta función para escribir las cookies en la respuesta.
    → Recibe un array de cookies a establecer y las escribe una a una
      usando el objeto `cookies` de Astro (cookies.set).
    → El parámetro `options` incluye configuraciones como expiración,
      HttpOnly, SameSite, etc.

================================================================
RESUMEN
================================================================

  Este archivo crea UNA función (createClient) que los endpoints de API
  llaman para obtener un cliente de Supabase listo para usar.
  Sin este archivo, no podríamos hablar con Supabase desde el servidor.

  FLUJO:
    Endpoint recibe petición
      → llama createClient({ request, cookies })
        → devuelve supabase (cliente)
          → usamos supabase.auth.signIn / signUp / etc.

================================================================
