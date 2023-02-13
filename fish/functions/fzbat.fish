# Takes stdin and prints fzf output with a bat preview
function fzbat
    set -l preview "bat {-1} --color=always"
    fzf -m --ansi --preview $preview --bind "enter:execute(bat {})"
end
