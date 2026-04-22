# This section will be run only when terminal is first opened so it is not a cost incurred on each shell start up
if status --is-login
    echo "Running login shell setup"
    fish_add_path /usr/local/bin
    if which -s cargo
        fish_add_path $HOME/.cargo/bin
    end
    if which -s go
        fish_add_path (go env GOPATH)/bin
    end
    # Set a consistent configuration directory (common default but not always friends with MacOS)
    set -gx XDG_CONFIG_HOME "$HOME/.config"

    set -gx EDITOR nvim
    set -gx FILE_PICKER yazi

    switch (uname)
        case Linux
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        case Darwin
            /opt/homebrew/bin/brew shellenv | source
    end
    # FZF settings
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden'
    set -gx FZF_DEFAULT_OPTS '--cycle --bind "ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"'
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

    # Shrink and simplify zoxide FZF view when jumping with 'j'
    set -gx _ZO_FZF_OPTS '--exact --height "~10" --exit-0 --layout=reverse --preview-window=right,50%,sharp --preview "eza --color=always {2..}"'

    set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
    set -gx BAT_THEME base16

end

if status --is-interactive
    # Remove the welcome message
    set -g fish_greeting
    # Prefix task command with space so none of the commands are kept in history
    abbr --add --global t " task"
    abbr --add --global task " task"

    set pure_truncate_prompt_current_directory_keeps 1
    set pure_show_exit_status true
    set -g fish_transient_prompt 1
    set -g fish_key_bindings fish_vi_key_bindings
    fish_config theme choose catppuccin-macchiato

    set -g async_prompt_functions _pure_prompt_git
    if set -q ZELLIJ
        # TODO: Can I put these into files so that I don't need these immediately and can utilise fish's lazy loading of these?
        # Looks like I can dump it in $__fish_config_dir/conf.d/completions and generate it on update for example
        # zellij setup --generate-completion fish | source
        zoxide init fish --cmd j | source
        fzf --fish | source
    else
        zellij attach --create main
    end
end
