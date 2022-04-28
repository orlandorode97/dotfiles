"==================
" KEYBINDING
"==================
let mapleader=','

"" NerdTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-k> :GoDef<CR>
nnoremap <C-l> :GoDefPop<CR>
nnoremap <C-p> :Telescope find_files<CR>
