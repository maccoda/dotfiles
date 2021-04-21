# Usage: Handy neovim editing short cut
function nv
    if test -e Session.vim
        nvim
    else
        nvim .
    end
end
