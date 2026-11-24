import type { APIRoute } from "astro";
import { query, sql } from "../../lib/db";

export const prerender = false;

export const POST: APIRoute = async ({ request, redirect }) => {
  let formData: FormData;
  try {
    formData = await request.formData();
  } catch {
    return new Response("Expected a form submission.", { status: 400 });
  }

  const field = (name: string) => {
    const value = formData.get(name);
    return typeof value === "string" ? value.trim() : "";
  };

  const name = field("name");
  const email = field("email");
  const phone = field("phone");
  const message = field("message");

  if (
    name.length < 1 ||
    name.length > 100 ||
    email.length > 254 ||
    !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) ||
    phone.length > 20 ||
    message.length < 1 ||
    message.length > 5000
  ) {
    return redirect("/contact?error=validation", 303);
  }

  try {
    await query(
      sql`SELECT public.submit_contact_form(${name}, ${email}, ${phone || null}, ${message})`,
    );
    return redirect("/contact?sent=1", 303);
  } catch (error) {
    console.error("Failed to save contact submission.", error);
    return redirect("/contact?error=submit", 303);
  }
};
