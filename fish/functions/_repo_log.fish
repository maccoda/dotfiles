# Usage: Search across commits with fzf
# Can provide usual git log parameters to the initial call and will be used to initially filter the results
# The fuzzy search will only be performed on the author and commit messages
function _repo_log
    grg --color=always $argv | fzf --preview 'git show --color=always --stat {1}' --ansi --no-sort -n 2.. \
        --bind "enter:execute(git show --color=always {1} | less -R)"
end
