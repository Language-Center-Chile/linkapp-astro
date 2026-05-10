import { createServerClient, parseCookieHeader, createBrowserClient } from "@supabase/ssr";
import type { AstroCookies } from "astro";

const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY; // Verifica que este nombre coincida con tu .env

// Cliente para el SERVIDOR (Astro)
export function createClient({
  request,
  cookies,
}: {
  request: Request;
  cookies: AstroCookies;
}) {
  return createServerClient(
    supabaseUrl,
    supabaseAnonKey,
    {
      cookies: {
        getAll() {
          return parseCookieHeader(request.headers.get("Cookie") ?? "").map(
            ({ name, value }) => ({ name, value: value ?? "" })
          );
        },
        setAll(cookiesToSet) {
          cookiesToSet.forEach(({ name, value, options }) =>
            cookies.set(name, value, options)
          );
        },
      },
    }
  );
}

// Cliente para el NAVEGADOR (Scripts)
// Al usar createBrowserClient de @supabase/ssr, detectará automáticamente las cookies
export const supabaseBrowser = createBrowserClient(
  supabaseUrl,
  supabaseAnonKey
);