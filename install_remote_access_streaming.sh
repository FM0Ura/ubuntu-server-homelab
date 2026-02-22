#!/bin/bash

echo "================================================================"
echo "       Configuração de Jogos (Steam) e Rede VPN                 "
echo "================================================================"

echo "--- 1. Instalando Interface Gráfica Mínima (Xorg + XFCE) ---"
# A Steam precisa de um ambiente desktop. O XFCE é extremamente leve e não consome a RAM que precisamos para a IA.
sudo apt install -y xorg xfce4 xfce4-goodies

echo "--- 2. Instalando a Steam ---"
# Instala o cliente da Steam
sudo apt install -y steam

echo "--- 3. Instalando o Sunshine (Servidor de Streaming de Jogos) ---"
# Adiciona o repositório oficial do Sunshine e instala
# O Sunshine transmite a tela para o aplicativo "Moonlight" no seu laptop/TV
curl -1sLf 'https://dl.cloudsmith.io/public/moonlight-game-streaming/sunshine/setup.deb.sh' | sudo -E bash
sudo apt install -y sunshine

echo "--- 4. Instalando Ferramenta de Rede (Tailscale) ---"
# Tailscale cria uma rede segura entre seus dispositivos para acesso remoto
curl -fsSL https://tailscale.com/install.sh | sh

echo "================================================================"
echo "      Instalação de Jogos e Rede VPN concluída!                 "
echo "================================================================"
