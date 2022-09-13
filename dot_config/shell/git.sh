alias gbr="git branch --sort=-committerdate | head -5"
alias gf="git fetch"
alias gfarm="gcm; git fetch && git rebase origin/main"
alias gp="git push"
alias gm="git merge"
alias grh="git reset --hard"
alias grm="git rebase main"
alias gcp="git cherry-pick"
alias lg="lazygit"

gcm() {
  branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  git checkout "$branch"
}
