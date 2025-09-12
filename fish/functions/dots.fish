# Open dots files
function dots
    set initial_dir (pwd)
    cd $HOME/.dotfiles
    $EDITOR .
    cd $initial_dir
end
