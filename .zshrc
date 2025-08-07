export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

source $HOME/.cargo/env
export PATH=$PATH:/Users/orlandoromo/dev-cluster/scripts
export PATH=$PATH:/Users/orlandoromo/omg
export PATH=$PATH:/usr/local/go/bin 
export PATH=$PATH:$GOPATH/bin

plugins=(git)

source $ZSH/oh-my-zsh.sh


eval "$(starship init zsh)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/robbyrussell.omp.json)"
ulimit -n 8096

alias lsi="logo-ls -1"
alias gotest="go test -v -run Test"
alias gs="git status -s"
alias prune="docker system prune --all --volumes"
alias dash="gh dash"
alias gitui="gitui --theme frappe.ron"
alias tree-add="git worktree add $@"
alias tree-remove="git worktree remove $@ --force"
alias gitlog="git log --all --decorate --oneline --graph --pretty=format:'%C(auto)%h%Creset - %C(bold blue)%an%Creset, %Cgreen%ar%Creset : %s' --abbrev=7"
alias gitui="gitui -t theme.ron"

alias curl="curl $@" | jq
eval "$(zoxide init zsh)"
alias gitui="gitui -t theme.ron"

export PATH=$PATH:/usr/local/go/bin


alias bat="batcat"
alias cat="bat --plain" 

export FZF_DEFAULT_OPTS='
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
  --color=fg+:#282828,bg+:#fabd2f,hl+:#fe8019
  --color=info:#83a598,prompt:#b8bb26,pointer:#fe8019
  --color=marker:#d3869b,spinner:#d3869b,header:#458588
  --layout=reverse
  --border
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function hfzf() {
  local selected_command
  selected_command=$(fc -n -rl 1 | fzf --tac --literal --reverse --border --bind 'enter:accept')
  if [[ -n "$selected_command" ]]; then
    LBUFFER="$selected_command"
  fi
}
zle -N hfzf
bindkey '^R' hfzf


