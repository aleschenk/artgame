#!/bin/bash
# Script para generar automáticamente el archivo artists.json
# escaneando las carpetas de artistas y sus pinturas.

echo "🚀 Generando artists.json..."

# Cargar configuración
ARTISTS_DIRECTORY="artists"
if [ -f "config.js" ]; then
    ARTISTS_DIRECTORY=$(grep -o "ARTISTS_DIRECTORY:\s*['\"][^'\"]*['\"]" config.js | sed "s/ARTISTS_DIRECTORY:\s*['\"]//" | sed "s/['\"].*//")
fi

# Verificar que existe la carpeta de artistas
if [ ! -d "$ARTISTS_DIRECTORY" ]; then
    echo "❌ La carpeta '$ARTISTS_DIRECTORY' no existe."
    echo "💡 Verifica la configuración en config.js: ARTISTS_DIRECTORY"
    exit 1
fi

# Crear archivo JSON temporal
temp_file=$(mktemp)
echo "{" > "$temp_file"
echo "  \"artists\": [" >> "$temp_file"

first_artist=true

# Procesar cada carpeta de artista
for artist_dir in "$ARTISTS_DIRECTORY"/*/; do
    if [ -d "$artist_dir" ]; then
        artist_name=$(basename "$artist_dir")
        echo "🎨 Procesando artista: $artist_name"
        
        # Agregar coma si no es el primer artista
        if [ "$first_artist" = false ]; then
            echo "," >> "$temp_file"
        fi
        first_artist=false
        
        echo "    {" >> "$temp_file"
        echo "      \"name\": \"$artist_name\"," >> "$temp_file"
        echo "      \"paintings\": [" >> "$temp_file"
        
        first_painting=true
        painting_count=0
        
        # Buscar archivos de imagen
        for image_file in "$artist_dir"*.{jpg,jpeg,png,gif,bmp,webp} 2>/dev/null; do
            if [ -f "$image_file" ]; then
                filename=$(basename "$image_file")
                filename_no_ext="${filename%.*}"
                title="Obra de $artist_name - $filename_no_ext"
                
                echo "  📸 Encontrada: $filename"
                
                # Agregar coma si no es la primera pintura
                if [ "$first_painting" = false ]; then
                    echo "," >> "$temp_file"
                fi
                first_painting=false
                
                echo "        {" >> "$temp_file"
                echo "          \"name\": \"$filename\"," >> "$temp_file"
                echo "          \"title\": \"$title\"" >> "$temp_file"
                echo -n "        }" >> "$temp_file"
                
                ((painting_count++))
            fi
        done
        
        echo "" >> "$temp_file"
        echo "      ]" >> "$temp_file"
        echo -n "    }" >> "$temp_file"
        
        if [ $painting_count -gt 0 ]; then
            echo "  ✅ $painting_count pinturas encontradas"
        else
            echo "  ⚠️  No se encontraron pinturas en $artist_name"
        fi
    fi
done

echo "" >> "$temp_file"
echo "  ]" >> "$temp_file"
echo "}" >> "$temp_file"

# Mover archivo temporal a artists.json
mv "$temp_file" "artists.json"

echo ""
echo "🎉 Archivo artists.json generado exitosamente!"
echo "📁 Directorio escaneado: $ARTISTS_DIRECTORY"
echo "📊 Revisa el archivo para verificar el contenido."
