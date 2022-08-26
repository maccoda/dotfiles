# Completions for repo command
set -l commands feature init prune-branches follow rebase main diff switch cd
complete -c repo --arguments "$commands" -n "not __fish_seen_subcommand_from $commands"
complete -c repo --long-option "from-current" -n "__fish_seen_subcommand_from feature"
complete -c repo --no-files
complete -c repo -n "__fish_seen_subcommand_from rebase" -a "(git branch --format='%(refname:short)')"
complete -c repo -n "__fish_seen_subcommand_from diff" -a "main tag"
