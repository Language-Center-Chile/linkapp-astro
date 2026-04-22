================================================================
ARCHIVO: src/components/shared/FloatingLines.jsx
PROPÓSITO: Componente React que dibuja el fondo animado del sitio:
           líneas onduladas con gradiente que reaccionan al ratón.
           Usa Three.js + GLSL shaders para renderizar en WebGL.
================================================================

¿QUÉ ES THREE.JS Y WEBGL?
  Three.js es una librería que facilita el trabajo con WebGL, la API
  del navegador que permite dibujar gráficos 3D usando la GPU del
  ordenador. En este caso no dibujamos objetos 3D, sino que usamos
  WebGL para pintar píxeles con un programa matemático (shader).

¿QUÉ ES UN SHADER?
  Un shader es un pequeño programa que corre en la GPU (tarjeta gráfica),
  no en la CPU. Recibe como entrada la posición de cada píxel y
  devuelve el color que debe tener ese píxel.
  Son extremadamente rápidos porque la GPU puede correr miles de
  shaders al mismo tiempo (uno por píxel).

================================================================
ESTRUCTURA DEL ARCHIVO
================================================================

  El archivo tiene 3 partes:
    1. Shader code (GLSL)     → el programa que corre en la GPU
    2. Helpers de JavaScript  → hexToVec3 y utilidades
    3. Componente React       → monta Three.js y pasa props al shader

================================================================
PARTE 1 — VERTEX SHADER
================================================================

  const vertexShader = `...`
  → El vertex shader es el más simple posible.
    Solo coloca el quad (rectángulo) que cubre toda la pantalla.
    Todo el trabajo visual lo hace el fragment shader.

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
  → Fórmula estándar para colocar la geometría en pantalla.

================================================================
PARTE 2 — FRAGMENT SHADER (el más importante)
================================================================

  El fragment shader calcula el color de CADA píxel del fondo.
  Tiene varias funciones y uniforms (variables que le pasamos desde JS).

  --- UNIFORMS (variables que llegan desde JavaScript) ---

  iTime          → El tiempo actual en segundos. Aumenta cada frame.
                   Se usa para animar las líneas (sin(iTime + ...) = movimiento).
  iResolution    → Tamaño de la pantalla en píxeles.
  animationSpeed → Qué tan rápido se mueven las líneas.

  enableTop/Middle/Bottom  → Si se dibujan las 3 capas de líneas.
  topLineCount, etc.       → Cuántas líneas hay en cada capa.
  topWavePosition, etc.    → Posición (x, y) y ángulo de rotación de cada ola.

  iMouse         → Posición del ratón en píxeles.
  interactive    → Si las líneas reaccionan al ratón.
  bendRadius     → Qué tan amplia es la zona de influencia del ratón.
  bendStrength   → Cuánto se doblan las líneas cerca del ratón.

  parallax       → Si hay efecto de paralaje al mover el ratón.
  parallaxOffset → Desplazamiento calculado por el paralaje.

  lineGradient[8]      → Array de hasta 8 colores para el gradiente.
  lineGradientCount    → Cuántos colores hay en el array.

  --- FUNCIÓN rotate(r) ---
  → Crea una matriz 2x2 de rotación para girar las coordenadas UV.
    Se usa para inclinar cada capa de líneas con un ángulo diferente.

  --- FUNCIÓN background_color(uv) ---
  → Calcula el color de fondo mezclando azul y rosa/violeta.
    Solo se usa cuando NO hay gradiente definido.

  --- FUNCIÓN getLineColor(t, baseColor) ---
  → Interpola entre los colores del gradiente según la posición t (0.0 a 1.0).
    Si hay solo 1 color → ese color para todas las líneas.
    Si hay 2+ colores → se hace lerp (mezcla) entre colores vecinos del array.
    El resultado se multiplica × 0.5 para que no sea demasiado brillante.

  --- FUNCIÓN wave(uv, offset, screenUv, mouseUv, shouldBend) ---
  → Calcula la "intensidad" de una línea en una posición UV dada.

  float time = iTime * animationSpeed;
  → Tiempo escalado por la velocidad.

  float amp = sin(offset + time * 0.2) * 0.3;
  → La amplitud (altura) de la ola varía lentamente con el tiempo.

  float y = sin(uv.x + x_offset + x_movement) * amp;
  → La posición vertical de la línea es una función seno del eje X,
    creando la forma de ola.

  if (shouldBend) { ...bendOffset... }
  → Si el ratón está cerca, la línea se curva hacia/desde el cursor.
    exp(-dot(d,d) * bendRadius) → caída exponencial radial: cuanto más
    lejos del cursor, menor el efecto.

  return 0.0175 / max(abs(m) + 0.01, 1e-3) + 0.01;
  → Fórmula de "glow" (brillo). Cuanto más cerca esté el píxel de la
    línea (m ≈ 0), más brillante será. Se parece a 1/x: cerca → brillante.

  --- FUNCIÓN mainImage (el bucle principal) ---
  → Primero convierte las coordenadas del píxel a un espacio normalizado
    (-1 a 1 en Y, proporcional en X).
  → Aplica paralaje si está activo.
  → Dibuja las 3 capas (bottom, middle, top) sumando el brillo
    de cada línea. Cada capa tiene su propio ángulo de rotación.

