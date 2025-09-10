-- for conciseness
local keymap = vim.keymap

-- keybindings for lsp
local attach_keymaps = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set go to keybinds
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts) -- go to definition
  -- set documentation keybind
  keymap.set("n", "<S-k>", "<cmd>Lspsaga hover_doc<CR>", opts)    -- show documentation for the cursor

  -- set code formatting by lsp
  keymap.set("n", "<leader>F", function()
    vim.lsp.buf.format({ async = true, bufnr = bufnr })
  end, opts) -- format code

  -- typescript specific keybinds
  if client.name == "ts_ls" then
    keymap.set("n", "<leader>mv", "<cmd>TypescriptRenameFile<CR>") -- rename ts symbol
  end
end

-- export the function
return attach_keymaps
