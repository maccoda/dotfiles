# Simple function to open from terminal to perform some
# arbitrary action on the task list.
function task-action
    set repeat true
    task
    while $repeat
        set repeat false
        read cmd --shell -P "Task command: "

        if test -z $cmd
            # If no command given just exit
            exit 0
        end

        clear
        eval $cmd
        task
        read repeat_input -P "Anything else? [y/n] "
        if test $repeat_input = "y"
            set repeat true
        end
    end
    exit 0
end
