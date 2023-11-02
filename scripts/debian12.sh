#!/bin/bash

pkgToInstallListFull="kitty gh neofetch btop htop"
pkgToRemoveListFull="gnome-weather gnome-maps gnome-contacts aisleriot gnome-sudoku mahjongg ace-of-penguins gnomine gbrainy gnome-mines gnome-2048 gnome-chess five-or-more four-in-a-row yelp hitori gnome-klotski lightsoff gnome-mines gnome-nibbles malcontent seahorse quadrapassel iagno gnome-music gnome-robots shotwell swell-foop synaptic gnome-taquin gedit gnome-todo"
# Remove terminal bleep

sed -i "/set bell-style none/c\set bell-style none" /etc/inputrc


# update
#apt update 



# remove unused gnome apps

#apt remove --purge 

pkgToRemoveList=""
for pkgToRemove in $(echo $pkgToRemoveListFull); do
  $(dpkg --status $pkgToRemove &> /dev/null)
  if [[ $? -eq 0 ]]; then
    pkgToRemoveList="$pkgToRemoveList $pkgToRemove"
  fi
done


apt update

apt-get --yes --purge remove $pkgToRemoveList
apt install -y $pkgToInstallListFull 

apt autoremove
# Display manager
systemctl disable gdm

echo "Fully run"
apt install -y sddm
systemctl enable sddm

# GUI settings

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'