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

echoo "Getting package manager for fish"
check_if_installed ~/.config/fish/functions/fisher.fish || fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

# Update the autocomplete from man pages
fish -c "fish_update_completions"
# The install will need to be run again because it will need to work for fish
# to add the OS dependent links
fish -c "~/.dotfiles/install"
# Set up personal tooling
fish -c "set -Ux MACCODA_CONFIG $HOME/.config/dev-tools/config.yaml"

# Install node
fish -c "nvm install lts"
fish -c "set --universal nvm_default_version lts"

# Set vim mode keybindings in fish
fish -c "fish_vi_key_bindings"
# Set the theme
fish -c "fish_config theme save 'Catppuccin Mocha'"

echoo "To finish this off change the shell across to fish and start a new terminal"
chsh -s (which fish)

echoo "If the above failed ensure fish is in /etc/shells"
