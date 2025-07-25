# Usage: Handy neovim editing short cut to open in a repository
function nv
    if count $argv >/dev/null
        # Just opening a file
        $EDITOR $argv
    else
        $EDITOR
    end
end
