# Get a repo ready with all local elements that will not
# usually get pushed to the repo.
function _repo_setup
    argparse c/from-curent -- $argv

    set start_dir (pwd)
    if ! set -q _flag_c
        set git_root (git rev-parse --show-toplevel)
        if test "$start_dir" != "$git_root"
            echo "Not at the git root directory. Moving to the root"
            cd $git_root
        end
    else
        echo "Running from current directory"
    end

    set -l projections_dir ~/.dotfiles/nvim-conf/projections
    echo "Below are existing projections:"
    exa $projections_dir/ --icons --oneline
    read -P "Which projection do you want? (Only type the part before -projections.json) " chosen
    if test -z $chosen
        echo "No input given. Not copying"
    else
        echo "Copying across $chosen projection"
        cp "$projections_dir/$chosen-projections.json" .projections.json
    end

    cd $start_dir
end
