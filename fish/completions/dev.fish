set -l commands pr following
complete -c dev --arguments "$commands" -n "not __fish_seen_subcommand_from $commands"
complete -c dev --no-files
