#!/usr/bin/fish

set -l branch_name (git symbolic-ref --short HEAD)

echo (git log origin/$branch_name..$branch_name | grep '^commit' | wc -l | tr -d " ")
