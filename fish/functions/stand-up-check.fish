# Iterate through all git repositories under the provided
# workspace and check which commits occurred yesterday for
# a stand up check.
# Also checks tasks completed yesterday

function stand-up-check
    set startDir $argv[1]
    test -z $startDir; and set startDir "$HOME/dev"

    heading "Looking for repositories under $startDir"

    set initial_dir (pwd)
    set dirs (_get_git_dirs $startDir)
    for dir in $dirs
        set -l repoDir (echo $dir | sed "s/\/.git//")
        set -l short_name (basename $repoDir)
        cd $repoDir
        set -l git_yesterday (git yesterday)
        if test -n "$git_yesterday"
            heading --no-trail $short_name
            git yesterday
        end

        cd ..
    end
    cd $initial_dir

    heading "Checking for tasks completed yesterday"

    task end.after:today-1day completed
end
