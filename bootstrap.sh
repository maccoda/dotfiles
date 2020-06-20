#!/bin/bash
set -e
source ./bootstrap/bootstrap_functions.sh

check_if_binary_installed git || (echo "Git not installed" && exit 1)

echoo "Start the bootstrap and apply settings"
./install

case "$(uname -s)" in

   Darwin)
     echo 'Detected Mac OS'
     source "./bootstrap/macos_bootstrap.sh"
     ;;

   Linux)
     echo 'Detected Linux OS'
     source "./bootstrap/linux_bootstrap.sh"
     ;;

   *)
     echo 'Other OS not sure how to set this up'
     exit 1
     ;;
esac

echoo "Now the text editing essentials"
source "./bootstrap/neovim.sh"

echoo "Here comes the terminal"
source "./bootstrap/terminal.sh"


echoo "It's about to get rusty!"
check_if_binary_installed rustup || curl https://sh.rustup.rs -sSf | sh

