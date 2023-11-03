#!/bin/bash

pkgToInstallListFull="kitty gh neofetch btop htop flatpak gnome-software-plugin-flatpak wget wireguard-tools"
flatpackToInstall="flathub com.bitwarden.desktop com.github.tchx84.Flatseal md.obsidian.Obsidian org.freedesktop.Piper"
pkgToRemoveListFull="gnome-weather gnome-maps gnome-contacts gnome-games gnome-mines gnome-nibbles malcontent seahorse quadrapassel iagno gnome-music gnome-robots shotwell swell-foop synaptic gnome-taquin gedit goldendict"

# Remove terminal bleep
sed -i "/set bell-style none/c\set bell-style none" /etc/inputrc


# update
apt update 

pkgToRemoveList=""
for pkgToRemove in $(echo $pkgToRemoveListFull); do
  $(dpkg --status $pkgToRemove &> /dev/null)
  if [[ $? -eq 0 ]]; then
    pkgToRemoveList="$pkgToRemoveList $pkgToRemove"
  fi
done


apt update
apt upgrade -y




apt remove $pkgToRemoveList
apt purge $pkgToRemoveList

apt autoremove

apt install -y $pkgToInstallListFull 

# wireguird
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_amd64.deb
dpkg -i ./wireguird_amd64.deb


apt install --fix-broken --fix-missing -y

#flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install -y $flatpackToInstall


# GUI settings

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 300
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.screensaver idle-activation-enabled false

# Cleaning up


# Reboot after updates
reboot