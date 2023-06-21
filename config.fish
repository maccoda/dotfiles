fish_add_path $HOME/bin $HOME/.cargo/bin /usr/local/bin

# Used for fzf in vim mainly but default is to only look for files
set -gx FZF_DEFAULT_COMMAND 'fd --type f'
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

# For linux /home/linuxbrew/.linuxbrew/bin
if test (uname) = 'Linux'
  fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/opt/node@12/bin /home/linuxbrew/.linuxbrew/opt/openjdk@11/bin
end

# Remove the welcome message
set fish_greeting

# Prefix jrnl command with space so none of the commands are kept in history
abbr --add --global jrnl " jrnl"
abbr --add --global t " task"
abbr --add --global task " task"


if test (uname) = "Darwin"
    eval (/opt/homebrew/bin/brew shellenv)
end

zoxide init fish --cmd j | source

if status --is-interactive
  starship init fish | source
end
