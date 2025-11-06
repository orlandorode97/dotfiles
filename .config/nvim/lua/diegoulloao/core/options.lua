-- for conciseness
local opt = vim.opt -- vim options

-- hide -- INSERT on lualine
opt.showmode = true

-- line numbers
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.cursorline = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.showtabline = 2

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.swapfile = true

-- appearance
opt.signcolumn = "yes"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split window
opt.splitright = true
opt.splitbelow = true

-- dash as part of the word
opt.iskeyword:append("-")

-- autoread files when it changes
opt.autoread = true

-- completion window
opt.pumheight = 10

-- hide empty lines symbol ~
opt.fillchars = { eob = " " }

-- support fold
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

vim.cmd("set foldmethod=indent")
vim.cmd("set mouse=a")
