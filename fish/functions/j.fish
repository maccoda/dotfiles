function j
    if test $argv[1] = -
        cd -
        set home_path "$HOME/dev/"
        set title (pwd | sed s#$home_path## | cut -d '/' -f 1)
        kitty @set-tab-title $title
        return
    end
    set choice (zoxide query --interactive --score $argv | string trim | cut -w -f 2)
    if test -z $choice
        return
    end
    set home_path "$HOME/dev/"
    set title (echo $choice | sed s#$home_path## | cut -d '/' -f 1)
    kitty @set-tab-title $title
    cd $choice
end
