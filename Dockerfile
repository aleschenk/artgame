# Dockerfile para el juego de Trivia de Arte
FROM python:3.12-slim

# Metadatos
LABEL maintainer="Tu Nombre"
LABEL description="Juego de Trivia de Arte - Adivina el artista de las pinturas"
LABEL version="1.0"

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Crear directorio para logs
RUN mkdir -p /app/logs

# Hacer ejecutables los scripts
RUN chmod +x *.sh

# Exponer puerto
EXPOSE 8097

# Variables de entorno
ENV PYTHONUNBUFFERED=1
ENV ARTISTS_DIRECTORY=/app/artists

# Comando por defecto
CMD ["python3", "server.py"]
