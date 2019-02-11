#!/bin/bash

sudo apt-get update

echo "Start the bootstrap and apply settings"
mkdir ~/bin
./install

dotbot -c $(dirname $0)/install.conf.json

echo "Get some essentials"
sudo apt install curl

echo "Now the text editing essentials"
sudo apt install vim
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

echo "Add some fonts"
sudo apt install fonts-firacode
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo apt-get install guake

echo "Set up the theme"
sudo add-apt-repository -u ppa:snwh/ppa
sudo apt-get install paper-icon-theme

echo "Now some useful tools"
sudo apt-get install gnome-tweak-tool
sudo apt-get install synapse
sudo apt-get install docker
sudo apt-get install docker-compose

echo "Here comes the terminal"
sudo apt install zsh
./zsh_setup.sh