-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local keymap = vim.keymap -- keymaps

-- nvim-tree keymaps
keymap.set("n", "<C-b>", "<cmd> NvimTreeToggle <CR> <cmd> NvimTreeResize 32<CR>") -- nvim tree toggle

-- telescope keymaps
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>") -- find file in project
keymap.set(
  "n",
  "<C-f>",
  "<cmd>lua require('telescope.builtin').live_grep{ vimgrep_arguments = { 'rg', '--hidden', '--glob', '!.git/*', '--with-filename', '--line-number', '--column', '--no-heading', '--fixed-strings', '--ignore-case' }}<CR>"
) -- find word in project
keymap.set("n", "<C-t>", "<cmd>Telescope buffers<CR>") -- buffers list

-- git signs keymaps
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>") -- git blame

-- markdown preview
keymap.set("n", "<leader><leader>m", "<cmd>MarkdownPreviewToggle<CR>") -- toggle markdown preview

-- zen mode
keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")

-- toggle trouble window
keymap.set("n", "<leader>tb", "<cmd> Trouble diagnostics toggle <CR>") -- toggle trouble diagnostics

keymap.set("n", "<leader>e", "<cmd> NvimTreeResize 65 <CR>")
