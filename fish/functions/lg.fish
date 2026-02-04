function lg --wraps='zellij run -f -c --width 90% --height 80% -x 10% -y 10% -- lazygit' --description 'alias lg zellij run -f -c --width 90% --height 80% -x 10% -y 10% -- lazygit'
    zellij run -f -c --width 90% --height 80% -x 5% -y 10% -- lazygit $argv
end
