-- more mappings are defined in `lua/config/which.lua`
local map = vim.keymap.set


map("n", "<C-b>", ":NvimTreeToggle<CR>", {silent = true})
map("n", "<C-k>", ":GoDef<CR>", {silent = true})
map("n", "<C-l>", ":GoDefPop<CR>", {silent = true})
map("n", "<C-p>", ":Telescope find_files<CR>", {silent = true})