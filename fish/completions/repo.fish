# Completions for repo command
set -l commands feature init prune-branches follow rebase main diff switch cd pr log pr-co
complete --command repo --arguments "$commands" --condition "not __fish_seen_subcommand_from $commands"
complete --command repo --long-option from-current --condition "__fish_seen_subcommand_from feature"
complete --command repo --condition "not __fish_seen_subcommand_from log" --no-files
complete --command repo --condition "__fish_seen_subcommand_from rebase" --arguments "(git branch --format='%(refname:short)')"
complete --command repo --condition "__fish_seen_subcommand_from diff" --arguments "main tag"
