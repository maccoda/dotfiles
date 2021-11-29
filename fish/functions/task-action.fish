# Simple function to open from tmux to perform some
# arbitrary action on the task list.
function task-action
    task
    read cmd --shell -P "Task command: "

    if test -z $cmd
        # If no command given just exit
        exit 0
    end

    eval $cmd
    clear
    task
    read -P "Hit enter to close"
    exit 0
end
