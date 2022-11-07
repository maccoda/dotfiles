# Uber script to handle common dev actions.
#
# Motivation behind creating this is I will be able to use completions
# so that I do not need to remember each script name when it is regarding
# dev work with a repository
function repo
    set -g config_dir ~/.config/dev-tools

    git rev-parse --show-toplevel &>/dev/null
    if test $status -ne 0
        echo "ERROR: Not in git repository"
        return 126
    end

    if test (count $argv) -eq 0
        echo "ERROR: No sub command provided"
        echo "Sub-commands: feature init prune-branches follow rebase main diff switch cd"
        return 126
    end
    # Get a repo ready with all local elements that will not
    # usually get pushed to the repo.
    function __repo_setup

        set start_dir (pwd)
        set git_root (git rev-parse --show-toplevel)
        if test "$start_dir" != "$git_root"
            echo "Not at the git root directory. Moving to the root"
            cd $git_root
        end
        set -l projections_dir ~/.dotfiles/nvim-conf/projections
        echo "Below are existing projections:"
        exa $projections_dir/ --icons --oneline
        # TODO: This should specify the source folder also because the file can be nested and this would work for the monorepo style
        read -P "Which projection do you want? (Only type the part before -projections.json) " chosen
        # TODO: Should validate there is at least input or capture the copy failure
        echo "Copying across $chosen projection"
        cp $projections_dir/$chosen-projections.json .projections.json

        cd $start_dir
        functions -e __repo_setup
    end

    # Delete all branches that have been removed upstream
    function __repo_prune_branches
        # TODO: Probably also want to clean any branches that are only local and have no upstream
        argparse f/force n/no-fetch -- $argv

        if ! set -q _flag_n
            gum spin --title "Fetching all branches" -- git fetch --all --prune --quiet
        end
        set removed_branches (git branch -vv | rg ": gone]" | tr -s ' ' | cut -d ' ' -f 2)
        for branch in $removed_branches
            if set -q _flag_f
                git branch -D $branch
            else
                git branch -d $branch
                if test $status -ne 0
                    echo "Failed to soft delete $branch, perhaps you use squash and merge".
                    read -P "Would you like to force delete? (y/n) " response
                    if test $response = y
                        git branch -D $branch
                    else
                        echo "Leaving local branch $branch"
                    end
                else
                    echo "Deleted $branch"
                end
            end
        end

        functions -e __repo_prune_branches
    end

    # Stores the repo to be used for other scripts that track it for PRs, etc
    function __repo_follow
        set repo_path (pwd)
        if rg --quiet $repo_path $MACCODA_CONFIG
            echo "Already following $repo_path"
        else
            echo "Following $repo_path"
            dasel put object --parser toml -f $MACCODA_CONFIG --type string "repos.[]" path="$repo_path"
        end

        functions -e __repo_follow
    end

    function __repo_rebase
        set rebase_branch $argv[1]
        echo "Rebasing onto $rebase_branch"
        gum spin --title "Fetching latest changes from $rebase_branch" -- git fetch origin "$rebase_branch:$rebase_branch"
        # Need this if reusing an old branch previously merged and deleted
        git fetch --prune
        set repo_status (git status --porcelain)
        if test -z "$repo_status"
            git rebase $rebase_branch
        else
            git stash --include-untracked >/dev/null
            git rebase $rebase_branch
            git stash pop >/dev/null
        end
        functions -e __repo_rebase
    end

    function __repo_main
        set repo_status (git status --porcelain)
        if test -z "$repo_status"
            git switch main &>/dev/null || git switch master &>/dev/null
            gum spin --title "Pulling latest changes on main" -- git pull --prune
        else
            git stash --include-untracked >/dev/null
            git switch main &>/dev/null || git switch master &>/dev/null
            gum spin --title "Pulling latest changes on main" -- git pull --prune
            git stash pop >/dev/null
        end
        __repo_prune_branches --force --no-fetch
        functions -e __repo_main
    end

    function __repo_diff
        # Some useful diffs presets
        set choice $argv[1]
        if test $choice = main
            git branch | rg main &>/dev/null
            if test $status -ne 0
                set main_branch master
            else
                set main_branch main
            end
            git diff $main_branch
        else if test $choice = tag
            git diff (git last-tag)..HEAD
        else
            echo "Unknown diff choice $choice"
            return 1
        end

        functions -e __repo_diff
    end

    function __repo_switch
        git branch --format='%(refname:short)' | gum choose | xargs git switch
        functions -e __repo_switch
    end

    function __repo_cd
        cd (git rev-parse --show-toplevel)
        if test -d ./projects
            set projects_root projects
        else if test -d ./packages
            set projects_root packages
        else
            echo "Unknown package structure"
            return 1
        end
        set dirs (ls $projects_root)
        set choice (echo "^ $dirs" | string split -n ' ' | gum filter --limit=1)
        echo $choice
        if test $choice = "^"
            cd (git rev-parse --show-toplevel)
        else
            cd "$projects_root/$choice"
        end
        functions -e __repo_cd
    end

    set command $argv[1]
    set args $argv[2..]
    if test $command = init
        __repo_setup
    else if test $command = prune-branches
        __repo_prune_branches $args
    else if test $command = feature
        feature-start $args
    else if test $command = follow
        __repo_follow $args
    else if test $command = rebase
        __repo_rebase $args
    else if test $command = main
        __repo_main $args
    else if test $command = diff
        __repo_diff $args
    else if test $command = switch
        __repo_switch $args
    else if test $command = cd
        __repo_cd $args
    else
        echo "Unknown sub-command $command"
        return 127
    end
    set -e config_dir
end
