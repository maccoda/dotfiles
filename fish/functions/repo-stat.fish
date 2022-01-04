# Usage repo-stat [-y] <directory>
#
# -y: If set will not require user input and will always pull updates
# <directory>: Directory to start searching for .git directories from
#
function repo-stat
    argparse 'y' -- $argv

    set intial_dir (pwd)
    set startDir (_input_or_cwd $argv[1])
    echo "Looking for repositories under $startDir"
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
    end

    echo
    wait

    for dir in $dirs
        set repoDir (echo $dir | sed 's/\/.git//')
        cd $repoDir
        set short_name (basename $repoDir)

        set commits_behind (git log mainline..origin/mainline 2> /dev/null | grep '^commit' | wc -l | tr -d " ")

        if ! set -q _flag_y
            # If -y flag is set will likely be automated so do not need the status
            heading --no-trail $short_name
            git status --short --branch
        end


        if test $commits_behind -gt 0
            echo "$short_name is behind origin by $commits_behind commits"
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
    end
    cd $intial_dir
end
