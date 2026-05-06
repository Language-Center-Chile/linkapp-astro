================================================================
ARCHIVO: src/pages/about.astro
PROPÓSITO: Página "Acerca de" del sitio (/about)
================================================================

================================================================
ESTADO ACTUAL
================================================================

  Esta página está VACÍA — solo tiene el layout base sin contenido.

  Código completo:

    ---
    import MainLayout from '../layouts/mainLayouts.astro';
    ---

    <MainLayout
      title="Acerca de | LinkApps"
      description="Descubre más sobre LinkApps..."
    >
    </MainLayout>

  El <MainLayout> solo muestra el header, el fondo animado y el footer,
  pero el <slot /> está vacío → la página no tiene contenido visible.

================================================================
PROPÓSITO FUTURO
================================================================

  Esta página debería contener información sobre:
    · La misión y visión del proyecto
    · El equipo detrás de LinkApps
    · La historia del producto
    · Valores del proyecto (privacidad, minimalismo, etc.)

================================================================
