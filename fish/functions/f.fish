# Look up files workflow
function f
    set -l preview "bat {-1} --color=always"
    fd $argv --type f | fzf -m --ansi --preview $preview --bind "enter:execute(bat {})"
end
