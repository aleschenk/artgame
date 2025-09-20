#!/bin/bash
# Script para gestionar el juego de trivia de arte con Docker

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar ayuda
show_help() {
    echo -e "${BLUE}🎨 Trivia de Arte - Gestión con Docker${NC}"
    echo "=================================="
    echo ""
    echo "Uso: $0 [COMANDO]"
    echo ""
    echo "Comandos disponibles:"
    echo "  build     - Construir la imagen Docker"
    echo "  start     - Iniciar el contenedor"
    echo "  stop      - Detener el contenedor"
    echo "  restart   - Reiniciar el contenedor"
    echo "  logs      - Ver logs del contenedor"
    echo "  status    - Ver estado del contenedor"
    echo "  shell     - Abrir shell en el contenedor"
    echo "  dev       - Iniciar en modo desarrollo"
    echo "  clean     - Limpiar contenedores e imágenes"
    echo "  help      - Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 build    # Construir imagen"
    echo "  $0 start    # Iniciar juego"
    echo "  $0 logs     # Ver logs"
}

# Función para construir la imagen
build_image() {
    echo -e "${YELLOW}🔨 Construyendo imagen Docker...${NC}"
    docker compose build
    echo -e "${GREEN}✅ Imagen construida exitosamente${NC}"
}

# Función para iniciar el contenedor
start_container() {
    echo -e "${YELLOW}🚀 Iniciando contenedor...${NC}"
    docker compose up -d
    echo -e "${GREEN}✅ Contenedor iniciado${NC}"
    echo -e "${BLUE}🌐 Juego disponible en: http://localhost:8097${NC}"
}

# Función para detener el contenedor
stop_container() {
    echo -e "${YELLOW}🛑 Deteniendo contenedor...${NC}"
    docker compose down
    echo -e "${GREEN}✅ Contenedor detenido${NC}"
}

# Función para reiniciar el contenedor
restart_container() {
    echo -e "${YELLOW}🔄 Reiniciando contenedor...${NC}"
    docker compose restart
    echo -e "${GREEN}✅ Contenedor reiniciado${NC}"
}

# Función para ver logs
show_logs() {
    echo -e "${YELLOW}📋 Mostrando logs del contenedor...${NC}"
    docker compose logs -f
}

# Función para ver estado
show_status() {
    echo -e "${BLUE}📊 Estado del contenedor:${NC}"
    docker compose ps
    echo ""
    echo -e "${BLUE}📋 Logs recientes:${NC}"
    docker compose logs --tail=10
}

# Función para abrir shell
open_shell() {
    echo -e "${YELLOW}🐚 Abriendo shell en el contenedor...${NC}"
    docker compose exec artgame /bin/bash
}

# Función para modo desarrollo
start_dev() {
    echo -e "${YELLOW}🔧 Iniciando en modo desarrollo...${NC}"
    docker compose --profile dev up -d artgame-dev
    echo -e "${GREEN}✅ Contenedor de desarrollo iniciado${NC}"
    echo -e "${BLUE}🌐 Juego disponible en: http://localhost:8098${NC}"
}

# Función para limpiar
clean_docker() {
    echo -e "${YELLOW}🧹 Limpiando contenedores e imágenes...${NC}"
    docker compose down --rmi all --volumes --remove-orphans
    echo -e "${GREEN}✅ Limpieza completada${NC}"
}

# Procesar argumentos
case "${1:-help}" in
    build)
        build_image
        ;;
    start)
        start_container
        ;;
    stop)
        stop_container
        ;;
    restart)
        restart_container
        ;;
    logs)
        show_logs
        ;;
    status)
        show_status
        ;;
    shell)
        open_shell
        ;;
    dev)
        start_dev
        ;;
    clean)
        clean_docker
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo -e "${RED}❌ Comando desconocido: $1${NC}"
        echo ""
        show_help
        exit 1
        ;;
esac
