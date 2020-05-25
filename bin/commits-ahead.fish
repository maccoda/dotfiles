#!/usr/bin/fish

set -l branch_name (git symbolic-ref --short HEAD)

echo (git log origin/$branch_name..$branch_name | grep '^commit' | wc -l | tr -d " ")
# Go look at this file and look into making an optional pull request
# /home/dmaccora/.local/share/omf/themes/batman/fish_right_prompt.fish