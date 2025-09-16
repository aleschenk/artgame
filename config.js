/**
 * CONFIGURACIÓN DEL JUEGO DE TRIVIA DE ARTE
 * 
 * Modifica estos valores para ajustar el comportamiento del juego
 */

const GAME_CONFIG = {
    // Tiempo de espera para auto-avance (en segundos)
    AUTO_NEXT_DELAY: 1,

    // Si AutoNext está activado por defecto
    AUTO_NEXT_ENABLED_BY_DEFAULT: true,

    // Puerto del servidor (si usas los servidores incluidos)
    SERVER_PORT: 8099,

    // Directorio donde están las imágenes de los artistas
    // Cambiar esta ruta para usar un directorio diferente
    ARTISTS_DIRECTORY: '/mnt/d/pinturas',  // Ruta relativa: 'artists' o absoluta: '/mnt/d/pinturas'

    // Configuraciones adicionales que puedes agregar en el futuro
    // MAX_QUESTIONS: 10,
    // SHOW_SCORE: true,
    // ENABLE_SOUND: false
};

// Exportar para uso en otros archivos
if (typeof module !== 'undefined' && module.exports) {
    module.exports = GAME_CONFIG;
}
