# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

# ── PATH ──────────────────────────────────────────────────────────────────────
source $HOME/.cargo/env
export PATH=$PATH:/Users/orlandoromo/dev-cluster/scripts
export PATH=$PATH:/Users/orlandoromo/omg
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

source $ZSH/oh-my-zsh.sh

# ── Prompt & shell tools ──────────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/robbyrussell.omp.json)"
ulimit -n 8096

# ── Aliases ───────────────────────────────────────────────────────────────────
alias lsi="logo-ls -1"
alias cat="bat --plain"
alias gotest="go test -v -run Test"
alias prune="docker system prune --all --volumes"
alias dash="gh dash"
alias curl="curl $@" | jq

# git
alias gs="git status -s"
alias gitlog="git log --all --decorate --oneline --graph --pretty=format:'%C(auto)%h%Creset - %C(bold blue)%an%Creset, %Cgreen%ar%Creset : %s' --abbrev=7"
alias tree-add="git worktree add $@"
alias tree-remove="git worktree remove $@ --force"

# gitui
alias gitui="gitui --theme frappe.ron"
alias gitui="gitui -t theme.ron"
alias gitui="gitui -t theme.ron"

# ── FZF ───────────────────────────────────────────────────────────────────────
# Kanagawa Wave palette — matches the terminal theme
export FZF_DEFAULT_OPTS='
  --color=fg:#dcd7ba,bg:-1,hl:#c4b28a
  --color=fg+:#c8c093,bg+:#2d4f67,hl+:#e6c384
  --color=info:#7e9cd8,prompt:#98bb6c,pointer:#957fb8
  --color=marker:#7aa89f,spinner:#957fb8,header:#6a9589
  --layout=reverse
  --border
'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# history search over ^R
function hfzf() {
  local selected_command
  selected_command=$(fc -n -rl 1 | fzf --tac --literal --reverse --border --bind 'enter:accept')
  if [[ -n "$selected_command" ]]; then
    LBUFFER="$selected_command"
  fi
}
zle -N hfzf
bindkey '^R' hfzf
