#!/bin/bash
brew_install neovim nvim

# Install plugin manager
PLUG_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"

check_if_installed $PLUG_PATH  ||sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install kotlin language server for vim
if [ -d ~/tools/kotlin-lsp ]; then
    echog "Kotin LSP already installed"
else
    mkdir -p ~/tools/kotlin-lsp
    cd ~/tools
    curl -l https://api.github.com/repos/fwcd/kotlin-language-server/releases/latest \
        | grep 'browser_download_url' \
        | cut -d \" -f 4 \
        | grep 'server.zip' \
        | xargs curl -lL --output kotlin-lsp.zip
    unzip kotlin-lsp.zip -d kotlin-lsp
    rm kotlin-lsp.zip
    cd -
fi

nvim +PlugUpdate +qall
