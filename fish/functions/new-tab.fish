function new-tab
    set choice (zoxide query --interactive --score | cut -f 2)
    if test -z $choice
        return
    end
    set home_path "$HOME/dev/"
    set title (echo $choice | sed s#$home_path## | cut -d '/' -f 1)
    kitty @launch --type tab --hold --cwd $choice --tab-title $title
end
