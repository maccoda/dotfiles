# Simple function to open from terminal to perform some
# arbitrary action on the task list.
function task-action
    set repeat true
    task
    while $repeat
        set repeat false
        read cmd --shell -P "Command: "

        if test -z $cmd
            # If no command given just exit
            exit 0
        end

        clear
        eval $cmd
        task
        gum confirm "Anything else?" --default=false && set repeat true
    end
    exit 0
end
