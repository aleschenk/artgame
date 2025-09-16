# 🎨 Trivia de Arte

Un juego de trivia simple donde los jugadores deben adivinar a qué artista pertenece cada pintura.

## 🚀 Cómo Jugar

### Opción 1: Con Servidor Local (Recomendado)
```bash
# Iniciar servidor automáticamente
./start.sh

# O manualmente:
python3 server.py
# O
node server.js
```

Luego abre tu navegador en: `http://localhost:8000`

### Opción 2: Sin Servidor (Limitado)
1. Abre `index.html` directamente en tu navegador
2. ⚠️ **Nota**: Algunas funciones pueden no funcionar debido a restricciones de CORS

### Cómo Jugar:
1. Selecciona los artistas con los que quieres jugar (mínimo 2)
2. Haz clic en "Comenzar Juego"
3. Observa la pintura y selecciona el artista correcto
4. ¡El juego te dirá si acertaste o no!

## 📁 Estructura del Proyecto

```
artgame/
├── index.html              # Juego principal
├── artists.json            # Configuración de artistas (generado automáticamente)
├── server.py               # Servidor Python para evitar CORS
├── server.js               # Servidor Node.js para evitar CORS
├── start.sh                # Script para iniciar servidor automáticamente
├── generate_artists.py     # Script Python para generar artists.json
├── generate_artists.js     # Script Node.js para generar artists.json
├── generate_artists.sh     # Script Bash para generar artists.json
└── artists/                # Carpeta con pinturas de artistas
    ├── Alfred Sisley/
    │   ├── 1.jpg
    │   ├── 2.jpg
    │   └── ...
    └── Paul Gauguin/
        ├── 1.jpg
        ├── 2.jpg
        └── ...
```

## 🔧 Agregar Nuevos Artistas

### Método Automático (Recomendado)

1. Crea una carpeta en `/artists/` con el nombre del artista
2. Agrega las pinturas (imágenes) en esa carpeta
3. Ejecuta uno de los scripts de generación:

```bash
# Opción 1: Python
python3 generate_artists.py

# Opción 2: Node.js
node generate_artists.js

# Opción 3: Bash
./generate_artists.sh
```

### Método Manual

Edita el archivo `artists.json` y agrega el nuevo artista:

```json
{
  "name": "Nombre del Artista",
  "paintings": [
    { "name": "pintura1.jpg", "title": "Título de la pintura" }
  ]
}
```

## 🖼️ Formatos de Imagen Soportados

- JPG/JPEG
- PNG
- GIF
- BMP
- WebP

## 🎯 Características

- ✅ Carga dinámica de artistas
- ✅ Evaluación automática al seleccionar
- ✅ Feedback visual inmediato
- ✅ Sin necesidad de servidor (funciona localmente)
- ✅ Fácil expansión con nuevos artistas
- ✅ Generación automática de configuración

## 🛠️ Requisitos

- Navegador web moderno
- Para usar los scripts de generación:
  - Python 3 (para `generate_artists.py`)
  - Node.js (para `generate_artists.js`)
  - Bash (para `generate_artists.sh`)

## ⚙️ Configuración del Juego

### Modificar Parámetros del Juego

Edita el archivo `config.js` para ajustar el comportamiento del juego:

```javascript
const GAME_CONFIG = {
    // Tiempo de espera para auto-avance (en segundos)
    AUTO_NEXT_DELAY: 2,  // Cambiar aquí: 1, 3, 5, etc.
    
    // Si AutoNext está activado por defecto
    AUTO_NEXT_ENABLED_BY_DEFAULT: true,
    
    // Puerto del servidor
    SERVER_PORT: 8099,
    
    // Directorio donde están las imágenes de los artistas
    ARTISTS_DIRECTORY: 'artists',  // Ruta relativa o absoluta
};
```

### Ejemplos de Configuración:

- **Juego más rápido**: `AUTO_NEXT_DELAY: 1`
- **Juego más lento**: `AUTO_NEXT_DELAY: 5`
- **AutoNext desactivado por defecto**: `AUTO_NEXT_ENABLED_BY_DEFAULT: false`
- **Directorio personalizado**: `ARTISTS_DIRECTORY: '/mnt/d/Pinturas'`
- **Directorio relativo**: `ARTISTS_DIRECTORY: 'mi_carpeta_artistas'`

### Configurar Directorio de Imágenes

Para usar un directorio diferente para las imágenes de artistas:

1. **Edita `config.js`**:
   ```javascript
   ARTISTS_DIRECTORY: '/mnt/d/Pinturas',  // Ruta absoluta
   // O
   ARTISTS_DIRECTORY: 'mi_carpeta',       // Ruta relativa al proyecto
   ```

2. **Estructura del directorio**:
   ```
   /mnt/d/Pinturas/
   ├── Alfred Sisley/
   │   ├── pintura1.jpg
   │   └── pintura2.jpg
   └── Paul Gauguin/
       ├── pintura1.jpg
       └── pintura2.jpg
   ```

3. **Regenera `artists.json`**:
   ```bash
   python3 generate_artists.py
   # O
   node generate_artists.js
   # O
   ./generate_artists.sh
   ```

## 📝 Notas

- El juego funciona mejor cuando se abre a través de un servidor web local
- Los scripts de generación crean títulos automáticos basados en el nombre del archivo
- Puedes personalizar los títulos editando manualmente el archivo `artists.json`
- Modifica `config.js` para ajustar parámetros del juego sin tocar el código principal
