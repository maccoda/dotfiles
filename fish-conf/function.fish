function commit
    grg | rg $argv[1]
end

#Usage: squash N where N is number of commits to squash
function squash
    git reset --soft HEAD~$argv[1] && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
end

function refresh
    git stash and git pull -r and git stash pop
end