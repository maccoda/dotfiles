function _repo_cd
    cd (git rev-parse --show-toplevel)
    if test -d ./projects
        set projects_root projects
    else if test -d ./packages
        set projects_root packages
    else
        echo "Unknown package structure"
        return 1
    end
    set dirs (ls $projects_root)
    set choice (echo ".. $dirs" | string split -n ' ' | fzf --no-multi --height "~10")
    if test -z $choice
        echo "No choice made. Not changing"
    else if test $choice = ".."
        cd (git rev-parse --show-toplevel)
    else
        cd "$projects_root/$choice"
    end
end
