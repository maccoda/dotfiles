function upgrade
    argparse f/force -- $argv
    or return
    cd $HOME/.dotfiles
    gum spin --title "Pulling updates for dotfiles" -- fish -c gpr && echo "Finished updating dotfiles"

    # Update any links
    ./install -q
    # Update help files
    gum spin --title "Updating help tags" -- nvim --cmd "helptags ~/.config/nvim/doc/" +qall && echo "Updated help tags"

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
            sudo apt-get update -q && sudo apt-get upgrade -qy
            sudo apt-get autoremove -qy && sudo apt-get autoclean
            snap refresh

        case '*'
            errecho 'Unknown OS'
            exit 1
    end

    function __general_update
        echo "Updating brew taps..."
        brew upgrade
        brew cleanup
        brew autoremove

        gum spin --title "Updating fisher packages" -- fish -c "fisher update"

        gum spin --title "Updating nnn plugins" -- sh -c "$(curl -Ls https://raw.githubusercontent.com/jarun/nnn/master/plugins/getplugs)"

        echo "Updating vim..."
        nvim +PlugUpgrade +PlugUpdate +PlugClean +TSUpdateSync +qall

        echo "Generating completions"
        # Some tools do not get the completions added as part of the instalation process so do them manually
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
