import type { APIRoute } from "astro";
import { createClient } from "@/lib/supabase";

export const POST: APIRoute = async ({ request, cookies }) => {
  const supabase = createClient({ request, cookies });

  try {
    const { username, email, password } = await request.json();

    if (!username || !email || !password) {
      return new Response(
        JSON.stringify({ message: "Faltan campos obligatorios" }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    const { data, error } = await supabase.auth.signUp({ email, password });

    if (error) {
      return new Response(
        JSON.stringify({ message: error.message }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }

    // Si email confirmation está activo, data.user existe pero data.session es null
    // Igualmente guardamos el perfil si tenemos el user id
    if (data.user) {
      await supabase
        .from("Users")
        .insert([{ id: data.user.id, username }]);
      // No bloqueamos el registro si falla la inserción del perfil
    }

    const needsConfirmation = !data.session;

    return new Response(
      JSON.stringify({
        message: needsConfirmation
          ? "Cuenta creada. Revisa tu email para confirmar tu cuenta."
          : "Cuenta creada correctamente",
      }),
      { status: 200, headers: { "Content-Type": "application/json" } }
    );
  } catch (err) {
    console.error("[register]", err);
    return new Response(
      JSON.stringify({ message: "Error interno del servidor" }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
};
