set -gx PATH $HOME/bin $HOME/.cargo/bin /usr/local/bin $PATH

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# For linux /home/linuxbrew/.linuxbrew/bin
set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH

# Bootstrap fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Remove the welcome message
set fish_greeting

starship init fish | source
