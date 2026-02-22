#!/bin/bash

echo "--- Instalando ferramenta de detecção de drivers ---"
sudo apt install -y ubuntu-drivers-common pciutils

echo "--- Verificando presença de placa NVIDIA ---"
if lspci | grep -i nvidia; then
    echo "Placa NVIDIA detectada! Iniciando instalação automática recomendada..."
    sudo ubuntu-drivers autoinstall
else
    echo "AVISO: Nenhuma placa NVIDIA física detectada."
    echo "Deseja forçar a instalação do driver nvidia-driver-535 para testar o download?"
    read -p "Digite 's' para instalar ou qualquer tecla para pular: " escolha

    if [[ "$escolha" == "s" || "$escolha" == "S" ]]; then
        echo "--- Forçando instalação do driver NVIDIA 535 e CUDA ---"
        # O pacote nvidia-driver-535 é o 'padrão ouro' atual para a RTX 3060 em IA
        sudo apt install -y nvidia-driver-535 nvidia-utils-535
    else
        echo "Pulo a instalação de drivers."
    fi
fi

echo "--- Instalando Toolkit CUDA (Essencial para o ComfyUI/Ollama) ---"
# O Toolkit é necessário para compilar/rodar algumas IAs, independente do driver
sudo apt install -y nvidia-cuda-toolkit

echo "--- Configuração de GPU concluída! ---"
