# Script to run at start of day to grab new updates
# and to refresh all work repositories
function good-morning
  upgrade

# Add location of repository roots to check here (repo-stat will handle the rest)
  set -l repo_list

  for repo in $repo_list
    repo-stat -y $repo
  end
end
