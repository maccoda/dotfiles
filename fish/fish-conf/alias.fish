alias dc="docker-compose"
alias vim='nvim'
# git
abbr --add g 'git'
abbr --add tf 'terraform'
abbr --add r 'repo'
# Git log for rip-grepping
alias grg='git log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s"'
abbr --add gst 'git status'
abbr --add gd 'git diff'
abbr --add glo 'git logp'

# Simple find to use at top level dev directory to check if
# a project is checked out
alias fd-project='fd -t d -d 3'

# rust CLI remaps
abbr --add l 'exa'
abbr --add ls 'exa'
alias du='dust'

# Ring the terminal bell
alias alert="tput bel"

alias nnn="nnn -e"
