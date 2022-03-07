# This file is executed by the upgrade script. It is for any work specific
# commands do not want committed to dot files repository
function work-upgrade
    echo "Running work related upgrades"

    set repo_list (bat --plain ~/.devrc)
    for repo in $repo_list
        repo-stat -y $repo
    end
end
