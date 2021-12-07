# Usage: Search across commits with fzf
# Can provide usual git log parameters to the initial call and will be used to initially filter the results
# The fuzzy search will only be performed on the author and commit messages
function commit
    set selected (grg --color=always $argv | fzf --preview='git show --color=always {1}' --ansi --no-sort -n 2,4..)
    if test -z $selected
        return
    end
    set short_hash (echo $selected | cut -d ' ' -f 1)
    git show $short_hash
end
