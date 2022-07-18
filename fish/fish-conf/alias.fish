alias dc="docker-compose"
alias vim='nvim'
# git
abbr --add --global g 'git'
abbr --add --global tf 'terraform'
# Git log for rip-grepping
alias grg='git log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s"'
alias gst='git status'
alias gd='git diff'

# Simple find to use at top level dev directory to check if
# a project is checked out
alias fd-project='fd -t d -d 3'

# rust CLI remaps
alias ls='exa'
alias du='dust'

