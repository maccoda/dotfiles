#/bin/bash

echo "It is time to begin this journey, let's get our trusty friend Homebrew"
check_if_binary_installed "brew" || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "\nNow to work with our friend to find some more\n"
brew_install awscli aws # AWS CLI
brew_install azure-cli az # Azure CLI
brew_install stern # Kubernetes log aggregator
brew_install tcpflow # TCP traffic logger
brew_install telnet
brew_install terraform # Infrastructure as code
brew_install wget
curl -s "https://get.sdkman.io" | bash # JDK SDK manager for micronaut
brew_install watch
brew_install fswatch
brew_install mongodb/brew/mongodb-community-shell # mongo db CLI
brew_install unison # Two way sync if using separate box for development

echo "\nLet's move onto the bigger ones\n"
# cask_install alfred # Quick launch
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
cask_install typora # Note taking
cask_install boostnote # Note taking
cask_install karabiner-elements # Keyboard shortcuts
cask_install quicksilver # Quick launch
cask install rambox # Messaging app
cask install jumpcut # Clipboard manager
cask_install alacritty # Terminal emulator

echo "\nAdd some fonts"
brew tap homebrew/cask-fonts
cask_install font-droidsansmono-nerd-font-mono
cask_install font-firacode-nerd-font
