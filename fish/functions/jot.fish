# Make a quick temporary note
function jot
    set stamp (date '+%Y-%m-%dT%H-%M-%S')
    nvim "/tmp/jot-$stamp.txt"
end
