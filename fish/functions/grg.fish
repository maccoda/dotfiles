# Git log formatted for better grepping
function grg --wraps='git log' --description 'alias for grep format for git log'
    git log --pretty="format:%C(yellow)%h%C(reset) %C(magenta)%cs%C(reset) %s %C(blue)[%an]%C(reset) %C(red)%d%C(reset)" $argv
end
