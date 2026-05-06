  // Importamos las librerías necesarias
  import { createClient } from '@supabase/supabase-js';
  import Swal from 'sweetalert2';
  // Nota: Para QRCode en Astro/Vite, podrías necesitar instalarlo vía npm: npm install qrcodejs. 
  // O usar una versión compatible con módulos.

  const SUPABASE_URL = import.meta.env.PUBLIC_SUPABASE_URL;
  const SUPABASE_KEY = import.meta.env.PUBLIC_SUPABASE_PUBLISHABLE_KEY;
  const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

  let carpetas = [];
  const LIMIT_FOLDERS_FREE = 2;

  // Lógica de protección de ruta
  async function checkAuth() {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      window.location.href = '/register'; // O tu página de login
    }
    return session;
  }

  // Inicialización
  async function init() {
    const session = await checkAuth();
    if (session) {
      await cargarDatos(session.user.id);
    }
  }

  async function cargarDatos(userId) {
    const { data, error } = await supabase
      .from('linkapp_folders')
      .select('content')
      .eq('user_id', userId)
      .single();

    if (data) {
      carpetas = data.content || [];
      renderCarpetas();
    }
  }

  function renderCarpetas() {
    const grid = document.getElementById('folderGrid');
    if (!grid) return;

    if (carpetas.length === 0) {
      grid.innerHTML = `<div class="col-span-full text-center py-20 opacity-50 font-black uppercase text-xs tracking-widest text-white">No hay colecciones creadas</div>`;
      return;
    }

    grid.innerHTML = carpetas.map((folder, index) => `
      <div class="folder-card border border-border rounded-[2.5rem] p-8 flex flex-col h-full bg-surface/60 backdrop-blur-md">
        <div class="flex justify-between items-start mb-6">
           <h3 class="text-xl font-black text-white truncate">${folder.nombre}</h3>
           <div class="flex gap-2 text-white">
              <button onclick="window.eliminarCarpeta(${index})">🗑</button>
           </div>
        </div>
        <div class="space-y-2 mb-6">
          ${folder.links.map(link => `
            <div class="bg-white/5 p-3 rounded-xl border border-transparent hover:border-blue/20 transition-all">
              <a href="${link.url}" target="_blank" class="text-xs font-bold text-white hover:text-blue">${link.tag || link.url}</a>
            </div>
          `).join('')}
        </div>
        <button class="w-full py-3 bg-blue/10 text-blue rounded-xl font-black text-[9px] uppercase tracking-tighter hover:bg-blue hover:text-black transition-all">
          + Añadir Enlace
        </button>
      </div>
    `).join('');
  }

  // Hacer funciones disponibles globalmente para los onclick de los strings de arriba
  window.eliminarCarpeta = async (index) => {
    // Tu lógica de SweetAlert y eliminación aquí...
  };

  // Ejecutar al cargar
  init();
