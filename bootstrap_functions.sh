#/bin/bash

function echoo {
    COLOR='\033[0;34m'
    NO_COLOR='\033[0m'
    echo -e "${COLOR}$1${NO_COLOR}"
}

function echog {
    COLOR='\033[0;32m'
    NO_COLOR='\033[0m'
    echo -e "${COLOR}$1${NO_COLOR}"
}

function check_if_binary_installed {
    which $1 &>/dev/null && echog "$1 is already installed"
}

function check_cask_installed {
    ls /usr/local/Caskroom/$1 &>/dev/null && echog "$1 is already installed"
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


function apt_install {
    binary_name=$1
    if [[ $# -gt 1 ]]; then
        binary_name=$2
    fi
    check_if_binary_installed $binary_name || sudo apt install $1
}

