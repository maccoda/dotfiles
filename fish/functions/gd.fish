# Interactive git staging
function gd
    set -l preview "git diff $argv --color=always -- :/{-1}"
    git diff $argv --name-only | fzf -m --ansi --preview $preview \
    --preview-window=up \
    --bind "s:execute-silent(git add {})+reload(git diff $argv --name-only),p:execute(git add -p {}),ctrl-r:reload(git diff $argv --name-only)" \
    --header 'Press Ctrl+r to reload'
end
