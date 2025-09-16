#!/bin/bash
# Script para iniciar el servidor del juego de trivia de arte

echo "🎨 Iniciando servidor para Trivia de Arte..."

# Verificar si Python está disponible
if command -v python3 &> /dev/null; then
    echo "🐍 Usando Python para el servidor..."
    python3 server.py
elif command -v node &> /dev/null; then
    echo "🟢 Usando Node.js para el servidor..."
    node server.js
else
    echo "❌ No se encontró Python3 ni Node.js"
    echo "💡 Instala uno de estos para usar el servidor:"
    echo "   - Python3: sudo apt install python3"
    echo "   - Node.js: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
    exit 1
fi
