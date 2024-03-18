# Function taken from Kitty website - https://sw.kovidgoyal.net/kitty/kittens/hyperlinked_grep/
# Allows for jumping directly to a specific line in your editor based on the matches using hints kitten
function hg --wraps='kitten hyperlinked_grep' --description 'alias hg kitten hyperlinked_grep'
    kitten hyperlinked_grep $argv
    echo "Ctl-Sh-p>y to access hyperlinks"
end
