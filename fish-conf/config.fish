set -gx PATH $HOME/bin $HOME/.cargo/bin /usr/local/bin $PATH

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# For linux /home/linuxbrew/.linuxbrew/bin
set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH

# For kitty shell
set -gx PATH $HOME/.local/kitty.app/bin $PATH

# Remove the welcome message
set fish_greeting

starship init fish | source
