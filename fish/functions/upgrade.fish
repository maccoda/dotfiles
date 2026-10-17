function upgrade
    argparse f/force -- $argv
    or return

    function __ensure_ssh
        if ssh-add -l >/dev/null 2>&1
            return 0
        end
        echo "SSH key not loaded. Attempting to load..."
        if test (uname -s) = Darwin
            ssh-add --apple-use-keychain 2>/dev/null
            or ssh-add
        else
            ssh-add
        end
        if test $status -ne 0
            echo "Failed to load SSH key. Aborting upgrade."
            return 1
        end
    end

    __ensure_ssh
    or return
    functions -e __ensure_ssh

    cd $HOME/.dotfiles
    _spin --title "Pulling updates for dotfiles" -- fish -c gpr && echo "Finished updating dotfiles"

    # Update any links
    ./install -q
    # Update help files
    _spin --title "Updating help tags" -- "nvim --cmd 'helptags ~/.config/nvim/doc/' +qall" && echo "Updated help tags"

    cd -

    cd ~/dev/irises.nvim
    _spin --title "Updating colour theme" -- fish -c gpr && echo "Finished updating irises.nvim"
    cd -

    cd ~/dev/repo.fish
    _spin --title "Updating repo.fish" -- fish -c gpr && echo "Finished updating repo.fish"
    cd -

    set day (date | cut -f 1 -d ' ')
    if set -q _flag_f
        echo "Forcing an update"
    else if test $day != Mon
        if _is_work
            echo "No upgrade today"
            return
        end
    end

    switch (uname -s)

        case Darwin
            echo "Detected MacOS. Running MacOS specific managers..."
            brew upgrade --casks

        case Linux
            echo "Detected Linux. Running Linux specific managers..."
            sudo dnf upgrade -y
            sudo dnf autoremove -y

        case '*'
            errecho 'Unknown OS'
            exit 1
    end

    function __general_update
        echo "Updating brew taps..."
        brew upgrade
        brew cleanup
        brew autoremove

        _spin --title "Updating fisher packages" -- "fisher update"

        echo "Updating vim..."
        nvim +Lazy update +TSUpdateSync +qall

        echo "Generating completions"
        # Some tools do not get the completions added as part of the installation process so do them manually
        the-way complete fish >$__fish_config_dir/completions/the-way.fish
        zellij setup --generate-completion fish >$__fish_config_dir/completions/zellij.fish

        fish_update_completions
        functions -e __general_update
    end

    if _is_work
        __general_update
        work-upgrade
    else
        __general_update
    end
end
