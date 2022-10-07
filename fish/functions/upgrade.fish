function upgrade
    cd $HOME/.dotfiles
    gum spin --title "Pulling updates for dotfiles" -- gpr

    # Update any links
    ./install -q

    # Clean any non-existent directories
    z --clean

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

    if _is_work
        if test (date | cut -f 1 -d ' ') = Mon
            # Just do one big upgrade at the start of the week
            echo "Updating brew taps..."
            brew upgrade
            brew cleanup
            brew autoremove

            gum spin --title "Updating fisher packages" -- fish -c "fisher update"
            fish_update_completions

            echo "Updating vim..."
            nvim +PlugUpgrade +PlugUpdate +PlugClean +TSUpdateSync +qall
        end

        work-upgrade
    else
        echo "Updating brew taps..."
        brew upgrade
        brew cleanup
        brew autoremove

        gum spin --title "Updating fisher packages" -- fish -c "fisher update"

        echo "Updating vim..."
        nvim +PlugUpgrade +PlugUpdate +PlugClean +TSUpdateSync +qall
    end
end
