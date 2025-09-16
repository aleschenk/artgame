#!/usr/bin/env python3
"""
Servidor HTTP simple para servir el juego de trivia de arte
y evitar errores de CORS al cargar archivos locales.
"""

import http.server
import socketserver
import webbrowser
import os
import re
from pathlib import Path

def load_config():
    """Carga la configuración del juego."""
    try:
        with open('config.js', 'r', encoding='utf-8') as f:
            content = f.read()
            # Extraer el valor de ARTISTS_DIRECTORY
            match = re.search(r"ARTISTS_DIRECTORY:\s*['\"]([^'\"]+)['\"]", content)
            if match:
                return match.group(1)
    except:
        pass
    return "artists"

def start_server():
    # Configuración del servidor
    PORT = 8097
    DIRECTORY = Path(__file__).parent
    ARTISTS_DIR = load_config()
    
    class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
        def __init__(self, *args, **kwargs):
            super().__init__(*args, directory=DIRECTORY, **kwargs)
        
        def do_GET(self):
            # Manejar rutas de artistas
            if self.path.startswith('/artists/'):
                # Decodificar URL
                import urllib.parse
                decoded_path = urllib.parse.unquote(self.path)
                # Remover /artists/ del path
                relative_path = decoded_path[9:]  # Quitar '/artists/'
                # Construir la ruta real
                artists_path = Path(ARTISTS_DIR) / relative_path
                
                print(f"🔍 Buscando: {artists_path}")
                
                if artists_path.exists() and artists_path.is_file():
                    # Servir el archivo desde el directorio configurado
                    self.send_response(200)
                    self.send_header('Content-Type', self.guess_type(str(artists_path)))
                    self.end_headers()
                    with open(artists_path, 'rb') as f:
                        self.wfile.write(f.read())
                    return
                else:
                    print(f"❌ Archivo no encontrado: {artists_path}")
                    self.send_error(404, f"File not found: {artists_path}")
                    return
            
            # Para otros archivos, usar el comportamiento por defecto
            super().do_GET()
        
        def end_headers(self):
            # Agregar headers para evitar problemas de CORS
            self.send_header('Access-Control-Allow-Origin', '*')
            self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
            self.send_header('Access-Control-Allow-Headers', 'Content-Type')
            super().end_headers()
    
    # Crear el servidor
    with socketserver.TCPServer(("", PORT), CustomHTTPRequestHandler) as httpd:
        print(f"🚀 Servidor iniciado en http://localhost:{PORT}")
        print(f"📁 Sirviendo archivos desde: {DIRECTORY}")
        print(f"🎨 Directorio de artistas: {ARTISTS_DIR}")
        print(f"🌐 Abre tu navegador en: http://localhost:{PORT}")
        print("⏹️  Presiona Ctrl+C para detener el servidor")
        print("-" * 50)
        
        # Abrir automáticamente el navegador
        try:
            webbrowser.open(f'http://localhost:{PORT}')
        except:
            print("⚠️  No se pudo abrir el navegador automáticamente")
        
        # Iniciar el servidor
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Servidor detenido")

if __name__ == "__main__":
    start_server()
