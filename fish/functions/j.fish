function j
    if test $argv[1] = -
        cd -
        set home_path "$HOME/dev/"
        set title (pwd | sed s#$home_path## | cut -d '/' -f 1)
        zellij action rename-tab $title
        return
    end
    set choice (zoxide query --interactive --score $argv | string trim | cut -f 2)
    if test -z $choice
        return
    end
    set home_path "$HOME/dev/"
    set title (echo $choice | sed s#$home_path## | cut -d '/' -f 1)
    zellij action rename-tab $title
    cd $choice
    $FILE_PICKER
end
