alias sbox="cd ~/sandbox"
alias workon="source work_env.sh"
alias docker-rm-all="docker rm $(docker ps -aq)"
alias dc="docker-compose"
alias notes="code $HOME/Notes"
alias dots="code $HOME/.maccoda_dotfiles"
alias docker-rm-latest="docker rm $(docker ps -a | sed -n 2p)"
