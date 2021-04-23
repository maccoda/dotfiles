fish_add_path $HOME/bin $HOME/.cargo/bin /usr/local/bin $HOME/.fzf/bin

# Used for fzf in vim mainly but default is to only look for files
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# Set default theme for bat
set -gx BAT_THEME "base16"

# For linux /home/linuxbrew/.linuxbrew/bin
fish_add_path /home/linuxbrew/.linuxbrew/bin

# Remove the welcome message
set fish_greeting

# Prefix jrnl command with space so none of the commands are kept in history
abbr --add jrnl " jrnl"

# When executing from vim remove the overhead
if test -z "$VIM"
  starship init fish | source
  fortune -s | cowsay
end
