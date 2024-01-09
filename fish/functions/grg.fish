# Git log formatted for better grepping
function grg --wraps='git log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s"' --description 'alias grg=git log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s"'
    git log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s" $argv

end
