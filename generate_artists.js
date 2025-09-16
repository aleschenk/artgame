#!/usr/bin/env node
/**
 * Script para generar automáticamente el archivo artists.json
 * escaneando las carpetas de artistas y sus pinturas.
 */

const fs = require('fs');
const path = require('path');

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

function generateArtistsJson() {
    const artistsDirectory = loadConfig();
    const artistsDir = path.isAbsolute(artistsDirectory) ? 
        artistsDirectory : path.join(__dirname, artistsDirectory);
    const artistsData = { artists: [] };
    
    if (!fs.existsSync(artistsDir)) {
        console.log(`❌ La carpeta "${artistsDirectory}" no existe.`);
        console.log('💡 Verifica la configuración en config.js: ARTISTS_DIRECTORY');
        return;
    }
    
    // Leer todas las carpetas de artistas
    const artistFolders = fs.readdirSync(artistsDir, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => dirent.name);
    
    console.log(`🎨 Procesando ${artistFolders.length} artistas...`);
    
    artistFolders.forEach(artistName => {
        console.log(`🎨 Procesando artista: ${artistName}`);
        
        const artistPath = path.join(artistsDir, artistName);
        const paintings = [];
        
        // Extensiones de imagen soportadas
        const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
        
        // Leer archivos en la carpeta del artista
        const files = fs.readdirSync(artistPath);
        
        files.forEach(file => {
            const fileExt = path.extname(file).toLowerCase();
            if (imageExtensions.includes(fileExt)) {
                // Generar título automático
                const fileName = path.parse(file).name;
                const title = `Obra de ${artistName} - ${fileName}`;
                
                paintings.push({
                    name: file,
                    title: title
                });
                
                console.log(`  📸 Encontrada: ${file}`);
            }
        });
        
        if (paintings.length > 0) {
            artistsData.artists.push({
                name: artistName,
                paintings: paintings
            });
            console.log(`  ✅ ${paintings.length} pinturas encontradas`);
        } else {
            console.log(`  ⚠️  No se encontraron pinturas en ${artistName}`);
        }
    });
    
    // Escribir el archivo JSON
    const outputFile = 'artists.json';
    fs.writeFileSync(outputFile, JSON.stringify(artistsData, null, 2), 'utf8');
    
    console.log(`\n🎉 Archivo ${outputFile} generado exitosamente!`);
    console.log(`📁 Directorio escaneado: ${artistsDirectory}`);
    console.log(`📊 Total de artistas: ${artistsData.artists.length}`);
    
    // Mostrar resumen
    const totalPaintings = artistsData.artists.reduce((total, artist) => total + artist.paintings.length, 0);
    console.log(`🖼️  Total de pinturas: ${totalPaintings}`);
    
    artistsData.artists.forEach(artist => {
        console.log(`  - ${artist.name}: ${artist.paintings.length} pinturas`);
    });
}

// Ejecutar el script
console.log('🚀 Generando artists.json...');
generateArtistsJson();
