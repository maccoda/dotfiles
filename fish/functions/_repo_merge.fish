function _repo_merge
    set merge_branch $argv[1]
    if test -z $merge_branch
        return 1
    end
    echo "Merging in $merge_branch"
    _spin --title "Fetching latest changes from $merge_branch" -- git fetch origin "$merge_branch:$merge_branch"
    set repo_status (git status --porcelain)
    if test -z "$repo_status"
        git merge $merge_branch
    else
        git stash --include-untracked >/dev/null
        git merge $merge_branch
        git stash pop >/dev/null
    end
end
