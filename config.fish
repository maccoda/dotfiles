if which cargo &>/dev/null
    fish_add_path $HOME/bin $HOME/.cargo/bin
end
fish_add_path /usr/local/bin
# Workaround to use Mason.nvim as the manager of LSPs for Helix
fish_add_path $HOME/.local/share/nvim/mason/bin
if which go &>/dev/null
    fish_add_path (go env GOPATH)/bin
end

# Set a consistent configuration directory (common default but not always friends with MacOS)
set -gx XDG_CONFIG_HOME "$HOME/.config"

# Use the kick-start version of neovim
set -gx NVIM_APPNAME nvim-kick

set -gx EDITOR nvim
set -gx FILE_PICKER yazi

# FZF settings
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden'
set -gx FZF_DEFAULT_OPTS '--bind "ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"'
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

zellij setup --generate-completion fish | source

if status --is-interactive
    set hydro_multiline true
    set hydro_color_pwd cyan
    set hydro_color_git brblack
    set hydro_color_prompt green
    set hydro_color_duration --dim yellow
    if set -q ZELLIJ
        # TODO: Can I put these into files so that I don't need these immediately and can utilise fish's lazy loading of these?
        # Looks like I can dump it in $__fish_config_dir/conf.d/completions and generate it on update for example
        zoxide init fish | source
        fzf --fish | source
    else
        zellij attach --create main
    end
end
