# Takes stdin and prints fzf output with a bat preview
function fzbat
    set -l preview "bat {-1} --color=always"
    # Change default pager of bat so it does not auto close on short files
    fzf -m --ansi --preview $preview \
        --bind "ctrl-v:execute(bat {} --pager 'less -R')" \
        --bind "ctrl-e:execute(nvim {})" \
        --header 'CTRL-v to preview | CTRL-e to edit'
end
