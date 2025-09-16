#!/usr/bin/env node
/**
 * Servidor HTTP simple para servir el juego de trivia de arte
 * y evitar errores de CORS al cargar archivos locales.
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const PORT = 8099;
const DIRECTORY = __dirname;

function loadConfig() {
    try {
        const configContent = fs.readFileSync('config.js', 'utf8');
        const match = configContent.match(/ARTISTS_DIRECTORY:\s*['"]([^'"]+)['"]/);
        if (match) {
            return match[1];
        }
    } catch (error) {
        // Fallback al directorio por defecto
    }
    return 'artists';
}

const ARTISTS_DIR = loadConfig();

// MIME types para diferentes archivos
const mimeTypes = {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.css': 'text/css',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.jpeg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.ico': 'image/x-icon'
};

function getMimeType(filePath) {
    const ext = path.extname(filePath).toLowerCase();
    return mimeTypes[ext] || 'application/octet-stream';
}

function startServer() {
    const server = http.createServer((req, res) => {
        // Headers para evitar CORS
        res.setHeader('Access-Control-Allow-Origin', '*');
        res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
        res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
        
        let filePath;
        
        // Manejar rutas de artistas
        if (req.url.startsWith('/artists/')) {
            const decodedUrl = decodeURIComponent(req.url);
            const relativePath = decodedUrl.substring(9); // Quitar '/artists/'
            filePath = path.isAbsolute(ARTISTS_DIR) ? 
                path.join(ARTISTS_DIR, relativePath) : 
                path.join(DIRECTORY, ARTISTS_DIR, relativePath);
        } else {
            filePath = path.join(DIRECTORY, req.url === '/' ? 'index.html' : req.url);
        }
        
        // Verificar que el archivo existe
        fs.access(filePath, fs.constants.F_OK, (err) => {
            if (err) {
                res.writeHead(404, { 'Content-Type': 'text/html' });
                res.end('<h1>404 - Archivo no encontrado</h1>');
                return;
            }
            
            // Leer y servir el archivo
            fs.readFile(filePath, (err, data) => {
                if (err) {
                    res.writeHead(500, { 'Content-Type': 'text/html' });
                    res.end('<h1>500 - Error interno del servidor</h1>');
                    return;
                }
                
                const mimeType = getMimeType(filePath);
                res.writeHead(200, { 'Content-Type': mimeType });
                res.end(data);
            });
        });
    });
    
    server.listen(PORT, () => {
        console.log(`🚀 Servidor iniciado en http://localhost:${PORT}`);
        console.log(`📁 Sirviendo archivos desde: ${DIRECTORY}`);
        console.log(`🎨 Directorio de artistas: ${ARTISTS_DIR}`);
        console.log(`🌐 Abre tu navegador en: http://localhost:${PORT}`);
        console.log('⏹️  Presiona Ctrl+C para detener el servidor');
        console.log('-'.repeat(50));
        
        // Abrir automáticamente el navegador
        const command = process.platform === 'win32' ? 'start' : 
                       process.platform === 'darwin' ? 'open' : 'xdg-open';
        
        exec(`${command} http://localhost:${PORT}`, (error) => {
            if (error) {
                console.log('⚠️  No se pudo abrir el navegador automáticamente');
            }
        });
    });
    
    // Manejar interrupción
    process.on('SIGINT', () => {
        console.log('\n🛑 Servidor detenido');
        process.exit(0);
    });
}

startServer();
