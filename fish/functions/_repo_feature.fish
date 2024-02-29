# Function for the repetitive stuff for starting new feature work with Github model
function _repo_feature
    argparse c/from-current -- $argv
    git rev-parse 2&>/dev/null
    if test $status -ne 0
        echo "Not a git directory"
        return 1
    end
    set -l repo_status (git status --porcelain)
    if test -n "$repo_status"
        echo "Detected local changes, stashing all"
        git stash --include-untracked 2&>/dev/null
    end

    if ! set -q _flag_c
        set main_branch (_git_main_branch)
        echo "Determined main branch is $main_branch"
    else
        echo "Creating new branch from current"
    end

    # Pull latest changes
    gum spin --title "Pulling latest changes..." -- git pull --ff --quiet origin $main_branch

    # Create the new branch for the feature
    if test -z $argv[1]
        set jira_id (gum input --prompt="Enter branch name: ")
    else
        set jira_id $argv
    end
    set jira_id_cleaned (echo $jira_id | sed 's/ /-/g')
    if ! git switch -c $jira_id_cleaned
        echo "Failed to switch branch"
        return 1
    end
    if test -n "$repo_status"
        git stash pop 2&>/dev/null
    end

end
