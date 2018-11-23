alias sbox="cd ~/sandbox"
alias workon="source work_env.sh"
alias docker-rm-all="docker rm $(docker ps -aq)"
alias dc="docker-compose"
alias notes="code $HOME/Notes"
alias dots="code $HOME/.maccoda_dotfiles"
alias docker-rm-latest="docker rm $(docker ps -a | sed -n 2p)"
alias rm-orig="fd -I orig -x rm"

# Base64 decode
decode() {
  echo `echo $1 | base64 --decode`
}

# Base64 encode
encode() {
  echo -n $1 | openssl base64 | pbcopy
}