# Stores the repo to be used for other scripts that track it for PRs, etc
function _repo_follow
    set repo_path (pwd)
    if rg --quiet $repo_path $MACCODA_CONFIG
        echo "Already following $repo_path"
    else
        echo "Following $repo_path"
        dasel put object --write toml -f $MACCODA_CONFIG --type string "repos.[]" path="$repo_path"
    end
end
