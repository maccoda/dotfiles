# Have consistent tmux start up
function tmux-start
    set tmux_running (pgrep tmux)

    if test -z $TMUX -a -z $tmux_running
      tmux new-session -d
      tmux split-window -v "change \"ultralist list group:project completed:false\" .todos.json --clear"
      tmux rename-window "jrnl"
      tmux select-pane -t 0
      tmux new-window
    end
    tmux attach-session -d
end
