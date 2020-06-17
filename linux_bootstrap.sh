#!/bin/bash
source bootstrap_functions.sh

sudo apt-get update

echoo "Start the bootstrap and apply settings"
./install

# dotbot -c $(dirname $0)/install.conf.json

echoo "This brew thing could be pretty useful"

check_if_binary_installed "brew" || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew_install nvim
brew_install starship
brew_install "node@12" node

echoo "Get some essentials"
apt_install curl
apt_install fswatch

echoo "Now the text editing essentials"
apt_install vim
#sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#sudo apt install code
brew_install fd # Rust implementation of find
brew_install ripgrep rg # Rust implementation of grep
brew_install bat # Rust implementation of cat
brew_install exa # Rust implementation of exa
brew_install dust # Rust implementation of du

echoo "Add some fonts"
FONT_DIR="~/.local/share/fonts"
mkdir -p $FONT_DIR
cd $FONT_DIR
FONT_NAME="FiraCode Regular Nerd.otf"
if [[ ! -f $FONT_NAME ]]; then
    curl -fLo "$FONT_NAME" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.otf
fi

echoo "Set up the theme"
#sudo add-apt-repository -u ppa:snwh/ppa
#sudo apt-get install paper-icon-theme

echoo "Now some useful tools"
apt_install gnome-tweak-tool gnome-tweaks
#apt_install synapse
apt_install docker
#apt_install docker-compose
#curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

echoo "Here comes the terminal"
#sudo apt install zsh
#./zsh_setup.sh
# Install kitty so we can have font ligatures
check_if_binary_installed "kitty" || curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
brew_install fish
