#/bin/bash

function check_if_binary_installed {
    which $1 &>/dev/null && echo "$1 is already installed"
}

function check_cask_installed {
    ls /usr/local/Caskroom/$1 &>/dev/null && echo "$1 is already installed"
}

function brew_install {
    binary_name=$1
    if [[ $# -gt 1 ]]; then
        binary_name=$2
    fi
    check_if_binary_installed $binary_name || brew install $1
}

function cask_install {
    check_cask_installed $1 || brew cask install $1
}

echo "It is time to begin this journey, let's get our trusty friend Homebrew"
check_if_binary_installed "brew" || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "\nNow to work with our friend to find some more\n"
brew_install awscli aws # AWS CLI
brew_install azure-cli az # Azure CLI
brew_install fd # Rust implementation of find
brew_install zola # Static site generator
brew_install nvm # Node version manager
brew_install ripgrep rg # Rust implementation of grep
brew_install stern # Kubernetes log aggregator
brew_install tcpflow # TCP traffic logger
brew_install telnet
brew_install terraform # Infrastructure as code
brew_install wget
brew_install bat # cat alternative
curl -s "https://get.sdkman.io" | bash # JDK SDK manager for micronaut
brew_install watch
brew_install fswatch
brew_install mongodb/brew/mongodb-community-shell # mongo db CLI

echo "\nLet's move onto the bigger ones\n"
cask_install alfred # Quick launch
cask_install caffeine # Keep screen on for given time
cask_install docker # Docker
cask_install firefox-developer-edition # Firefox
cask_install licecap # Screen capture GIF
cask_install numi # Improved calculator
cask_install p4merge # Merge tool
cask_install postman # HTTP requests
cask_install sourcetree # SCM GUI
cask_install sparkleshare # Notes sync
cask_install spectacle # Window management for Mac
cask_install visual-studio-code # The editor
cask_install typora
cask_install boostnote

echo "\nAdd some fonts"
brew tap caskroom/fonts
cask_install font-droidsansmono-nerd-font-mono
cask_install font-fira-code

echo "\nTime to get meta and install the dot file manager\n"
check_if_binary_installed dotbot || pip install dotbot

echo "\nIt's about to get rusty!\n"
check_if_binary_installed rustup || curl https://sh.rustup.rs -sSf | sh

echo "\nMake that terminal pretty\n"
check_if_binary_installed git || echo "Git not installed" && exit 1
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting




