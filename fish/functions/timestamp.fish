function timestamp
    argparse from-epoch epoch -- $argv
    or return
    if set -q _flag_from_epoch
        # strip the first 10 digits so it is in seconds not milliseconds
        set in_milli (string sub --length 10 $argv)
        date -r $in_milli
    else if set -q _flag_epoch
        date "+%s"
    else
        date '+%Y-%m-%dT%H-%M-%S'
    end
end
