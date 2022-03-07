function dev
    set command $argv[1]
    if test -z $command
        # Navigate to root dev directory
        if test -d /mnt/c/Users/dylan/dev
            cd /mnt/c/Users/dylan/dev
        else
            cd "$HOME/dev"
        end
    else if test $command = pr
        # Check status of all pull requests
        for repo in (bat --plain ~/.devrc)
            cd $repo
            gh pr list
        end
    else
        echo "Unknown command $command"
        return 1
    end
end
