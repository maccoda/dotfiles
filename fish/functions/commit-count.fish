# Shows the number of commits for each author for the given path (directory or file)
function commit-count
    set path _input_or_cwd $argv
    git log --pretty=short -- $path | sed -n 's/^Author:\(.*\) <.*$/\1/p' | sort | uniq -c
end
