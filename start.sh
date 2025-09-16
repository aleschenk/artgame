#!/bin/bash
# Script para iniciar el servidor del juego de trivia de arte

echo "🎨 Iniciando servidor para Trivia de Arte..."

# Verificar si el servidor ya está corriendo
if pgrep -f "python3 server.py" > /dev/null || pgrep -f "node server.js" > /dev/null; then
    echo "⚠️  El servidor ya está corriendo"
    echo "💡 Para detenerlo: ./stop.sh"
    echo "💡 Para ver el estado: ./status.sh"
    exit 1
fi

# Verificar si Python está disponible
if command -v python3 &> /dev/null; then
    echo "🐍 Usando Python para el servidor..."
    echo "🚀 Iniciando servidor en segundo plano..."
    nohup python3 server.py > server.log 2>&1 &
    SERVER_PID=$!
    echo "✅ Servidor iniciado con PID: $SERVER_PID"
    echo "📝 Logs guardados en: server.log"
    echo "🌐 Abre tu navegador en: http://localhost:8097"
    echo "⏹️  Para detener: ./stop.sh"
elif command -v node &> /dev/null; then
    echo "🟢 Usando Node.js para el servidor..."
    echo "🚀 Iniciando servidor en segundo plano..."
    nohup node server.js > server.log 2>&1 &
    SERVER_PID=$!
    echo "✅ Servidor iniciado con PID: $SERVER_PID"
    echo "📝 Logs guardados en: server.log"
    echo "🌐 Abre tu navegador en: http://localhost:8099"
    echo "⏹️  Para detener: ./stop.sh"
else
    echo "❌ No se encontró Python3 ni Node.js"
    echo "💡 Instala uno de estos para usar el servidor:"
    echo "   - Python3: sudo apt install python3"
    echo "   - Node.js: curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
    exit 1
fi
