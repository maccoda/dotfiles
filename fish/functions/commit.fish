# Usage: Search across commits with fzf
function commit
    grg --color=always | fzf --preview='git show --color=always {1}' --ansi
end
