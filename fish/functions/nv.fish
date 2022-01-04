# Usage: Handy neovim editing short cut to open in a repository
function nv
    if test -d .git
        git fetch --prune --quiet &
    end

    if test -e Session.vim
        nvim
    else
        nvim .
    end
end
