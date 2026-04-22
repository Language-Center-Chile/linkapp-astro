================================================================
ARCHIVO: src/components/form/button.astro
PROPÓSITO: Componente de botón reutilizable que puede renderizar
           como <button> (acción) o como <a> (enlace/link)
================================================================

¿POR QUÉ UN COMPONENTE PARA EL BOTÓN?
  El mismo botón se usa como "submit", como botón de navegación y
  como enlace. En vez de repetir HTML, tenemos este componente que
  decide qué renderizar según los props que recibe.

================================================================
PROPS
================================================================

  interface Props {
    textoBoton: string;
    → El texto que muestra el botón. OBLIGATORIO.
       Ej: "Iniciar Sesión", "Registrarse", "Olvidé mi contraseña"

    class?: string;
    → La clase CSS a aplicar. Por defecto: "button1"
       button1 → estilo del botón principal (oscuro)
       button2 → estilo del botón secundario
       button3 → estilo del tercer botón (normalmente link pequeño)

    type?: "submit" | "button" | "reset";
    → El tipo del <button>. Por defecto: "submit"
       submit → envía el formulario al hacer clic
       button → acción sin enviar formulario
       reset  → limpia el formulario

    href?: string;
    → Si se pasa, el componente se renderiza como <a href="...">
      en vez de <button>. Útil para botones que navegan a otra página.
  }

================================================================
LÓGICA DE RENDERIZADO
================================================================

  const { textoBoton, class: className = "button1", type = "submit", href, ...props } = Astro.props;
  → Notar que `class` se renombra a `className` porque `class` es
    palabra reservada en JavaScript.
  → `...props` captura props adicionales para pasarlos al elemento.

  {href
    ? <a href={href} class={className} {...props}>{textoBoton}</a>
    : <button class={className} type={type} {...props}>{textoBoton}</button>
  }

  → Si viene `href` → renderiza un <a> (link de navegación)
  → Si NO viene    → renderiza un <button> (acción en formulario)

  Esto es importante porque:
    · Los links (<a>) no deben tener type="submit"
    · Los botones (<button>) no deben tener href

================================================================
EJEMPLOS DE USO
================================================================

  Botón de submit principal:
    <Button textoBoton="Iniciar Sesión" type="submit" />
    → Genera: <button class="button1" type="submit">Iniciar Sesión</button>

  Botón de navegación (va a /register):
    <Button class="button2" textoBoton="Registrarse" href="/register" type="button" />
    → Genera: <a href="/register" class="button2">Registrarse</a>

  Botón pequeño de link olvidé contraseña:
    <Button class="button3" textoBoton="Olvidé mi contraseña" href="/forgot" type="button" />
    → Genera: <a href="/forgot" class="button3">Olvidé mi contraseña</a>

================================================================
CLASES CSS DISPONIBLES
================================================================

  .button1 → Botón oscuro principal, hover se pone negro
  .button2 → Botón similar, con más padding horizontal
  .button3 → Botón de texto pequeño (como un link de pie de formulario)

  Ver styles.css.d para los estilos detallados de cada clase.

================================================================
