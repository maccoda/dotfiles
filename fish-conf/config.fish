set -gx PATH $HOME/bin $HOME/.cargo/bin /usr/local/bin $PATH

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# For linux /home/linuxbrew/.linuxbrew/bin
set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH

# Remove the welcome message
set fish_greeting

# Change command color as blue is not good for ubuntu
set fish_color_command cyan

starship init fish | source
