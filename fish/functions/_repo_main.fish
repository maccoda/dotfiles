
function _repo_main
    set repo_status (git status --porcelain)
    if test -n "$repo_status"
        echo "Detected local changes, stashing all"
        git stash --include-untracked >/dev/null
    end
    set main_branch (_git_main_branch)
    echo "Determined primary branch is $main_branch"

    gum spin --title "Pulling latest changes on $main_branch" -- git pull --prune --tags origin $main_branch
    if test -n "$repo_status"
        git stash pop >/dev/null
    end
    _repo_prune_branches --force --no-fetch
end
