# Usage: Git pull with rebase workflow
function gpr
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull -r
    else
        echo "Detected local changes, stashing all"
        git stash --include-untracked; and git pull -r; and git stash pop
    end
end
