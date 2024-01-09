# Ring the terminal bell
function alert --wraps='tput bel' --description 'alias alert=tput bel'
    tput bel $argv

end
