# Takes stdin and prints fzf output with a bat preview
function fzbat
    set -l preview "bat {-1} --color=always"
    # Change default pager of bat so it does not auto close on short files
    fzf -m --ansi --preview $preview --bind "p:execute(bat {} --pager 'less -R')"  --bind "e:execute(nvim {})"
end
