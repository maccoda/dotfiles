alias dc="docker-compose"
alias mongo_start='sudo service mongodb start'
alias postgres_start='sudo service postgresql start'
alias vim='nvim'
# git
abbr --add --global g 'git'
# Git log for rip-grepping
alias grg='git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --date=short'
alias gst='git status'

# directory shortcut
function dev
    if test -d '/mnt/c/Users/dylan/dev'
        cd /mnt/c/Users/dylan/dev
    else
        cd "$HOME/dev"
    end
end

# Simple find to use at top level dev directory to check if
# a project is checked out
alias fd-project='fd -t d -d 3'

# rust CLI remaps
alias cat='bat'
alias grep='rg'
alias find='fd'
alias ls='exa'
alias du='dust'

