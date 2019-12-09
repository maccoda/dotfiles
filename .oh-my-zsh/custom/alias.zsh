dotfiles_dir="$HOME/.dotfiles"
alias sbox="cd ~/sandbox"
alias workon="source work_env.sh"
alias dc="docker-compose"
alias dots="code $dotfiles_dir"
alias rm-orig="fd -I orig -x rm"
alias grg='git log --pretty=format:"%h%x09%an%x09%ad%x09%s" --date=short'
alias gam='git commit -a -m'

# Base64 decode
decode() {
  echo `echo $1 | base64 --decode`
}

# Base64 encode
encode() {
  echo -n $1 | openssl base64 | pbcopy
}

commit() {
  grg | rg $1
}

#Usage: squash N where N is number of commits to squash
squash() {
  git reset --soft HEAD~${1} && git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
}

refresh() {
  git stash; git pull -r; git stash pop
}

# compile test commit
ctc() {
  $1 && git commit -m '$2'
}
alias gtc='ctc "./gradlew check"'

source $(dirname $0)/work_alias.zsh