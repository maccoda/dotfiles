# Stores the repo to be used for other scripts that track it for PRs, etc
function _repo_follow
    set git_root (git rev-parse --show-toplevel)

    if rg --quiet $git_root $MACCODA_CONFIG
        echo "Already following $git_root"
    else
        echo "Following $git_root"
        dasel put --read toml -f $MACCODA_CONFIG --type json --value "{\"path\": \"$git_root\"}" --pretty --selector "repos.append()"
    end
end
