# Script to run at start of work day or log in to upgrade
# packages and check current status of work.
function good-morning
    set start_dir (pwd)
    upgrade
    echo "Removing old LSP log"
    rm_exists $HOME/.local/state/nvim/lsp.log

    # Capture installed 
    brew list --installed-on-request >$HOME/.dotfiles/brew-installed.txt

    rm $HOME/.dotfiles/snippets.json
    the-way export >$HOME/.dotfiles/snippets.json
    if _is_work
        heading --no-trail "Tasks remaining"
        task due.before:eoww+1h
        if test (date | cut -f 1 -d ' ') = Mon
            heading --no-trail "Journal entries from last week"
            jrnl -from "last week"
        else
            heading --no-trail "Journal entries from yesterday"
            jrnl -on yesterday
        end
        dev pr
    end
    cd $start_dir
end
