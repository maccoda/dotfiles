# Usage: Git pull workflow
function gp
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull
    else
        echo "Detected local changes, stashing all"
        git stash --include-untracked; and git pull; and git stash pop
    end
end
