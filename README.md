# 🎨 Trivia de Arte

Un juego de trivia simple donde los jugadores deben adivinar a qué artista pertenece cada pintura.

## 🚀 Cómo Jugar

### Opción 1: Con Docker (Más Fácil)
```bash
# Construir y ejecutar con Docker
./docker.sh build
./docker.sh start

# Ver estado
./docker.sh status

# Ver logs
./docker.sh logs

# Detener
./docker.sh stop
```

**URL del juego:** `http://localhost:8097`

### Opción 2: Con Servidor Local
```bash
# Iniciar servidor en segundo plano
./start.sh

# Ver estado del servidor
./status.sh

# Detener servidor
./stop.sh
```

**URLs del juego:**
- Python: `http://localhost:8097`
- Node.js: `http://localhost:8099`

### Opción 2: Servidor Manual
```bash
# Python
python3 server.py

# Node.js
node server.js
```

### Opción 3: Sin Servidor (Limitado)
1. Abre `index.html` directamente en tu navegador
2. ⚠️ **Nota**: Algunas funciones pueden no funcionar debido a restricciones de CORS

### Cómo Jugar:
1. Selecciona los artistas con los que quieres jugar (mínimo 2)
2. Haz clic en "Comenzar Juego"
3. Observa la pintura y selecciona el artista correcto
4. ¡El juego te dirá si acertaste o no!

## 🐳 Gestión con Docker

### Comandos de Docker
```bash
./docker.sh build    # Construir imagen
./docker.sh start    # Iniciar contenedor
./docker.sh stop     # Detener contenedor
./docker.sh restart  # Reiniciar contenedor
./docker.sh logs     # Ver logs
./docker.sh status   # Ver estado
./docker.sh shell    # Abrir shell en contenedor
./docker.sh dev      # Modo desarrollo
./docker.sh clean    # Limpiar todo
./docker.sh help     # Mostrar ayuda
```

### Características de Docker
- ✅ **Aislamiento**: Ejecuta en contenedor aislado
- ✅ **Portabilidad**: Funciona en cualquier sistema con Docker
- ✅ **Fácil despliegue**: Un solo comando para iniciar
- ✅ **Health checks**: Monitoreo automático del servicio
- ✅ **Volúmenes**: Monta tu directorio de pinturas
- ✅ **Logs persistentes**: Logs guardados en volumen

### Requisitos
- Docker y Docker Compose instalados
- Directorio `./artists/` con las pinturas (ruta relativa al proyecto)

## 🔧 Gestión del Servidor Local

### Comandos Principales
```bash
./start.sh   # Iniciar servidor en segundo plano
./stop.sh    # Detener servidor
./status.sh  # Ver estado y logs
```

### Características del Servidor en Segundo Plano
- ✅ **Ejecución en background**: No bloquea la terminal
- ✅ **Logs automáticos**: Se guardan en `server.log`
- ✅ **Detección de duplicados**: Evita múltiples servidores
- ✅ **Fácil gestión**: Comandos simples para controlar

### Ver Logs en Tiempo Real
```bash
# Ver logs mientras el servidor corre
tail -f server.log

# Ver últimas 20 líneas
tail -20 server.log
```

## 📁 Estructura del Proyecto

```
artgame/
├── index.html              # Juego principal
├── config.js               # Configuración del juego
├── artists.json            # Configuración de artistas (generado automáticamente)
├── server.py               # Servidor Python para evitar CORS
├── server.js               # Servidor Node.js para evitar CORS
├── Dockerfile              # Imagen Docker
├── docker-compose.yml      # Configuración Docker Compose
├── docker.sh               # Script para gestionar Docker
├── .dockerignore           # Archivos a ignorar en Docker
├── start.sh                # Script para iniciar servidor en segundo plano
├── stop.sh                 # Script para detener servidor
├── status.sh               # Script para ver estado del servidor
├── server.log              # Logs del servidor (generado automáticamente)
├── generate_artists.py     # Script Python para generar artists.json
├── generate_artists.js     # Script Node.js para generar artists.json
├── generate_artists.sh     # Script Bash para generar artists.json
└── artists/                # Carpeta con pinturas de artistas (montada en Docker)
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

1. **Para uso local** - Edita `config.js`:
   ```javascript
   ARTISTS_DIRECTORY: '/mnt/d/Pinturas',  // Ruta absoluta
   // O
   ARTISTS_DIRECTORY: 'mi_carpeta',       // Ruta relativa al proyecto
   ```

2. **Para Docker** - Coloca las pinturas en `./artists/`:
   ```
   artgame/
   ├── artists/                    # ← Directorio para Docker
   │   ├── Alfred Sisley/
   │   │   ├── pintura1.jpg
   │   │   └── pintura2.jpg
   │   └── Paul Gauguin/
   │       ├── pintura1.jpg
   │       └── pintura2.jpg
   ├── docker-compose.yml
   └── ...
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
