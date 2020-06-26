#!/bin/bash

# brew binaries that are shared between macOS and linux

brew_install fd # Rust implementation of find
brew_install ripgrep rg # Rust implementation of grep
brew_install bat # cat alternative
brew_install exa # Rust implementation of exa
brew_install dust # Rust implementation of du


brew_install "node@12" node
brew link node@12 --force # Since we don't trust bleeding edge
brew_install zola # Static site generator
brew_install fzf # Fuzzy finder
brew_install fswatch # File watch
