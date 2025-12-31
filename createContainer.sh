#!/bin/bash
# Script que selecciona y activa la configuración apropiada

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "🔍 Auto-detectando configuración de hardware..."

# Detectar GPU NVIDIA
HAS_NVIDIA_GPU=false
if command -v nvidia-smi &> /dev/null 2>&1; then
    if nvidia-smi &> /dev/null 2>&1; then
        HAS_NVIDIA_GPU=true
    fi
fi

# Determinar qué configuración usar
if [ "$HAS_NVIDIA_GPU" = true ]; then
    echo "✅ GPU NVIDIA detectada"
    echo "📋 Activando: devcontainer-nvidia.json"

    # Preparar entorno GPU
    mkdir -p /tmp/runtime-root 2>/dev/null || true
    chmod 0700 /tmp/runtime-root 2>/dev/null || true

    cp .devcontainer/devcontainer-nvidia.json .devcontainer/devcontainer.json
else
    echo "ℹ️  GPU NVIDIA no detectada"
    echo "📋 Activando: devcontainer-basic.json"
    cp .devcontainer/devcontainer-basic.json .devcontainer/devcontainer.json
fi

echo " Construyendo imágenes Docker..."

docker build -t ros2-desktop:humble -f Docker/ros2.Dockerfile . && \
docker build -t ros2-microdds:humble -f Docker/microdds.Dockerfile . && \
docker build -t ros2-px4:humble -f Docker/px4_gz.Dockerfile . && \
docker build -t ros2-px4-ws:humble -f Docker/ros2_ws.Dockerfile .

echo "✅Imagenes listas, configurado correctamente"
