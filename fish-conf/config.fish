set -e fish_user_paths
set fish_user_paths $HOME/bin $HOME/.cargo/bin /usr/local/bin $HOME/.fzf/bin $fish_user_paths

set -gx FZF_DEFAULT_COMMAND 'fd --type f'

# For linux /home/linuxbrew/.linuxbrew/bin
set fish_user_paths /home/linuxbrew/.linuxbrew/bin $fish_user_paths

# Remove the welcome message
set fish_greeting

# Change command color as blue is not good for ubuntu
set fish_color_command cyan

# When executing from vim remove the overhead
if test -z "$VIM"
  starship init fish | source
end
