fish_add_path $HOME/bin $HOME/.cargo/bin /usr/local/bin
# Workaround to use Mason.nvim as the manager of LSPs for Helix
fish_add_path $HOME/.local/share/nvim/mason/bin
fish_add_path (go env GOPATH)/bin
# Set a consistent configuration directory (common default but not always friends with MacOS)
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx EDITOR hx
set -gx FILE_PICKER yazi

# Used for fzf in vim mainly but default is to only look for files
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden'
# Allow the ctrl-T and alt-c integration to respect gitignore
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type directory"
# Preview the file and open it in editor
set -gx FZF_CTRL_T_OPTS "
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --bind 'ctrl-e:execute($EDITOR {} &> /dev/tty)+abort'"
# Print tree structure in the preview window
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree {}'"

# Set default theme for bat
set -gx BAT_THEME Catppuccin-macchiato

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
set -gx FZF_CTRL_R_OPTS "
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Sponge settings (clean up failed commands)
set sponge_purge_only_on_exit true

# Remove the welcome message
set fish_greeting

# Prefix task command with space so none of the commands are kept in history
abbr --add --global t " task"
abbr --add --global task " task"


if test (uname) = Linux
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
end
if test (uname) = Darwin
    /opt/homebrew/bin/brew shellenv | source
end


if status --is-interactive
    if set -q ZELLIJ
        # TODO: Can I put these into files so that I don't need these immediately and can utilise fish's lazy loading of these?
        # Looks like I can dump it in $__fish_config_dir/conf.d/completions and generate it on update for example
        zoxide init fish --no-cmd | source
        navi widget fish | source
        fzf --fish | source
        starship init fish | source
    else
        zellij attach main
    end
end
