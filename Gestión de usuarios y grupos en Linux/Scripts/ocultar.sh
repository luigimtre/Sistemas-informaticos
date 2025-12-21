#!/bin/bash

# Instalación y permisos
sudo apt install dbus-x11 -y
sudo xhost +SI:localuser:gdm

# Ejecucion
sudo -u gdm gsettings set org.gnome.login-screen disable-user-list true
echo "Reinicia para que se apliquen los cambios."
