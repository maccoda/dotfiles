# Iterate through all git repositories under the provided
# workspace and check which commits occurred yesterday for
# a stand up check

function stand-up-check
    set startDir $argv[1]
    test -z $startDir; and set startDir (realpath '.')

    echo "Checking for local changes under $startDir"
    set dirs (fd --hidden --no-ignore --type directory --max-depth 4 '.git$' $startDir)
    for dir in $dirs
        set -l repoDir (echo $dir | sed "s/\/.git//")
        set -l short_name (basename $repoDir)
        echo $short_name
        cd $repoDir
        git yesterday
        cd ..
    end
end
