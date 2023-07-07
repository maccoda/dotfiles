function upgrade
    cd $HOME/.dotfiles
    gum spin --show-output --title "Pulling updates for dotfiles" -- fish -c "gpr"

    # Update any links
    ./install -q
    # Update help files
    gum spin --show-output --title "Updating help tags" -- nvim --cmd "helptags ~/.config/nvim/doc/" +qall

    cd -

    switch (uname -s)

        case Darwin
            echo "Detected MacOS. Running MacOS specific managers..."

        case Linux
            echo "Detected Linux. Running Linux specific managers..."
            sudo apt-get update -q && sudo apt-get upgrade -qy
            sudo apt-get autoremove -qy && sudo apt-get autoclean
            snap refresh

        case '*'
            echo 'Unknown OS'
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
        functions -e __general_update
    end

    if _is_work
        if test (date | cut -f 1 -d ' ') = Mon
            # Just do one big upgrade at the start of the week
            __general_update
            fish_update_completions
        end
        work-upgrade
    else
        __general_update
    end
end
