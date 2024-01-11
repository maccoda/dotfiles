# Uber script to handle common dev actions.
#
# Motivation behind creating this is I will be able to use completions
# so that I do not need to remember each script name when it is regarding
# dev work with a repository
function repo
    set -g config_dir ~/.config/dev-tools

    git rev-parse --show-toplevel &>/dev/null
    if test $status -ne 0
        errecho "Not in git repository"
        return 126
    end

    if test (count $argv) -eq 0
        errecho "No sub command provided"
        echo "Sub-commands: feature init prune-branches follow rebase main diff switch cd"
        return 126
    end

    set command $argv[1]
    set args $argv[2..]
    if test $command = init
        _repo_setup $args
    else if test $command = prune-branches
        _repo_prune_branches $args
    else if test $command = feature
        _repo_feature $args
    else if test $command = follow
        _repo_follow $args
    else if test $command = rebase
        _repo_rebase $args
    else if test $command = main
        _repo_main $args
    else if test $command = diff
        _repo_diff $args
    else if test $command = switch
        _repo_switch $args
    else if test $command = cd
        _repo_cd $args
    else if test $command = pr
        gh pr create --draft $args && sleep 5 && gh pr checks --watch && gh pr ready
        alert
    else if test $command = log
        _repo_log $args
    else
        echo "Unknown sub-command $command"
        return 127
    end
    return $status
    set -e config_dir
end
