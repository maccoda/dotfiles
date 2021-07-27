# Watches the provided directory (or 'src' if none provided)
# and executes the given command when it changes
#
# -b/--bell: If set will call the bell on completion of the provided command
# -c/--clear: If set will clear the terminal before each execution of the provided command
function change
    argparse --min-args 1 'b/bell' 'c/clear' -- $argv
    set cmd $argv[1]
    set watch_dir $argv[2]
    test -z $watch_dir; and set watch_dir 'src'
    if test -z $cmd
        echo "Usage: change cmd [watch_directory]"
        return 1
    end

    if set -q _flag_c
        clear
    end
    if set -q _flag_b
        echo -e '\a'
    end
    eval $cmd
    echo "Waiting for update..."
    # TODO: Can make it so that the latency can be configurable if needed
    fswatch $watch_dir | while read -d "" event
        echo "File Changed: $event"
        if set -q _flag_c
            clear

        end
        if set -q _flag_b
            echo -e '\a'
        end
        eval $cmd
        echo "Waiting for update..."
    end
end
