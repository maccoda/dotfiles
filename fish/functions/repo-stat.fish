# Usage repo-stat [-y] <directory>
#
# -y: If set will not require user input and will always pull updates
# <directory>: Directory to start searching for .git directories from
#
function repo-stat
    argparse 'y' -- $argv

    set startDir $argv[1]
    test -z $startDir; and set startDir (realpath '.')
    echo "Starting at $startDir"
    if set -q _flag_y
        echo "Will automatically fetch and pull from origin"
    end

    set dirs (fd --hidden --no-ignore --type directory '\.git$' $startDir)
    set num_dirs (echo $dirs | wc -w | string trim)
    echo "Found $num_dirs git repositories"
    echo -n "Fetching updates for "
    for dir in $dirs
        set -l repoDir (echo $dir | sed "s/\/.git//")
        set -l short_name (basename $repoDir)
        echo -n "$short_name "
        cd $repoDir
        git fetch -q &
        cd - > /dev/null
    end

    echo
    wait

    for dir in $dirs
        set repoDir (echo $dir | sed 's/\/.git//')
        cd $repoDir
        set short_name (basename $repoDir)

        set git_status (git status --porcelain)
        set commits (git log origin/mainline..mainline 2> /dev/null | grep '^commit' | wc -l | tr -d " ")
        set commits_behind (git log mainline..origin/mainline 2> /dev/null | grep '^commit' | wc -l | tr -d " ")

        wait

        if test -n "$git_status"
            echo "$short_name is dirty"
        end

        if test $commits -gt 0
            echo "$short_name is ahead of origin"
        end

        if test $commits_behind -gt 0
            echo "$short_name is behind origin"
            if set -q _flag_y
                gpr
            else
                read -P "Would you like to pull updates? (y/n) " input
                switch $input
                    case Y y
                        gpr
                    case '*'
                        echo "Leaving $short_name behind origin"
                end
            end
        end
        cd - > /dev/null
    end
end
