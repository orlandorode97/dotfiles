-- leader keymap
vim.g.mapleader = " " -- space key

-- for conciseness
local keymap = vim.keymap -- keymaps

-- nvim-tree keymaps
keymap.set("n", "<C-b>", "<cmd>NvimTreeToggle<CR>") -- nvim tree toggle

-- telescope keymaps
keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>") -- find file in project
keymap.set("n", "<C-f>", "<cmd>Telescope live_grep<CR>") -- find word in project
keymap.set("n", "<C-t>", "<cmd>Telescope buffers<CR>") -- buffers list

-- git signs keymaps
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>") -- git blame

-- markdown preview
keymap.set("n", "<leader><leader>m", "<cmd>MarkdownPreviewToggle<CR>") -- toggle markdown preview

-- zen mode
keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>")
