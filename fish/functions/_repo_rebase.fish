function _repo_rebase
    set rebase_branch $argv[1]
    if test -z $rebase_branch
        return 1
    end
    echo "Rebasing onto $rebase_branch"
    gum spin --title "Fetching latest changes from $rebase_branch" -- git fetch origin "$rebase_branch:$rebase_branch"
    # Need this if reusing an old branch previously merged and deleted
    git fetch --prune
    set repo_status (git status --porcelain)
    if test -z "$repo_status"
        git rebase $rebase_branch
    else
        git stash --include-untracked >/dev/null
        git rebase $rebase_branch
        git stash pop >/dev/null
    end
end
