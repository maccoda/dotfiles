function new-tab
    set choice (zoxide query --interactive --score | cut -w -f 3)
    set title (basename $choice)
    kitty @launch --type tab --hold --cwd $choice --tab-title $title
end
