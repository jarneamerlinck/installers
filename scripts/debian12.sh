#!/bin/bash

pkgToInstallListFull="firefox kitty gh "
pkgToRemoveListFull="gnome-weather gnome-maps gnome-contacts aisleriot gnome-sudoku mahjongg ace-of-penguins gnomine gbrainy gnome-mines gnome-2048 gnome-chess five-or-more firefox-esr four-in-a-row yelp hitori gnome-klotski lightsoff gnome-mines gnome-nibbles malcontent seahorse quadrapassel iagno gnome-music gnome-robots shotwell swell-foop synaptic gnome-taquin gedit gnome-todo"
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

apt-get --yes --purge remove $pkgToRemoveList
apt autoremove

# install and upgrade stuff stuff
add-apt-repository ppa:mozillateam/ppa # for firefox apt install


type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install $pkgToInstallListFull -y