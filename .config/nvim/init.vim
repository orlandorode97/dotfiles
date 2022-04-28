" LOAD PLUGIN FIRST
source $HOME/.config/nvim/vim-plug.vim

" LOAD NVIM SETTING
source $HOME/.config/nvim/settings/set.vim
source $HOME/.config/nvim/settings/vim-go.vim
source $HOME/.config/nvim/settings/keybind.vim

" LOAD PLUGIN SETTING
source $HOME/.config/nvim/plugins/indentLine.vim
source $HOME/.config/nvim/plugins/vim-gitgutter.vim
source $HOME/.config/nvim/plugins/barbar.vim

let g:python3_host_prog       = '/usr/bin/python3'

set number
set encoding=UTF-8
