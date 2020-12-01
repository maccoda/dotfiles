#!/bin/bash

sudo add-apt-repository ppa:mmstick76/alacritty -y
sudo apt-get update -q

echoo "This brew thing could be pretty useful"

check_if_binary_installed "brew" || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"


echoo "Get some essentials"
apt_install curl
apt_install fswatch
apt_install libavcodec-extra # Video codecs
apt_install alacritty


#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#sudo apt install code

echoo "Add some fonts"
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p $FONT_DIR
cd $FONT_DIR
pwd
FONT_NAME="Inconsolata Nerd Font Mono.otf"
if [[ ! -f $FONT_NAME ]]; then
    echo "Fetching $FONT_NAME"
    curl -fLo "$FONT_NAME" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf
fi
FONT_NAME="FiraCode Regular Nerd.otf"
if [[ ! -f $FONT_NAME ]]; then
    echo "Fetching $FONT_NAME"
    curl -fLo "$FONT_NAME" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.otf
fi
cd - &>/dev/null


echoo "Set up the theme"
#sudo add-apt-repository -u ppa:snwh/ppa
#sudo apt-get install paper-icon-theme

echoo "Now some useful tools"
apt_install gnome-tweak-tool gnome-tweaks
#apt_install synapse
apt_install docker
apt_install docker-compose
#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echoo "On to the snaps"
snap install todoist
snap install slack --classic
snap install insomnia

check_if_installed ~/.joplin/Joplin.AppImage || wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
