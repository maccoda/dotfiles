function _repo_diff
    # Some useful diffs presets
    set choice $argv[1]
    if test -z $choice
        echo "repo diff requires a reference to diff against"
        return 1
    else if test $choice = main
        git branch | rg main &>/dev/null
        if test $status -ne 0
            set main_branch master
        else
            set main_branch main
        end
        _spin --title "Fetching latest changes from $main_branch" -- git fetch origin "$main_branch:$main_branch"
        git diff $main_branch HEAD
    else if test $choice = tag
        git diff (git last-tag) HEAD
    else
        echo "Unknown diff choice $choice"
        return 1
    end
end
