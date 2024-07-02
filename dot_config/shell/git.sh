alias gbr="git branch --sort=-committerdate | head -5"
alias gco="git checkout"
alias gf="git fetch"
alias gfarm="gcm; git fetch && git rebase origin/main"
alias gp="git pull"
alias gP="git push"
alias gm="git merge"
alias grh="git reset --hard"
alias grm="git rebase main"
alias gcp="git cherry-pick"
alias gwa="git worktree add"
alias gwl="git worktree list"
alias gwr="git worktree remove"
alias gu="gitui"

gcm() {
  branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  git checkout "$branch"
}

# kudos https://stackoverflow.com/questions/9810327/zsh-auto-completion-for-git-takes-significant-amount-of-time-can-i-turn-it-off/9810485#981048
__git_files () {
  _wanted files expl 'local files' _files
}
