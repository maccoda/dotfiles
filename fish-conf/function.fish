# Usage: Search across commit messages for the given search term
function commit
    if $argv[1] == "--show"
        grg | rg $argv[2] | cut -f 1 | xargs git show
    else
        grg | rg $argv[1]
    end
end

#Usage: squash N where N is number of commits to squash
function squash
    set commit_message (git log --format=%B --reverse HEAD..HEAD@{1})
    git reset --soft HEAD~$argv[1] and git commit --edit -m"$commit_message"
end

# Usage: Git pull workflow
function gp
    git stash; and git pull; and git stash pop
end

# Usage: Git pull with rebase workflow
function gpr
    git stash; and git pull -r; and git stash pop
end

# Base64 decode
function decode
  echo `echo $argv | base64 --decode`
end

# Base64 encode
function encode
  echo -n $argv[1] | openssl base64 | pbcopy
end

# Open dots files
function dots
  cd $HOME/.dotfiles
  nvim .
end

# Remove files with `orig` in name. Usually occured during conflicts
function rm_orig
  fd -I orig -x rm
end

# Look up files workflow
function f
    set -l preview "bat {-1} --color=always"
    fd $argv --type f | fzf -m --ansi --preview $preview --bind "enter:execute(bat {})"
end

# Interactive git staging
function gd
    set -l preview "git diff $argv --color=always -- {-1}"
    git diff $argv --name-only | fzf -m --ansi --preview $preview --bind "enter:execute(git add {})+reload(git diff $argv --name-only)"
end
