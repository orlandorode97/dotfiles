filetype on
filetype plugin indent on

au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
au BufRead /tmp/mutt-* set tw=72
autocmd FileType go hi FgCocErrorFloatBgCocFloating ctermfg=Black ctermbg=White guifg=White guibg=Black
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


syntax enable
set autoindent
set termguicolors
set backspace=indent,eol,start
set backup
set backupdir=~/.local/share/nvim/backup
set binary
set bomb
set ttyfast
set clipboard+=unnamedplus
set completeopt=menuone,noselect
set conceallevel=0
set cursorline
set directory=~/.local/share/nvim/swap
set encoding=UTF-8
set foldlevel=0
set foldmethod=manual
set formatoptions+=l
set gdefault
set guioptions-=e
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set linebreak
set linespace=0
set list
set listchars=tab:  
set mouse=a
set nocompatible
set noerrorbells
set nostartofline
set novisualbell
set relativenumber
set number
set regexpengine=1
set report=0
set ruler
set scrolloff=5
set shortmess=atToOc
set showcmd
set showmatch
set showmode
set showtabline=2
set sidescrolloff=10
set smartcase
set splitbelow
set splitright
set t_Co=256
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set ttimeoutlen=50
set undodir=~/.local/share/nvim/undo
set undofile
set updatetime=300
set wildmenu
set wildmode=full
set wrap
set writebackup
set autoindent
set expandtab
set shiftround
set colorcolumn=100 
set fileformat=unix
set pyxversion=3
set shiftwidth=3
set softtabstop=3
set tabstop=3
set autoread
set modifiable
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c

let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'
let g:node_host_prog = '$HOME/.local/share/node/bin/neovim-node-host'
set colorcolumn=0
colorscheme tokyonight
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
set ruler
set timeoutlen=1000 ttimeoutlen=0
command PrettierJson %python -m json.tool
