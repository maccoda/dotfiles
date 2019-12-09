function commit
    grg | rg $argv[1]
end

#Usage: squash N where N is number of commits to squash
function squash
    set commit_message (git log --format=%B --reverse HEAD..HEAD@{1})
    git reset --soft HEAD~$argv[1] and git commit --edit -m"$commit_message"
end

function refresh
    git stash && git pull -r && git stash pop
end

set PATH $HOME/bin $PATH
