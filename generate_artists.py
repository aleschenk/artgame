#!/usr/bin/env python3
"""
Script para generar automáticamente el archivo artists.json
escaneando las carpetas de artistas y sus pinturas.
"""

import os
import json
import glob
import sys
from pathlib import Path

def load_config():
    """Carga la configuración del juego."""
    try:
        # Intentar cargar config.js
        with open('config.js', 'r', encoding='utf-8') as f:
            content = f.read()
            # Extraer el valor de ARTISTS_DIRECTORY
            import re
            match = re.search(r"ARTISTS_DIRECTORY:\s*['\"]([^'\"]+)['\"]", content)
            if match:
                return match.group(1)
    except:
        pass
    
    # Fallback al directorio por defecto
    return "artists"

def generate_artists_json():
    """Genera el archivo artists.json basado en las carpetas de artistas."""
    
    artists_directory = load_config()
    print(f"🔍 Directorio escaneado: {artists_directory}")
    artists_dir = Path(artists_directory)
    artists_data = {"artists": []}
    
    if not artists_dir.exists():
        print(f"❌ La carpeta '{artists_directory}' no existe.")
        print(f"💡 Verifica la configuración en config.js: ARTISTS_DIRECTORY")
        return
    
    # Escanear cada carpeta de artista
    for artist_folder in artists_dir.iterdir():
        if artist_folder.is_dir():
            artist_name = artist_folder.name
            print(f"🎨 Procesando artista: {artist_name}")
            
            # Buscar archivos de imagen en la carpeta del artista
            image_extensions = ['*.jpg', '*.jpeg', '*.png', '*.gif', '*.bmp', '*.webp']
            paintings = []
            
            for extension in image_extensions:
                for image_file in artist_folder.glob(extension):
                    # Generar título automático basado en el nombre del archivo
                    file_name = image_file.stem  # Nombre sin extensión
                    title = f"Obra de {artist_name} - {file_name}"
                    
                    paintings.append({
                        "name": image_file.name,
                        "title": title
                    })
                    print(f"  📸 Encontrada: {image_file.name}")
            
            if paintings:
                artists_data["artists"].append({
                    "name": artist_name,
                    "paintings": paintings
                })
                print(f"  ✅ {len(paintings)} pinturas encontradas")
            else:
                print(f"  ⚠️  No se encontraron pinturas en {artist_name}")
    
    # Escribir el archivo JSON
    output_file = "artists.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(artists_data, f, indent=2, ensure_ascii=False)
    
    print(f"\n🎉 Archivo {output_file} generado exitosamente!")
    print(f"📁 Directorio escaneado: {artists_directory}")
    print(f"📊 Total de artistas: {len(artists_data['artists'])}")
    
    # Mostrar resumen
    total_paintings = sum(len(artist['paintings']) for artist in artists_data['artists'])
    print(f"🖼️  Total de pinturas: {total_paintings}")
    
    for artist in artists_data['artists']:
        print(f"  - {artist['name']}: {len(artist['paintings'])} pinturas")

if __name__ == "__main__":
    print("🚀 Generando artists.json...")
    generate_artists_json()
