# Uber script to handle common dev actions.
#
# Motivation behind creating this is I will be able to use completions
# so that I do not need to remember each script name when it is regarding
# dev work with a repository
function repo
    set -g config_dir ~/.config/dev-tools

    set start_dir (pwd)
    set git_root (git rev-parse --show-toplevel)
    if test "$start_dir" != "$git_root"
        echo "Not at the git root directory. Moving to the root"
        cd $git_root
    end

    if test (count $argv) -eq 0
        echo "ERROR: No sub command provided"
        return 126
    end

    # Get a repo ready with all local elements that will not
    # usually get pushed to the repo.
    function __repo_setup
        set -l projections_dir ~/.dotfiles/nvim-conf/projections
        echo "Below are existing projections:"
        exa $projections_dir/ --icons --oneline
        # TODO: This should specify the source folder also because the file can be nested and this would work for the monorepo style
        read -P "Which projection do you want? (Only type the part before -projections.json) " chosen
        # TODO: Should validate there is at least input or capture the copy failure
        echo "Copying across $chosen projection"
        cp $projections_dir/$chosen-projections.json .projections.json

        functions -e __repo_setup
    end

    # Delete all branches that have been removed upstream
    function __repo_prune_branches
        argparse f/force -- $argv

        git fetch --all --prune --quiet
        set removed_branches (git branch -vv | rg ": gone]" | tr -s ' ' | cut -d ' ' -f 2)
        echo "Branches to remove: $removed_branches"
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
        echo "Following $repo_path"

        set following_file "$config_dir/following"
        echo $repo_path >>$following_file
        cp $following_file /tmp/devrc_following
        sort -u /tmp/devrc_following >$following_file

        functions -e __repo_follow
    end

    function __repo_rebase
        set rebase_branch $argv[1]
        echo "Rebasing onto $rebase_branch"
        git fetch origin "$rebase_branch:$rebase_branch"
        # Need this if reusing an old branch previously merged and deleted
        git fetch --prune
        set repo_status (git status --porcelain)
        if test -z "$repo_status"
            git rebase $rebase_branch
        else
            echo "Detected local changes, stashing all"
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
            git pull
        else
            echo "Detected local changes, stashing all"
            git stash --include-untracked >/dev/null
            git switch main &>/dev/null || git switch master &>/dev/null
            git pull
            git stash pop >/dev/null
        end
        functions -e __repo_main
    end

    set command $argv[1]
    set args $argv[2..]
    if test $command = init
        __repo_setup
    else if test $command = prune-branches
        __repo_prune_branches $args
    else if test $command = feature-start
        feature-start $args
    else if test $command = follow
        __repo_follow $args
    else if test $command = rebase
        __repo_rebase $args
    else if test $command = main
        __repo_main $args
    else
        echo "Unknown sub-command $command"
        return 127
    end
    cd $start_dir
    set -e config_dir
end
