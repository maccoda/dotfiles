# Utility function to perform a search for finding git directories under
# the provided starting directory.
function _get_git_dirs
    set dirs (fd --hidden --no-ignore --type directory --max-depth 4 '\.git$' $argv[1])
    echo $dirs | tr ' ' '\n'
end
