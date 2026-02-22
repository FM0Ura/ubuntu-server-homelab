#!/bin/bash

echo "--- Atualizando os repositórios e o sistema ---"
sudo apt update && sudo apt upgrade -y

echo "--- Instalando ferramentas base e de compilação ---"
sudo apt install -y curl git wget python3 python3-pip python3-venv build-essential python3-dev software-properties-common

echo "--- Instalando bibliotecas de mídia e gráficos (ComfyUI/OpenCV) ---"
sudo apt install -y ffmpeg libgl1 libglib2.0-0

echo "--- Instalando utilitários de servidor (tmux, monitoramento, etc) ---"
sudo apt install -y tmux btop unzip zip ncdu

echo "--- Habilitando arquitetura 32-bits para a Steam ---"
sudo dpkg --add-architecture i386
sudo apt update

echo "--- Instalando bibliotecas base de 32-bits ---"
sudo apt install -y lib32gcc-s1 lib32stdc++6 libc6:i386 libstdc++6:i386

echo "--- Instalando Vulkan (Motor gráfico do Proton) ---"
sudo apt install -y libvulkan1 libvulkan1:i386 vulkan-tools

echo "--- Instalando servidor de áudio (Pipewire) e suporte a controles ---"
sudo apt install -y pipewire pipewire-pulse steam-devices

echo "--- Instalando otimizações de memória para IA (TCMalloc) ---"
sudo apt install -y libtcmalloc-minimal4

echo "--- Instalação de dependências concluída com sucesso! ---"
