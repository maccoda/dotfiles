# Task complete
function task-complete
    set task_cmd "task rc.defaultwidth=0 rc.defaultheight=0 rc.verbose=nothing"
    set task_id (eval $task_cmd | fzf --height=~100% --ansi --multi --preview-window="90%" | string trim | cut -d ' ' -f 1 )
    if test -z "$task_id"
        echo "No task selected"
        return 1
    end
    set tasks (echo $task_id | tr " " ",")
    task $tasks done
end
