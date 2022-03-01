function dev
    if test -d '/mnt/c/Users/dylan/dev'
        cd /mnt/c/Users/dylan/dev
    else
        cd "$HOME/dev"
    end
end
