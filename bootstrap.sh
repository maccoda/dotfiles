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
     source "./bootstrap/brew_kegs.sh"
     ;;

   Linux)
     echo 'Detected Linux OS'
     source "./bootstrap/linux_bootstrap.sh"
     source "./bootstrap/brew_kegs.sh"
     ;;

   *)
     echo 'Other OS not sure how to set this up'
     exit 1
     ;;
esac

echoo "Now the text editing essentials"
source "./bootstrap/neovim.sh"

echoo "It's about to get rusty!"
check_if_binary_installed rustup || curl https://sh.rustup.rs -sSf | sh

# Update the autocomplete from man pages
fish -c "fish_update_completions"
# The install will need to be run again because it will need to work for fish
# to add the OS dependent links
fish -c "~/.dotfiles/install"
