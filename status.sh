#!/bin/bash
# Script para verificar el estado del servidor del juego de trivia de arte

echo "📊 Estado del servidor de Trivia de Arte"
echo "========================================"

# Buscar procesos del servidor
PYTHON_PID=$(pgrep -f "python3 server.py")
NODE_PID=$(pgrep -f "node server.js")

if [ -n "$PYTHON_PID" ]; then
    echo "✅ Servidor Python corriendo (PID: $PYTHON_PID)"
    echo "🌐 URL: http://localhost:8097"
    echo "📝 Logs: server.log"
    
    # Mostrar últimas líneas del log
    if [ -f "server.log" ]; then
        echo ""
        echo "📋 Últimas líneas del log:"
        echo "------------------------"
        tail -5 server.log
    fi
    
elif [ -n "$NODE_PID" ]; then
    echo "✅ Servidor Node.js corriendo (PID: $NODE_PID)"
    echo "🌐 URL: http://localhost:8099"
    echo "📝 Logs: server.log"
    
    # Mostrar últimas líneas del log
    if [ -f "server.log" ]; then
        echo ""
        echo "📋 Últimas líneas del log:"
        echo "------------------------"
        tail -5 server.log
    fi
    
else
    echo "❌ Servidor no está corriendo"
    echo "💡 Para iniciarlo: ./start.sh"
fi

echo ""
echo "🔧 Comandos disponibles:"
echo "  ./start.sh  - Iniciar servidor"
echo "  ./stop.sh   - Detener servidor"
echo "  ./status.sh - Ver estado (este comando)"


