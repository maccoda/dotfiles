function add-task
    read text -P "Task to add: "
    read due -P "Due date: "
    task add $text due:$due
    task
    read
    exit 0
end
