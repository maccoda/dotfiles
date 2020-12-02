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
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull
    else
        echo "Detected local changes, stashing all"
        git stash --include-untracked; and git pull; and git stash pop
    end
end

# Usage: Git pull with rebase workflow
function gpr
    set -l repo_status (git status --porcelain)
    if test -z "$repo_status"
        git pull -r
    else
        echo "Detected local changes, stashing all"
        git stash --include-untracked; and git pull -r; and git stash pop
    end
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
  nv
  cd -
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
    git diff $argv --name-only | fzf -m --ansi --preview $preview \
    --bind "s:execute-silent(git add {})+reload(git diff $argv --name-only),p:execute(git add -p {}),ctrl-r:reload(git diff $argv --name-only)" \
    --header 'Press Ctrl+r to reload'
end

function nv
    if test -e Session.vim
        nvim
    else
        nvim .
    end
end
