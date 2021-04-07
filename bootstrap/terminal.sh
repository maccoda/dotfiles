#!/bin/bash

# Set up for the terminal experience

brew_install fish # Fish shell
brew_install starship # shell agnostic formatting

# Update the autocomplete from man pages
fish -c "fish_update_completions"
