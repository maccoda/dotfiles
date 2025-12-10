# TODO: Need some useful actions on the back of this rather than just print the file
function fzrg
    set search_term $argv[1]
    rg --ignore-case --files-with-matches --no-messages "$search_term" \
        | fzf --preview "bat {} | rg --color=always --ignore-case --pretty --context 10 '$search_term'" \
        --preview-window=up,70% --layout=reverse
end
