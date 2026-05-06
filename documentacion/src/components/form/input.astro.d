================================================================
ARCHIVO: src/components/form/input.astro
PROPÓSITO: Componente de campo de texto con animación "wave"
           (las letras del label se mueven cuando el input está activo)
================================================================

¿POR QUÉ UN COMPONENTE SEPARADO?
  En vez de repetir el HTML de cada input en cada formulario,
  tenemos este componente reutilizable. Lo usamos en form.astro
  pasándole las props necesarias.

================================================================
LÍNEA A LÍNEA
================================================================

  import "./styles.css";
  → Importa los estilos del formulario (wave-group, .input, .label, etc.)
    Solo se cargan una vez aunque el componente se use varias veces.

----------------------------------------------------------------

  interface Props {
    label: string;         → El texto que aparece flotando (ej: "Email")
    type?: string;         → "text" | "email" | "password" (default: "text")
    name?: string;         → El nombre del campo para el FormData
    autocomplete?: string; → Ayuda al navegador a autocompletar
    required?: boolean;    → Si el campo es obligatorio (default: true)
  }

  const { label = "", type = "text", required = true, ...props } = Astro.props;
  → Destructuramos con valores por defecto.
  → `...props` captura TODOS los props extras (como `name`, `autocomplete`)
    para pasarlos directamente al <input> con el spread {...props}.

  type LabelChar = string;
  type LabelIdx  = number;
  → Alias de tipos TypeScript para evitar errores al mapear las letras
    del label. Solo son nombres descriptivos, no cambian nada en runtime.

----------------------------------------------------------------

  <div class="wave-group">
  → Contenedor del efecto wave. La animación funciona así:
      · El <input> recibe el foco (el usuario hace clic)
      · El CSS detecta el estado :focus del input
      · Las letras del <label> se animan una a una con un retraso
        escalonado (usando la variable CSS --index)

  <input class="input" type={type} required={required} {...props} />
  → El campo de texto real. El {...props} le pasa `name`, `autocomplete`
    y cualquier otro prop que no fue destructurado explícitamente.

  <span class="bar"></span>
  → Una línea horizontal decorativa debajo del input que se expande
    con animación cuando el campo está en foco. Es puramente visual.

  <label class="label">
    {(label.split("") as LabelChar[]).map((char, idx) => (
      <span class="label-char" style={`--index: ${idx}`}>{char}</span>
    ))}
  </label>
  → Aquí está el truco del efecto "wave":
      1. label.split("") → Convierte "Email" en ["E","m","a","i","l"]
      2. .map(...) → Por cada letra crea un <span> individual
      3. style={`--index: ${idx}`} → Le asigna a cada span una variable
         CSS con su posición (0, 1, 2, 3...). El CSS usa esa variable
         para retrasar la animación de esa letra (animation-delay).
      4. Resultado: cuando el input recibe foco, las letras del label
         suben escalonadas una detrás de otra como una ola.

================================================================
EJEMPLO DE USO (en form.astro)
================================================================

  <Input
    name="email"
    label="E-mail"
    autocomplete="email"
    type="email"
  />

  Genera esto en HTML:
  <div class="wave-group">
    <input class="input" type="email" name="email" autocomplete="email" required />
    <span class="bar"></span>
    <label class="label">
      <span class="label-char" style="--index:0">E</span>
      <span class="label-char" style="--index:1">-</span>
      <span class="label-char" style="--index:2">m</span>
      <span class="label-char" style="--index:3">a</span>
      <span class="label-char" style="--index:4">i</span>
      <span class="label-char" style="--index:5">l</span>
    </label>
  </div>

================================================================
