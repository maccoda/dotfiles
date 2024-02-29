# Usage: Handy neovim editing short cut to open in a repository
function nv
    if count $argv >/dev/null
        # Just opening a file
        $EDITOR $argv
    else
        if ! test -f .projections.json
            repo init -c
        end

        if test -e Session.vim
            $EDITOR -S Session.vim
        else
            # Whilst using Helix open a file viewer that can open helix
            $FILE_PICKER
        end
    end
end
