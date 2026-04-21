# 🔧 Ferretería Tico — Inventario Web

**Práctica 3.1 · Bases de Datos · ESCOM · IPN · Grupo 3CV2**

Integrantes:
- Navarrete Hernández Laura Itzel
- Patiño Nicasio Diego

---

## Descripción

Sistema de gestión de inventario para la ferretería "Tico". Permite registrar, editar,
eliminar y consultar productos. Conectado a PostgreSQL en Supabase mediante la API REST
automática. Desplegado como sitio estático en GitHub Pages.

---

## Pasos para desplegar (desde cero)

### 1. Configurar Supabase (base de datos)

1. Ve a [supabase.com](https://supabase.com) y crea una cuenta gratuita
2. Crea un nuevo proyecto (elige contraseña fuerte, guárdala)
3. Espera ~2 minutos a que el proyecto termine de crearse
4. Ve a **SQL Editor** (menú izquierdo)
5. Pega el contenido de `supabase_setup.sql` y haz clic en **Run**
6. Ve a **Settings → API**
7. Copia:
   - **Project URL** → algo como `https://xxxx.supabase.co`
   - **anon public** (en Project API Keys)

### 2. Subir archivos a GitHub

1. Crea un repositorio **público** en GitHub (ej: `ferreteria-tico`)
2. Sube estos archivos:
   - `index.html` ← la aplicación principal
   - `landing.html` ← la página de GitHub Pages
   - `supabase_setup.sql`
   - `README.md`
3. Haz commit y push

### 3. Activar GitHub Pages

1. En tu repositorio ve a **Settings → Pages**
2. En "Source" selecciona **Deploy from a branch**
3. Branch: **main** / Folder: **/ (root)**
4. Guarda
5. En ~30 segundos tendrás la URL: `https://tu-usuario.github.io/ferreteria-tico/`

### 4. Conectar la app a Supabase

1. Abre `https://tu-usuario.github.io/ferreteria-tico/index.html`
2. En el panel de configuración pega:
   - **URL:** `https://xxxx.supabase.co`
   - **Key:** tu anon public key
3. Haz clic en **Conectar**

¡Listo! La app quedará conectada y mostrará los productos de prueba.

---

## Estructura de archivos

```
ferreteria-tico/
├── index.html          ← Aplicación principal (CRUD inventario)
├── landing.html        ← Página informativa (GitHub Pages)
├── supabase_setup.sql  ← Script SQL para crear tablas y datos
└── README.md           ← Este archivo
```

---

## Funcionalidades

- ✅ Ver inventario completo con estadísticas
- ✅ Buscar productos por nombre o marca
- ✅ Filtrar por categoría
- ✅ Agregar nuevos productos
- ✅ Editar productos existentes
- ✅ Eliminar productos
- ✅ Alerta visual de stock bajo (< 5 unidades)
- ✅ Modo demo (sin BD, datos en memoria)

---

## Stack tecnológico

| Capa | Tecnología |
|---|---|
| Frontend | HTML5 · CSS3 · JavaScript ES6+ |
| Base de datos | PostgreSQL (Supabase) |
| Hosting | GitHub Pages |
| API | Supabase REST API (automática) |
| Fonts | Google Fonts (Bebas Neue, DM Sans) |

---

## Variables de entorno

No se usan variables de entorno en servidor (el proyecto no tiene backend).
Las credenciales de Supabase se ingresan en la interfaz y se guardan en
`localStorage` del navegador. **Nunca se incluyen en el código fuente.**
