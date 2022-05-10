#/bin/bash

echoo "It is time to begin this journey, let's get our trusty friend Homebrew"
check_if_binary_installed "brew" || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# TODO: brew is not immediately on the path need to fix this

echoo "Now to work with our friend to find some more"
brew_install awscli aws # AWS CLI
brew_install stern # Kubernetes log aggregator
brew_install tcpflow # TCP traffic logger
brew_install telnet
brew_install warrensbox/tap/tfswitch tfswitch # Infrastructure as code version manager
brew_install watch
brew_install fish

echoo "Let's move onto the bigger ones"
cask_install docker # Docker
cask_install licecap # Screen capture GIF
cask_install numi # Improved calculator
cask_install insomnia # HTTP requests
cask_install joplin # Note taking
cask_install flycut # Clipboard manager
cask_install kitty # Terminal emulator
cask_install signal
cask_install stretchly # Screen timer
cask_install amethyst # Tiling window manager
cask_install google-chrome
cask_install firefox
cask_install scroll-reverser # Sensible scrolling on the mouse

echoo "Add some fonts"
brew tap homebrew/cask-fonts
cask_install font-inconsolata-nerd-font
