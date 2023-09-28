# Make a quick note
#
# -t/tmp: If set will make a temporary file
function jot
    argparse --ignore-unknown t/tmp -- $argv
    if count $argv > /dev/null
        set search_term $argv
        rg --files-with-matches --ignore-case $search_term $HOME/jot | fzbat
    else
        set stamp (date '+%Y-%m-%dT%H-%M-%S')
        if set -q _flag_t
            set file_path "/tmp/jot-$stamp.txt"
        else
            mkdir -p $HOME/jot
            set file_path "$HOME/jot/jot-$stamp.txt"
        end
        nvim $file_path
    end
end
