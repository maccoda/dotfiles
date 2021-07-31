# Script to run at start of day to grab new updates
# and to refresh all work repositories
function good-morning
  upgrade

# Add location of repository roots to check here (repo-stat will handle the rest)
  set -l repo_list

  for repo in $repo_list
    repo-stat -y $repo
  end

  ultralist ar c # Archive completed tasks
  ultralist ar gc # Clean up completed tasks
  ultralist l due:agenda # List what needs to be done today
end
