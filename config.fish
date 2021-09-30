fish_add_path $HOME/bin $HOME/.cargo/bin /usr/local/bin $HOME/.fzf/bin

# Used for fzf in vim mainly but default is to only look for files
set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# Set default theme for bat
set -gx BAT_THEME "1337"

# For linux /home/linuxbrew/.linuxbrew/bin
if test (uname) = 'Linux'
  fish_add_path /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/opt/node@12/bin /home/linuxbrew/.linuxbrew/opt/openjdk@11/bin
end

# Remove the welcome message
set fish_greeting

# Prefix jrnl command with space so none of the commands are kept in history
abbr --add --global jrnl " jrnl"
abbr --add --global t " task"


if status --is-interactive
  starship init fish | source
  zoxide init fish | source
end
