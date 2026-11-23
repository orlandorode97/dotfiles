-- options.lua
local opt = vim.opt

-- =========================================================
-- Basics
-- =========================================================
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.hidden = true   -- allow switching buffers without saving
opt.autoread = true -- auto-reload file if changed on disk
opt.backspace = { "indent", "eol", "start" }
opt.mouse = "a"

-- =========================================================
-- UI / Appearance
-- =========================================================
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "both" -- highlight line + line number
opt.numberwidth = 4
opt.wrap = false
opt.signcolumn = "yes"
opt.showmode = true           -- hide/disable if using lualine
opt.fillchars = { eob = " ", vert = "│", horiz = "─" } -- remove ~ from empty lines, thin separators
opt.pumheight = 10
opt.splitkeep = "screen"      -- prevent split jumping
opt.termguicolors = true

-- =========================================================
-- Indentation & Tabs
-- =========================================================
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.showtabline = 2

-- =========================================================
-- Scrolling
-- =========================================================
opt.scrolloff = 8
opt.sidescrolloff = 8

-- =========================================================
-- Search
-- =========================================================
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = "split" -- live preview for :%s substitutions

-- =========================================================
-- Files / Backup / Undo
-- =========================================================
opt.undofile = true

-- Recommended: disable swap/backup if using Git everywhere
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- =========================================================
-- Completion
-- =========================================================
opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }

-- =========================================================
-- Performance
-- =========================================================
opt.updatetime = 200 -- faster diagnostic updates
opt.timeoutlen = 400 -- faster key mappings
opt.lazyredraw = false
opt.ttyfast = true

-- =========================================================
-- Folds
-- =========================================================
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "indent" -- switch to treesitter later if needed

-- =========================================================
-- Other quality-of-life
-- =========================================================
opt.clipboard:append("unnamedplus")
opt.iskeyword:append("-")
opt.splitright = true
opt.splitbelow = true

-- cursorline + line numbers colors (Catppuccin Mocha)
local function set_line_highlights()
  local set = vim.api.nvim_set_hl
  set(0, "CursorLine", { bg = "#262637" })
  set(0, "CursorLineNr", { fg = "#cba6f7", bg = "#262637", bold = true }) -- current number
  set(0, "LineNr", { fg = "#585b70" })
  set(0, "LineNrAbove", { fg = "#6c7086" })
  set(0, "LineNrBelow", { fg = "#6c7086" })
  set(0, "WinSeparator", { fg = "#45475a", bg = "NONE" })
  set(0, "SignColumn", { bg = "NONE" })
  set(0, "ColorColumn", { bg = "#262637" })
end
set_line_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_line_highlights })
