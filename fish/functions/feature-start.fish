# Function for the repetitive stuff for starting new feature work with Github model
function feature-start
    argparse 'c/from-current' -- $argv
    git rev-parse 2&>/dev/null
    if test $status -ne 0
        echo "Not a git directory"
        return 1
    end
    set -l repo_status (git status --porcelain)
    if test -n "$repo_status"
        echo "Detected local changes, stashing all"
        git stash --include-untracked
    end

    if ! set -q _flag_c
        # Look for the main branch
        git switch main &>/dev/null; or git switch master &>/dev/null
        if test $status -ne 0
            echo "Unknown main branch"
            git branch
            return 1
        end
        set main_branch (git branch --show-current)
        echo "Determined main branch is $main_branch"
    else
        echo "Creating new branch from current"
    end

    # Pull latest changes
    echo "Pulling latest changes..."
    git pull --ff --quiet

    # Create the new branch for the feature
    if test -z $argv[1]
        read -P "Enter JIRA ticket ID: " jira_id
    else
        set jira_id $argv
    end
    set jira_id_cleaned (echo $jira_id | sed 's/ /-/g')
    if ! git switch -c $jira_id_cleaned
        echo "Failed to switch branch"
        return 1
    end
    if test -n "$repo_status"
        git stash pop
    end


end
