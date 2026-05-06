import type { APIRoute } from "astro";
import { createClient } from "@/lib/supabase";

export const GET: APIRoute = async ({ request, cookies }) => {
  const supabase = createClient({ request, cookies });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return new Response(JSON.stringify({ error: "No autorizado" }), {
      status: 401,
      headers: { "Content-Type": "application/json" },
    });
  }

  const { data, error } = await supabase
    .from("linkapp_folders")
    .select("user_id, owner, content, updated_at")
    .eq("user_id", user.id)
    .maybeSingle();

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  return new Response(
    JSON.stringify({
      content: Array.isArray(data?.content) ? data.content : [],
    }),
    {
      status: 200,
      headers: { "Content-Type": "application/json" },
    }
  );
};

export const POST: APIRoute = async ({ request, cookies }) => {
  const supabase = createClient({ request, cookies });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (!user) {
    return new Response(JSON.stringify({ error: "No autorizado" }), {
      status: 401,
      headers: { "Content-Type": "application/json" },
    });
  }

  let body: { content?: unknown };

  try {
    body = await request.json();
  } catch {
    return new Response(JSON.stringify({ error: "JSON inválido" }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }

  const content = Array.isArray(body.content) ? body.content : [];

  const { data: existing, error: selectError } = await supabase
    .from("linkapp_folders")
    .select("user_id")
    .eq("user_id", user.id)
    .maybeSingle();

  if (selectError) {
    return new Response(JSON.stringify({ error: selectError.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  let error = null;

  if (!existing) {
    const result = await supabase.from("linkapp_folders").insert({
      user_id: user.id,
      owner: user.email ?? null,
      content,
      updated_at: new Date().toISOString(),
    });
    error = result.error;
  } else {
    const result = await supabase
      .from("linkapp_folders")
      .update({
        owner: user.email ?? null,
        content,
        updated_at: new Date().toISOString(),
      })
      .eq("user_id", user.id);
    error = result.error;
  }

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { "Content-Type": "application/json" },
  });
};