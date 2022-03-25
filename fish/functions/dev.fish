function dev
    set command $argv[1]
    set start_dir (pwd)
    if test -z $command
        # Navigate to root dev directory
        if test -d /mnt/c/Users/dylan/dev
            cd /mnt/c/Users/dylan/dev
        else
            cd "$HOME/dev"
        end
    else if test $command = pr
        # Check status of all pull requests
        for repo in (bat --plain ~/.config/dev-tools/following)
            cd $repo
            set search_query "review:required draft:false"
            set has_prs (gh pr list --search "$search_query" --json number --limit 1 --jq '.[] | length' | string trim)
            test -z $has_prs; and set has_prs 0
            if test $has_prs -gt 0
                heading --no-trail (basename $repo)
                gh pr list --search "$search_query" --json number,title,url --template \
                    '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") .title .url}}{{end}}'
            end
        end
        cd $start_dir
    else
        echo "Unknown command $command"
        return 1
    end
end
