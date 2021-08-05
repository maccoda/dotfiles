#!/bin/bash

sudo add-apt-repository ppa:mmstick76/alacritty -y # Alacrity terminal
sudo add-apt-repository ppa:linrunner/tlp -y # TLP laptop power saving
sudo apt-add-repository ppa:fish-shell/release-3 -y # Fish shell
sudo apt-get update -q

echoo "This brew thing could be pretty useful"

check_if_binary_installed "brew" || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Add brew to the bash path to allow for rest of set up
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


echoo "Get some essentials"
apt_install build-essential # Core build tools and compiled (C/C++)
apt_install fish
apt_install curl
apt_install fswatch
apt_install libavcodec-extra # Video codecs
apt_install alacritty
apt_install tlp # Battery life optimisation

# SDK man for managing JVM sdks
check_if_binary_installed sdk || curl -s "https://get.sdkman.io" | bash

# TODO: Should ensure that sdk man gets onto the path first
sdk install java
sdk install gradle



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

echoo "On to the snaps"
snap_install todoist
snap_install slack --classic
snap_install insomnia
snap_install signal-desktop
snap_install stretchly

check_if_installed ~/.joplin/Joplin.AppImage || wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
