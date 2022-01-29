function tmux-sessionizer
    set selected (fd --type directory --max-depth 1 . $HOME/workplace $HOME/dev $HOME | fzf)

    if test -z $selected
        exit 0
    end

    set selected_name (basename "$selected" | tr '.' '_')

    set tmux_running (pgrep tmux)

    if test -z $TMUX -a -z $tmux_running
        tmux new-session -s $selected_name -c $selected
        exit 0
    end

    tmux has-session -t $selected_name 2> /dev/null
    if test ! $status -eq 0
        tmux new-session -ds $selected_name -c $selected
    end

    if test -z $TMUX
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    end

end
