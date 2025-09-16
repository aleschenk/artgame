#!/bin/bash
# Script para detener el servidor del juego de trivia de arte

echo "🛑 Deteniendo servidor de Trivia de Arte..."

# Buscar procesos del servidor
PYTHON_PID=$(pgrep -f "python3 server.py")
NODE_PID=$(pgrep -f "node server.js")

if [ -n "$PYTHON_PID" ]; then
    echo "🐍 Deteniendo servidor Python (PID: $PYTHON_PID)..."
    kill $PYTHON_PID
    echo "✅ Servidor Python detenido"
elif [ -n "$NODE_PID" ]; then
    echo "🟢 Deteniendo servidor Node.js (PID: $NODE_PID)..."
    kill $NODE_PID
    echo "✅ Servidor Node.js detenido"
else
    echo "⚠️  No se encontró ningún servidor corriendo"
fi

# Limpiar archivo de log si existe
if [ -f "server.log" ]; then
    echo "📝 Limpiando logs..."
    rm server.log
fi

echo "🎯 Servidor detenido completamente"
