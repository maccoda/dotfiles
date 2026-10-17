# Usage: Git pull with rebase workflow
function gpr
    set -gx GIT_TERMINAL_PROMPT 0
    set -gx GIT_SSH_COMMAND "ssh -o BatchMode=yes"
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull -r > /dev/null
    else
        git stash --include-untracked > /dev/null
        git pull -r > /dev/null
        git stash pop > /dev/null
    end
end
