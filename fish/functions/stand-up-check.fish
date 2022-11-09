# Iterate through all git repositories under the provided
# workspace and check which commits occurred yesterday for
# a stand up check.
# Also checks tasks completed yesterday

function stand-up-check
    set startDir $argv[1]
    test -z $startDir; and set startDir "$HOME/dev"

    set day (date | cut -f 1 -d ' ')

    if test $day = Mon
        echo "Is Monday"
        set git_after "last friday"
    else
        set git_after "yesterday"
    end

    heading "Looking for repositories under $startDir"

    set initial_dir (pwd)
    set dirs (_get_git_dirs $startDir)
    for dir in $dirs
        set -l repoDir (echo $dir | sed "s/\/.git//")
        set -l short_name (basename $repoDir)
        cd $repoDir
        set -l git_yesterday (git log --after=$git_after --author='Dylan Maccora')
        if test -n "$git_yesterday"
            heading --no-trail $short_name
            git log --after=$git_after --author='Dylan Maccora' --oneline
        end

        cd ..
    end
    cd $initial_dir

    heading "Checking for tasks completed"
    if test $day = Mon
        set days_back "3day"
    else
        set days_back "1day"
    end

    task end.after:today-$days_back completed
end
