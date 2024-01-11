function _repo_switch
    set repo_status (git status --porcelain --untracked-files=no)
    if test -n "$repo_status"
        set message (gum input --prompt "Uncomitted changes found, stashing. Stash message: ")
        git stash --message "$message"
    end
    set git_branch_cmd "git branch --all --format='%(refname:short)'"
    set selection (eval $git_branch_cmd | fzf --height "~20" --bind "ctrl-r:reload(git fetch --all --prune && $git_branch_cmd)" --header "C-r to refresh" --preview "git logp --color=always {} | delta")
    if test -z $selection
        return
    end
    if echo $selection | rg --only-matching origin
        echo "Checking out remote branch $selection locally"
        git co (echo $selection | sed s#origin/##)
    else
        git switch $selection
    end
end
