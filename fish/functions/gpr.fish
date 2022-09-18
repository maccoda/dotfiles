# Usage: Git pull with rebase workflow
function gpr
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull -r > /dev/null
    else
        git stash --include-untracked > /dev/null
        git pull -r > /dev/null
        git stash pop > /dev/null
    end
end
