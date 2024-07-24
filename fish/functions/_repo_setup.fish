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

    cd $start_dir
end
