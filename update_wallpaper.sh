#!/bin/bash

# Download Wallpaper
CONFIRM=$(wget --quiet \"https://drive.google.com/uc?export=download
id=1NpegmyZFaxxv6FSyWZY9rPsxT-tKlh3u\" -O-  
sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p'); 
wget \"https://drive.google.com/uc?export=download&confirm=${CONFIRM}&id=1NpegmyZFaxxv6FSyWZY9rPsxT-tKlh3u\" -O \"w.jpg\"
gsettings set org.gnome.desktop.background picture-uri \"file://$(pwd)/w.jpg\"

# Detectar o modo atual (claro ou escuro)
modo_atual=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$modo_atual" == *'dark'* ]]; then
    echo "Alternando para modo claro..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    gsettings set org.gnome.desktop.background picture-uri "file://$(pwd)/w.jpg"
else
    echo "Alternando para modo escuro..."
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.background picture-uri "file://$(pwd)/w.jpg"
fi

# Configurar tempo de bloqueio da tela para 5 minutos
echo "Definindo tempo de bloqueio para 5 minutos..."

# Desativa o descanso de tela para não interferir
gsettings set org.gnome.desktop.session idle-delay 300
gsettings set org.gnome.desktop.screensaver lock-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled true

echo "Configuração concluída."