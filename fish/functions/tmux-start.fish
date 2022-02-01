# Have consistent tmux start up
function tmux-start

    set main_name "main"

    tmux has-session -t $main_name 2> /dev/null
    if test ! $status -eq 0
        tmux new-session -s $main_name -d
        if _is_work
          tmux split-window -v "change task ~/.task/ --clear"
          tmux rename-window "jrnl"
          tmux select-pane -t 0
        end
        tmux new-window -n "dots" "dots"
    end

    if test -z $TMUX
        tmux attach-session -t $main_name
    else
        tmux switch-client -t $main_name
    end
end
