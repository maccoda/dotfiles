# Usage: Search across commit messages for the given search term
function commit
    if test $argv[1] = "--show"
        grg | rg $argv[2] | cut -f 1 | xargs git show
    else
        grg | rg $argv[1]
    end
end
