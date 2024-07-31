# Task complete
function task-complete
    set task_cmd "task rc.defaultwidth=0 rc.defaultheight=0 rc.verbose=nothing rc._forcecolor=on"
    set task_id (eval $task_cmd | fzf --height=~100% --ansi --preview-window="90%" | cut -d ' ' -f 1 | string trim)
    if test -z $task_id
        echo "No task selected"
        return 0
    end
    task $task_id done
end
