# Make a quick note
#
# -t/tmp: If set will make a temporary file
# -s/search: Search for an existing note
function jot
    argparse --ignore-unknown t/tmp s/search -- $argv
    if set -q _flag_s
        set search_term $argv
        test -z $search_term; and set search_term ""
        rg --files-with-matches --ignore-case $search_term $HOME/jot | fzbat
    else
        set stamp (date '+%Y-%m-%dT%H-%M-%S')
        set title (gum input --prompt "Title: ")
        if test -z $title
            return
        end
        set file_title (echo $title | sed 's/ /-/g' | tr "[:upper:]" "[:lower:]")
        if set -q _flag_t
            set file_path "/tmp/jot-$file_title-$stamp.md"
        else
            mkdir -p $HOME/jot
            set file_path "$HOME/jot/$file_title-$stamp.md"
        end
        touch $file_path
        echo -e "# $title\n" >>$file_path
        echo $stamp >>$file_path
        echo >>$file_path
        $EDITOR $file_path
    end
end
