# Usage: Handy neovim editing short cut to open in a repository
function nv
    if count $argv > /dev/null
        # Just opening a file
        nvim $argv
    else
        if ! test -f .projections.json
            repo init
        end

        if test -e Session.vim
            nvim -S Session.vim
        else
            nvim .
        end
    end
end