================================================================
PARTE 3 — HELPERS DE JAVASCRIPT
================================================================

  function hexToVec3(hex)
  → Convierte un color hexadecimal ("#e945f5") a un objeto Vector3
    de Three.js con valores entre 0.0 y 1.0.
    Ejemplo: "#ff0000" → Vector3(1.0, 0.0, 0.0)
    Soporta hex de 3 o 6 caracteres.

================================================================
PARTE 4 — COMPONENTE REACT FloatingLines
================================================================

  PROPS (parámetros del componente):

  linesGradient       → Array de colores hex para las líneas
                         Ej: ["#e945f5", "#6f6f6f", "#6a6a6a"]
  enabledWaves        → Qué capas dibujar: ['top', 'middle', 'bottom']
  lineCount           → Número de líneas por capa (número o array)
  lineDistance        → Separación entre líneas
  topWavePosition     → { x, y, rotate } posición de la capa superior
  middleWavePosition  → { x, y, rotate } posición de la capa media
  bottomWavePosition  → { x, y, rotate } posición de la capa inferior
  animationSpeed      → Velocidad de animación (default: 1)
  interactive         → Las líneas reaccionan al ratón (default: true)
  bendRadius          → Radio de influencia del cursor (default: 5.0)
  bendStrength        → Fuerza de curvatura (default: -0.5)
  mouseDamping        → Suavidad del seguimiento del ratón (default: 0.05)
  parallax            → Efecto paralaje activo (default: true)
  parallaxStrength    → Intensidad del paralaje (default: 0.2)
  mixBlendMode        → Modo de mezcla CSS del canvas (default: 'screen')

  --- REFS (referencias a valores que persisten entre renders) ---

  containerRef        → Referencia al div contenedor del canvas WebGL.
  targetMouseRef      → Posición del ratón que el usuario mueve (objetivo).
  currentMouseRef     → Posición actual suavizada (se interpola hacia target).
  targetInfluenceRef  → Influencia del ratón (1 cuando está en pantalla, 0 cuando sale).
  currentInfluenceRef → Influencia suavizada.
  targetParallaxRef   → Offset de paralaje objetivo.
  currentParallaxRef  → Offset de paralaje suavizado.

  --- useEffect (la lógica principal) ---

  Se ejecuta UNA vez al montar el componente.
  Dentro:
    1. Crea la escena de Three.js (Scene, Camera, WebGLRenderer)
    2. Crea una geometría PlaneGeometry(-1 a 1) que cubre la pantalla
    3. Crea el ShaderMaterial con vertex + fragment shader y los uniforms
    4. Hace un Mesh (geometría + material) y lo añade a la escena
    5. Añade event listeners de: mousemove, mouseleave, resize
    6. Arranca el loop de animación (requestAnimationFrame):
       - Actualiza iTime con el Clock de Three.js
       - Interpola currentMouse → targetMouse (suavizado)
       - Actualiza el uniform iMouse con la posición suavizada
       - Llama renderer.render(scene, camera) → dibuja el frame

  Cleanup: cuando el componente se desmonta, cancela la animación,
  elimina los event listeners y libera la memoria de WebGL.

================================================================
USO EN EL PROYECTO
================================================================

  Se usa en mainLayouts.astro con client:load:
    <FloatingLines
      client:load
      linesGradient={["#e945f5", "#6f6f6f", "#6a6a6a"]}
      animationSpeed={5}
      interactive={true}
      ...
    />

  El canvas que genera se coloca en un div con position:fixed y
  z-index:-1 para que esté detrás de todo el contenido de la página.

================================================================
