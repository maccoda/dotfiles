set -gx PATH $HOME/bin $HOME/.cargo/bin /usr/local/bin $PATH

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

starship init fish | source
