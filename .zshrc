# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

source $HOME/.cargo/env
export PATH=$PATH:/Users/orlandoromo/dev-cluster/scripts
export PATH=$PATH:/Users/orlandoromo/omg
export PATH=$PATH:/usr/local/go/bin 
export PATH=$PATH:$GOPATH/bin

alias staging-db='cloud_sql_proxy omg-staging-env:us-central1:staging --address 0.0.0.0 --port 3308'
alias staging-db2='cloud_sql_proxy omg-staging-env:us-central1:staging-db-2-mysql8 --address 0.0.0.0 --port 3309'
alias staging-db3='cloud_sql_proxy omg-staging-env:us-central1:staging-db-2-mysql8 --address 0.0.0.0 --port 3309'
alias prod-db-writer='cloud_sql_proxy ordermygear-1125:us-central1:prod-db-1-writer --address 0.0.0.0 --port 3308'
alias prod-db-reader='cloud_sql_proxy ordermygear-1125:us-central1:prod-db-1b-reader --address 0.0.0.0 --port 3307'
alias prod-db-reader-1='cloud_sql_proxy ordermygear-1125:us-central1:prod-db-1-reader --address 0.0.0.0 --port 3313'
alias prod-db2='cloud_sql_proxy ordermygear-1125:us-central1:prod-db-2 --address 0.0.0.0 --port 3309'
alias prod-db3='cloud_sql_proxy ordermygear-1125:us-central1:prod-db-3-mysql8 --address 0.0.0.0 --port 3311'

# export GH_TOKEN="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"
export OMG_DEV_MODULES="catalog payment extra integration reporting"
export PATH="/opt/homebrew/bin/xlsx2csv:$PATH"



# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval "$(starship init zsh)"
ulimit -n 8096

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
alias lsi="logo-ls -1"
alias gotest="go test -v -run Test"
alias gs="git status -s"
alias prune="docker system prune --all --volumes"
alias dash="gh dash"
alias gitui="gitui --theme frappe.ron"
alias tree-add="git worktree add $@"
alias tree-remove="git worktree remove $@ --force"
alias gitlog="git log --all --decorate --oneline --graph --pretty=format:'%C(auto)%h%Creset - %C(bold blue)%an%Creset, %Cgreen%ar%Creset : %s' --abbrev=7"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
alias gitui="gitui -t theme.ron"
alias hfzf="history | fzf --tac --literal"

export PATH=/usr/local/opt/python/libexec/bin:/opt/homebrew/opt/mysql-client/bin:/Users/orlandoromo/.nvm/versions/node/v18.18.1/bin:/Users/orlandoromo/google-cloud-sdk/bin:/opt/homebrew/bin/xlsx2csv:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/laps:/Users/orlandoromo/.cargo/bin:/Users/orlandoromo/dev-cluster/scripts:/Users/orlandoromo/omg:/Users/orlandoromo/go/bin:/Users/orlandoromo/go/bin
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/orlandoromo/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/orlandoromo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/orlandoromo/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/orlandoromo/google-cloud-sdk/completion.zsh.inc'; fi
alias curl="curl $@" | jq
eval "$(zoxide init zsh)"
alias gitui="gitui -t tokyonight_storm.ron"

export PATH=$PATH:/usr/local/go/bin

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/bubbles.omp.json)"
