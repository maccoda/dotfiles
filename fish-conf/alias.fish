alias dc="docker-compose"
alias dots="code $HOME/.dotfiles"
alias mongo_start='sudo service mongodb start'
alias postgres_start='sudo service postgresql start'
alias vim='nvim'
# git
alias g='git'
# Git log for rip-grepping
alias grg='git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --date=short'
alias gst='git status'
alias gd='git diff'


# directory shortcut
function dev
    if test -d '/mnt/c/Users/dylan/dev'
        cd /mnt/c/Users/dylan/dev
    else
        cd "$HOME/dev"
    end
end

