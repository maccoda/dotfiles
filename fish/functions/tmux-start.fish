# Have consistent tmux start up
function tmux-start
    # TODO: Probably want to add something here to not create it immediately and check if there is another one existing
    tmux new-session -d
    tmux split-window -v "change \"ultralist list group:project completed:false\" .todos.json --clear"
    tmux rename-window "jrnl"
    tmux select-pane -t 0
    tmux new-window
    tmux attach-session -d
end
