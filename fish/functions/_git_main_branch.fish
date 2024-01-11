function _git_main_branch
    git switch main &>/dev/null; or git switch master &>/dev/null
    if test $status -ne 0
        errecho "Unknown main branch"
        git branch
        return 1
    end
    echo (git branch --show-current)
end
