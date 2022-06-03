vim.o.ma = true
vim.o.mouse = a
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoread = true
vim.o.nu = true 
vim.o.foldlevelstart = 99
vim.o.scrolloff = 7
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.g.gitblame_enabled = 1
-- use y and p with the system clipboard
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "

local map = vim.keymap.set


map("n", "<C-b>", ":NvimTreeToggle<CR>", {silent = true})
map("n", "<C-k>", ":GoDef<CR>", {silent = true})
map("n", "<C-l>", ":GoDefPop<CR>", {silent = true})
map("n", "<C-p>", ":Telescope find_files<CR>", {silent = true})



local keymap = function(tbl)
	-- Some sane default options
	local opts = { noremap = true, silent = true }
	-- Dont want these named fields on the options table
	local mode = tbl['mode']
	tbl['mode'] = nil
	local bufnr = tbl['bufnr']
	tbl['bufnr'] = nil

	for k, v in pairs(tbl) do
		if tonumber(k) == nil then
			opts[k] = v
		end
	end


	if bufnr ~= nil then
		vim.api.nvim_buf_set_keymap(bufnr, mode, tbl[1], tbl[2], opts)
	else
		vim.api.nvim_set_keymap(mode, tbl[1], tbl[2], opts)
	end
end

local nmap = function(tbl)
	tbl['mode'] = 'n'
	keymap(tbl)
end

local imap = function(tbl)
	tbl['mode'] = 'i'
	keymap(tbl)
end

-- Aesthetic
-- pcall catches errors if the plugin doesn't load
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end
catppuccin.setup {}
vim.cmd[[colorscheme catppuccin]]

-- require'nvim-treesitter.configs'.setup { ensure_installed = "all", highlight = { enable = true } }

vim.g.glow_binary_path = vim.env.HOME .. "/bin"
vim.g.glow_use_pager = true
vim.g.glow_border = "shadow"
vim.keymap.set("n", "<leader>p", "<cmd>Glow<cr>")


-- Native LSP Setup
-- Global setup.
local cmp = require'cmp'
cmp.setup({
snippet = {
   expand = function(args)
     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
   end,
},
  mapping = {
    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})


nmap{"C-f", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending prompt_position=top<CR>"}
nmap{"<leader>lg", "<cmd>Telescope live_grep<CR>"}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = function(client, bufnr)

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- leaving only what I actually use...
	buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

	buf_set_keymap("n", "<C-j>", "<cmd>Telescope lsp_document_symbols<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

	buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
	vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})
	-- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	-- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	-- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	-- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	-- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	-- buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	if client.server_capabilities.document_formatting then
		vim.cmd([[
			augroup formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
				autocmd BufWritePre <buffer> lua OrganizeImports(1000)
			augroup END
		]])
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.cmd([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]])
	end
end

lsp_installer.setup{}
local lspconfig = require('lspconfig')
lspconfig.gopls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
}
lspconfig.golint.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
}

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- organize imports
-- https://github.com/neovim/nvim-lspconfig/issues/115#issuecomment-902680058
function OrganizeImports(timeoutms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeoutms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

-- lualine
require('lualine').setup{
  options = {
    theme = 'catppuccin'
  }
}

-- nvim tree 
local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup({
	auto_reload_on_write = true,
	-- disables netrw completely
	disable_netrw = false,
	-- hijack netrw window on startup
	hijack_netrw = true,
	-- open the tree when running this setup function
	open_on_setup = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup = {},
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab = false,
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = true,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd = true,
	filters = {
		-- this option hides files and folders starting with a dot `.`
		dotfiles = false,
	},
	-- show lsp diagnostics in the signcolumn
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		icons = { hint = "", info = "", warning = "", error = "" },
	},
	git = { enable = true, ignore = true, timeout = 400 },
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = true,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = { ".git", "node_modules", ".cache" },
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = nil,
		-- the command arguments as a list
		args = {},
	},

	trash = { cmd = "trash-put", require_confirm = true },

	actions = {
		change_dir = { enable = true, global = false },
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = {
						"notify",
						"packer",
						"qf",
						"diff",
						"fugitive",
						"fugitiveblame",
					},
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
	},
	view = {
		-- show line numbers in tree disabled
		number = false,
		relativenumber = false,
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = "left",
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = true,
			-- list of mappings to set on the tree manually
			list = {
				{ key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb("edit") },
				{ key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
				{ key = "<C-v>", cb = tree_cb("vsplit") },
				{ key = "<C-x>", cb = tree_cb("split") },
				{ key = "<C-t>", cb = tree_cb("tabnew") },
				{ key = "<", cb = tree_cb("prev_sibling") },
				{ key = ">", cb = tree_cb("next_sibling") },
				{ key = "P", cb = tree_cb("parent_node") },
				{ key = "<BS>", cb = tree_cb("close_node") },
				{ key = "<S-CR>", cb = tree_cb("close_node") },
				{ key = "<Tab>", cb = tree_cb("preview") },
				{ key = "K", cb = tree_cb("first_sibling") },
				{ key = "J", cb = tree_cb("last_sibling") },
				{ key = "I", cb = tree_cb("toggle_ignored") },
				{ key = "H", cb = tree_cb("toggle_dotfiles") },
				{ key = "R", cb = tree_cb("refresh") },
				{ key = "a", cb = tree_cb("create") },
				{ key = "d", cb = tree_cb("remove") },
				{ key = "r", cb = tree_cb("rename") },
				{ key = "<C-r>", cb = tree_cb("full_rename") },
				{ key = "x", cb = tree_cb("cut") },
				{ key = "c", cb = tree_cb("copy") },
				{ key = "p", cb = tree_cb("paste") },
				{ key = "y", cb = tree_cb("copy_name") },
				{ key = "Y", cb = tree_cb("copy_path") },
				{ key = "gy", cb = tree_cb("copy_absolute_path") },
				{ key = "[c", cb = tree_cb("prev_git_item") },
				{ key = "]c", cb = tree_cb("next_git_item") },
				{ key = "-", cb = tree_cb("dir_up") },
				{ key = "s", cb = tree_cb("system_open") },
				{ key = "q", cb = tree_cb("close") },
				{ key = "g?", cb = tree_cb("toggle_help") },
			},
		},
	},
})


-- Telescope Setup
local action_state = require('telescope.actions.state') -- runtime (Plugin) exists somewhere as lua/telescope/actions/state.lua
require('telescope').setup{
  defaults = {
      prompt_prefix = "$ ",
      mappings = {
          i = {
            ["<c-a>"] = function() print(vim.inspect(action_state.get_selected_entry())) end 
          }        
      }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('file_browser')

local mappings = {
}
mappings.curr_buf = function() 
  local opt = require('telescope.themes').get_dropdown({height=10, previewer=false})
  require('telescope.builtin').current_buffer_fuzzy_find(opt)
end
return mappings