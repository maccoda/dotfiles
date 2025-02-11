# Loading spinner that will suppress output of the provided command
function _spin
    argparse 't/title=' -- $argv
    or return
    set cmd $argv
    if test -z "$cmd"
        echo "No command provided"
        return 1
    end
    fish -c "$cmd &> /dev/null" &
    set pid $last_pid
    set loading_text "Loading..."
    if set -q _flag_title
        set loading_text $_flag_title
    end

    # Heroku spinner options - https://github.com/heroku/heroku-cli-util/blob/main/lib/spinners.json
    set spin "⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷"
    set spin_length (count $spin)

    set i 0
    # kill -0 checks to see if the process with that ID is still running
    while kill -0 $pid 2>/dev/null
        set i (math \( $i + 1\) % $spin_length)
        # Fish is 1 indexed in arrays
        set index (math $i + 1)
        printf "\r$spin[$index] $loading_text"
        sleep .07
    end
    # \33[2K Clears entire line
    # \r returns cursor to the start of the line
    printf "\33[2K\r"
end
