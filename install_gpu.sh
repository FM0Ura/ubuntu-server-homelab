#!/bin/bash

echo "================================================================"
echo "    Configuração de GPU e Serviços de IA (ComfyUI e Ollama)     "
echo "================================================================"

echo "--- 1. Preparando ferramentas de detecção de Hardware ---"
sudo apt install -y ubuntu-drivers-common pciutils

echo "--- 2. Instalando Drivers da NVIDIA ---"
# Verifica se a placa de vídeo está conectada diretamente (Bare Metal)
if lspci | grep -i nvidia; then
    echo "Placa NVIDIA detectada! Iniciando instalação automática do melhor driver..."
    sudo ubuntu-drivers autoinstall
else
    # Comportamento para quando o script rodar dentro da Máquina Virtual
    echo "AVISO: Nenhuma placa NVIDIA física detectada."
    echo "Isso é perfeitamente normal durante os testes na Máquina Virtual."
    echo ""
    read -p "Deseja forçar a instalação do driver de vídeo para testar o download dos pacotes? (s/N): " escolha

    if [[ "$escolha" == "s" || "$escolha" == "S" ]]; then
        echo "Forçando a instalação do driver NVIDIA 535..."
        # O driver 535 é excelente e muito estável para a RTX 3060 lidar com as bibliotecas do PyTorch.
        sudo apt install -y nvidia-driver-535 nvidia-utils-535
    else
        echo "Pulando a instalação do driver proprietário por enquanto."
    fi
fi

echo "--- 3. Instalando Toolkit CUDA ---"
# O CUDA é a ponte de comunicação da IA com a placa de vídeo
sudo apt install -y nvidia-cuda-toolkit

echo "--- 4. Instalando o Ollama ---"
# Baixa e executa o instalador oficial do Ollama
curl -fsSL https://ollama.com/install.sh | sh

echo "--- 5. Baixando o ComfyUI ---"
cd ~
# Só faz o clone se a pasta não existir, evitando erros se você rodar o script duas vezes
if [ ! -d "ComfyUI" ]; then
    git clone https://github.com/comfyanonymous/ComfyUI.git
else
    echo "A pasta ComfyUI já existe. Pulando o download."
fi

cd ComfyUI

echo "--- 6. Configurando o Ambiente Virtual Python (venv) ---"
python3 -m venv venv
source venv/bin/activate

echo "--- 7. Instalando o PyTorch (Otimizado para CUDA 12.1) ---"
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo "--- 8. Instalando as dependências gerais do ComfyUI ---"
pip install -r requirements.txt

# Sai do ambiente virtual de forma limpa
deactivate

echo "================================================================"
echo "      Instalação de IA e Drivers concluída com sucesso!         "
echo "================================================================"
