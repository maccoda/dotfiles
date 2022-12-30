# Make a quick note
function jot
    mkdir -p $HOME/jot
    set stamp (date '+%Y-%m-%dT%H-%M-%S')
    set file_path "$HOME/jot/jot-$stamp.txt"
    nvim $file_path
end
