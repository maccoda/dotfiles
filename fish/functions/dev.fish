function dev
    function __dev_config_folowing
        dasel --file $MACCODA_CONFIG ".repos.all().path"
    end
    set command $argv[1]
    set start_dir (pwd)
    if test -z $command
        # Navigate to root dev directory
        if test -d /mnt/c/Users/dylan/dev
            cd /mnt/c/Users/dylan/dev
        else
            cd "$HOME/dev"
        end
        eza
    else if test $command = pr
        set repo_search
        for repo in (__dev_config_folowing)
            cd (string unescape $repo)
            set repo_name (git remote -v | rg "origin.+fetch" | cut -d ":" -f 2 | cut -d "." -f 1)
            set --append repo_search $repo_name
        end
        set joined (string join "," $repo_search)
        set template '{{range .}}{{tablerow (printf "#%v" .number | autocolor "green") (printf "@%v" .author.login | autocolor "blue") (truncate 60 .title) .url (timeago .createdAt | printf "C: %v") (timeago .updatedAt | printf "U: %v")}}{{end}}'
        set github_org (dasel --file $MACCODA_CONFIG "github_org" | string unescape)

        heading --no-trail "Review requests"
        gh search prs --state=open --owner=$github_org --review-requested=@me --draft=false --repo $joined --json number,title,url,author,createdAt,updatedAt --template $template

        heading --no-trail "Reviews created"
        gh search prs --author=@me --state=open --owner=$github_org --draft=false --review=required --json number,title,url,author,createdAt,updatedAt --template $template -- NOT "[Snyk]"
        heading --no-trail "Approved created reviews"
        gh search prs --author=@me --state=open --owner=$github_org --draft=false --review=approved --json number,title,url,author,createdAt,updatedAt --template $template -- NOT "[Snyk]"

        cd $start_dir
    else if test $command = following
        echo "Currently following these repositories:"
        for repo in (__dev_config_folowing)
            echo -e "$(basename $repo | string pad --width 40 --right) $repo"
        end
    else
        echo "Unknown command $command"
        return 1
    end
end
