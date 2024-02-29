fish_add_path $HOME/bin $HOME/.cargo/bin /usr/local/bin
# Workaround to use Mason.nvim as the manager of LSPs for Helix
fish_add_path $HOME/.local/share/nvim/mason/bin
# Set a consistent configuration directory (common default but not always friends with MacOS)
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx EDITOR hx
set -gx FILE_PICKER yazi

# Used for fzf in vim mainly but default is to only look for files
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden'
# Allow the ctrl-T and alt-c integration to respect gitignore
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type directory"

# Set default theme for bat
set -gx BAT_THEME "Catppuccin-macchiato"

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -gx EDITOR "nvim"

# Remove the welcome message
set fish_greeting

# Prefix task command with space so none of the commands are kept in history
abbr --add --global t " task"
abbr --add --global task " task"


if test (uname) = 'Linux'
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end
if test (uname) = "Darwin"
    eval (/opt/homebrew/bin/brew shellenv)
end

zoxide init fish --no-cmd | source

if status --is-interactive
  starship init fish | source
end
