function upgrade
    echo "Pulling updates for dotfiles..."
    cd $HOME/.dotfiles
    git submodule update --recursive --remote
    gpr

    # Update any links
    ./install

    switch (uname -s)

       case Darwin
          echo "Detected MacOS. Running MacOS specific managers..."

       case Linux
          echo "Detected Linux. Running Linux specific managers..."
          sudo apt-get update -q
          sudo apt-get upgrade -qy
          sudo apt-get autoremove -qy
          snap refresh

       case '*'
         echo 'Unknown OS'
         exit 1
    end

    echo "Updating brew taps..."
    brew upgrade
    brew cleanup
    brew autoremove

    echo "Updating fisher packages..."
    fisher update

    echo "Updating rust..."
    rustup update

    echo "Updating vim..."
    nvim +PlugUpdate +qall
    nvim +PlugClean +qall

   work-upgrade
end
