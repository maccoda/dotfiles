# Delete all branches that have been removed upstream
function _repo_prune_branches
    argparse f/force n/no-fetch -- $argv

    if ! set -q _flag_n
        gum spin --title "Fetching all branches" -- git fetch --all --prune --quiet
    end
    set removed_branches (git branch -vv | rg ": gone]" | tr -s ' ' | cut -d ' ' -f 2)
    for branch in $removed_branches
        if set -q _flag_f
            git branch -D $branch
        else
            git branch -d $branch &>/dev/null
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
    set local_only_branches (git branch -vv | rg --invert-match "(origin|\*)" | tr -s ' ' | cut -w -f 2)
    echo "Attempting to delete local only branches"
    for branch in $local_only_branches
        git branch -d $branch
    end
end
