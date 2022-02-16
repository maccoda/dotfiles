# Get a repo ready with all local elements that will not
# usually get pushed to the repo.
function repo-setup
    ls .git &> /dev/null
    if test $status -ne 0
        echo "Not at the git root directory. This script must run at the root"
        return 1
    end
    set -l projections_dir ~/.dotfiles/nvim-conf/projections
    echo "Below are existing projections:"
    exa $projections_dir/ --icons --oneline
    read -P "Which projection do you want? (Only type the part before -projections.json) " chosen
    echo "Copying across $chosen projection"
    cp $projections_dir/$chosen-projections.json .projections.json
end
