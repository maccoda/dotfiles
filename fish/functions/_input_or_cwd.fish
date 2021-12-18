# Utility for when the user can provide a directory or nothing
# and the script should start from the current working directory
function _input_or_cwd
    set startDir $argv[1]
    test -z $startDir; and set startDir (realpath '.')
    echo $startDir
end
