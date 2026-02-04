function rename-tab --wraps='zellij action rename-tab (basename (pwd))' --description 'alias rename-tab zellij action rename-tab (basename (pwd))'
    zellij action rename-tab (basename (pwd)) $argv
end
