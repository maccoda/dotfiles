#/bin/bash

# Echo in color (currently blue)
function echoo {
    COLOR='\033[0;34m'
    NO_COLOR='\033[0m'
    echo -e "${COLOR}$1${NO_COLOR}"
}

# Echo in green
function echog {
    COLOR='\033[0;32m'
    NO_COLOR='\033[0m'
    echo -e "${COLOR}$1${NO_COLOR}"
}

function check_if_installed {
    ls $1 &>/dev/null && echog "$1 is exists"
}

function check_if_binary_installed {
    which $1 &>/dev/null && echog "$1 is already installed"
}

function check_cask_installed {
    ls /opt/homebrew/Caskroom/$1 &>/dev/null && echog "$1 is already installed"
}

function check_snap_installed {
    ls /snap/bin/$1 &>/dev/null && echog "$1 is already installed"
}

function brew_install {
    binary_name=$1
    if [[ $# -gt 1 ]]; then
        binary_name=$2
    fi
    check_if_binary_installed $binary_name || brew install $1
}

function cask_install {
    check_cask_installed $1 || brew install --cask $1
}


function apt_install {
    binary_name=$1
    if [[ $# -gt 1 ]]; then
        binary_name=$2
    fi
    check_if_binary_installed $binary_name || sudo apt install $1
}

function snap_install {
    check_snap_installed $1 || snap install $1
}
