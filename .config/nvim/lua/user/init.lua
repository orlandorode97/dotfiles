--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
-- Set foldmethod
local config = {
    -- Configure AstroNvim updates
    updater = {
        remote = "origin", -- remote to use
        channel = "nightly", -- "stable" or "nightly"
        version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
        branch = "main", -- branch name (NIGHTLY ONLY)
        commit = nil, -- commit hash (NIGHTLY ONLY)
        pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
        skip_prompts = false, -- skip prompts about breaking changes
        show_changelog = true, -- show the changelog after performing an update
        auto_reload = false, -- automatically reload and sync packer after a successful update
        auto_quit = false, -- automatically quit the current session after a successful update
        -- remotes = { -- easily add new remotes to track
        --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
        --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
        --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
        -- },
    },
    -- Set colorscheme to use
    colorscheme = "rose-pine",
    -- Add highlight groups in any theme
    highlights = {
        init = function()
            -- get highlights from highlight groups
            local normal = astronvim.get_hlgroup "Normal"
            local fg, bg = normal.fg, normal.bg
            local bg_alt = astronvim.get_hlgroup("Visual").bg
            local green = astronvim.get_hlgroup("String").fg
            local red = astronvim.get_hlgroup("Error").fg
            -- return a table of highlights for telescope based on colors gotten from highlight groups
            return {
                TelescopeBorder = { fg = bg_alt, bg = bg },
                TelescopeNormal = { bg = bg },
                TelescopePreviewBorder = { fg = bg, bg = bg },
                TelescopePreviewNormal = { bg = bg },
                TelescopePreviewTitle = { fg = bg, bg = green },
                TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
                TelescopePromptNormal = { fg = fg, bg = bg_alt },
                TelescopePromptPrefix = { fg = red, bg = bg_alt },
                TelescopePromptTitle = { fg = bg, bg = red },
                TelescopeResultsBorder = { fg = bg, bg = bg },
                TelescopeResultsNormal = { bg = bg },
                TelescopeResultsTitle = { fg = bg, bg = bg },
            }
        end,
        -- duskfox = { -- a table of overrides/changes to the default
        --   Normal = { bg = "#000000" },
        -- },
        default_theme = function(highlights) -- or a function that returns a new table of colors to set
            local C = require "default_theme.colors"

            highlights.Normal = { fg = C.fg, bg = C.bg }
            return highlights
        end,
    },
    -- set vim options here (vim.<first_key>.<second_key> = value)
    options = {
        opt = {
            -- set to true or false etc.
            relativenumber = true, -- sets vim.opt.relativenumber
            number = true, -- sets vim.opt.number
            spell = false, -- sets vim.opt.spell
            signcolumn = "auto", -- sets vim.opt.signcolumn to auto
            wrap = false, -- sets vim.opt.wrap
        },
        g = {
            mapleader = " ", -- sets vim.g.mapleader
            autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
            cmp_enabled = true, -- enable completion at start
            autopairs_enabled = true, -- enable autopairs at start
            diagnostics_enabled = true, -- enable diagnostics at start
            status_diagnostics_enabled = true, -- enable diagnostics in statusline
            icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
            ui_notifications_enabled = true, -- disable notifications when toggling UI elements
        },
    },
    -- If you need more control, you can use the function()...end notation
    -- options = function(local_vim)
    --   local_vim.opt.relativenumber = true
    --   local_vim.g.mapleader = " "
    --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
    --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
    --
    --   return local_vim
    -- end,

    -- Set dashboard header
    header = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
    },
    -- Default theme configuration
    default_theme = {
        colors = function(C)
            C.telescope_green = C.green
            C.telescope_red = C.red
            C.telescope_fg = C.fg
            C.telescope_bg = C.black_1
            C.telescope_bg_alt = C.bg_1
            return C
        end,
        highlights = function(hl)
            local C = require "default_theme.colors"
            hl.TelescopeBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg }
            hl.TelescopeNormal = { bg = C.telescope_bg }
            hl.TelescopePreviewBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
            hl.TelescopePreviewNormal = { bg = C.telescope_bg }
            hl.TelescopePreviewTitle = { fg = C.telescope_bg, bg = C.telescope_green }
            hl.TelescopePromptBorder = { fg = C.telescope_bg_alt, bg = C.telescope_bg_alt }
            hl.TelescopePromptNormal = { fg = C.telescope_fg, bg = C.telescope_bg_alt }
            hl.TelescopePromptPrefix = { fg = C.telescope_red, bg = C.telescope_bg_alt }
            hl.TelescopePromptTitle = { fg = C.telescope_bg, bg = C.telescope_red }
            hl.TelescopeResultsBorder = { fg = C.telescope_bg, bg = C.telescope_bg }
            hl.TelescopeResultsNormal = { bg = C.telescope_bg }
            hl.TelescopeResultsTitle = { fg = C.telescope_bg, bg = C.telescope_bg }
            return hl
        end,
        -- enable or disable highlighting for extra plugins
        plugins = {
            aerial = true,
            beacon = false,
            bufferline = true,
            cmp = true,
            dashboard = true,
            highlighturl = true,
            hop = false,
            indent_blankline = true,
            lightspeed = false,
            ["neo-tree"] = true,
            notify = true,
            ["nvim-tree"] = false,
            ["nvim-web-devicons"] = true,
            rainbow = true,
            symbols_outline = false,
            telescope = true,
            treesitter = true,
            vimwiki = false,
            ["which-key"] = true,
        },
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
        virtual_text = true,
        underline = true,
    },
    -- Extend LSP configuration
    lsp = {
        -- enable servers that you already have installed without mason
        servers = {
            "gopls",
            "dockerls",
            "rust_analyzer",
            "bashls",
            "taplo",
            "bufls",
            "yamlls",
            "jsonls"
        },
        formatting = {
            -- control auto formatting on save
            format_on_save = {
                enabled = true, -- enable or disable format on save globally
                allow_filetypes = { -- enable format on save for specified filetypes only
                    -- "go",
                },
                ignore_filetypes = { -- disable format on save for specified filetypes
                    -- "python",
                },
            },
            disabled = { -- disable formatting capabilities for the listed language servers
                -- "sumneko_lua",
            },
            timeout_ms = 1000, -- default format timeout
            -- filter = function(client) -- fully override the default formatting function
            --   return true
            -- end
        },
        -- easily add or disable built in mappings added during LSP attaching
        mappings = {
            n = {
                -- ["<leader>lf"] = false -- disable formatting keymap
                ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
                ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
            },
        },
        -- add to the global LSP on_attach function
        -- on_attach = function(client, bufnr)
        -- end,

        -- override the mason server-registration function
        -- server_registration = function(server, opts)
        --   require("lspconfig")[server].setup(opts)
        -- end,

        -- Add overrides for LSP server settings, the keys are the name of the server
        ["server-settings"] = {
            -- grammarly = {
            --         cmd = {"grammarly-languageserver", "--stdio"},
            --         filetypes = {"markdown", "go"}
            -- }
            -- example for addings schemas to yamlls
            -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
            --   settings = {
            --     yaml = {
            --       schemas = {
            --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            --       },
            --     },
            --   },
            -- },
        },
    },
    -- Mapping data with "desc" stored directly by vim.keymap.set().
    --
    -- Please use this mappings table to set keyboard mapping since this is the
    -- lower level configuration and more robust one. (which-key will
    -- automatically pick-up stored data by this setting.)
    mappings = {
        -- first key is the mode
        n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
            ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
            ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
            -- quick save
            -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        },
        t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
        },
    },
    -- Configure plugins
    plugins = {
        init = {
            -- catppuccin theme
            { "catppuccin/nvim",                as = "catppuccin" },
            -- nvim dap for debugger
            { "mfussenegger/nvim-dap" },
            -- nvim dap for go debugger
            { "leoluz/nvim-dap-go" },
            -- nvim dap ui for debugger
            { "rcarriga/nvim-dap-ui" },
            -- nvim dap for text in real time.
            { "theHamsta/nvim-dap-virtual-text" },
            -- git blame for commits.
            { "f-person/git-blame.nvim" },
            -- neovim plugin for golang
            { "fatih/vim-go" },
            -- Git diff view
            { "sindrets/diffview.nvim" },
            -- dbml syntax
            { "jidn/vim-dbml" },
            -- Multi cursors
            { "mg979/vim-visual-multi" },
            -- Material theme
            { "marko-cerovac/material.nvim" },
            -- rose pine theme
            { "rose-pine/neovim" },
            -- modes nvim for current line
            { "mvllow/modes.nvim",
                config = function()
                    require('modes').setup({
                        colors = {
                            copy = "#f5c359",
                            delete = "#c75c6a",
                            insert = "#1e1e2e",
                            visual = "#9745be",
                        },
                        -- Set opacity for cursorline and number background
                        line_opacity = 0.3,
                        -- Enable cursor highlights
                        set_cursor = false,
                        -- Enable cursorline initially, and disable cursorline for inactive windows
                        -- or ignored filetypes
                        set_cursorline = true,
                        -- Enable line number highlights to match cursorline
                        set_number = true,
                        -- Disable modes highlights in specified filetypes
                        -- Please PR commonly ignored filetypes
                        ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
                    })
                end },
            { "nvim-zh/colorful-winsep.nvim",
                config = function()
                    require("colorful-winsep").setup({
                        -- timer refresh rate
                        interval = 30,
                        -- This plugin will not be activated for filetype in the following table.
                        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
                        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
                        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
                        close_event = function()
                            -- Executed after closing the window separator
                        end,
                        create_event = function()
                            -- Executed after creating the window separator
                        end,
                    })
                end },
            {
                "nvim-lualine/lualine.nvim",
                config = function()
                    require("lualine").setup({
                        options = {
                            icons_enabled = true,
                            theme = "catppuccin",
                            component_separators = '|',
                            section_separators = { left = '', right = '' },
                            disabled_filetypes = {},
                            always_divide_middle = true,
                            globalstatus = true,
                        },
                        sections = {
                            lualine_a = {
                                {
                                    function()
                                        return ""
                                    end,
                                    separator = { left = "", right = "" },
                                },
                            },
                            lualine_b = {
                                {
                                    "filetype",
                                    icon_only = true,
                                    colored = true,
                                    color = { bg = "#13141c", fg = "#ffffff" },
                                },
                                {
                                    "filename",
                                    color = { bg = "#13141c", fg = "#ffffff" },
                                    separator = { left = "", right = "" },
                                },
                                {
                                    "branch",
                                    icon = "",
                                    color = { bg = "#212430", fg = "#c296eb" },
                                    separator = { left = "", right = "" },
                                },
                                {
                                    "diff",
                                    colored = true,
                                    symbols = {
                                        added = " ",
                                        modified = " ",
                                        removed = " ",
                                    },
                                    color = { bg = "#212430" },
                                    separator = { left = "", right = "" },
                                },
                            },
                            lualine_c = {
                                {
                                    function()
                                        return ''
                                    end,
                                    color = { bg = '#8FCDA9', fg = '#121319' },
                                    separator = { left = '', right = '' },
                                },
                                {
                                    "diagnostics",
                                    sources = { "nvim_lsp" },
                                    sections = {
                                        "info",
                                        "error",
                                        "warn",
                                        "hint",
                                    },
                                    diagnostic_color = {
                                        error = { fg = '#820e2d', bg = '#0f111a' },
                                        warn = { fg = 'DiagnosticWarn',
                                            bg = '#0f111a' },
                                        info = { fg = 'DiaganosticInfo',
                                            bg = '#0f111a' },
                                        hint = { fg = '#92CDE7', bg = '#0f111a' },
                                    },
                                    colored = true,
                                    update_in_insert = true,
                                    always_visible = false,
                                    symbols = {
                                        error = " ",
                                        warn = " ",
                                        hint = " ",
                                        info = " ",
                                    },
                                    separator = { left = "", right = "" },
                                },
                            },
                            lualine_x = {},
                            lualine_y = {},
                            lualine_z = {
                                {
                                    function()
                                        return ""
                                    end,
                                    separator = { left = "", right = "" },
                                },
                                {
                                    "searchcount",
                                    color = "StatusLine",
                                },
                                {
                                    "progress",
                                    color = "StatusLine",
                                },
                                {
                                    function()
                                        return ""
                                    end,
                                    separator = { left = "", right = "" },
                                },
                                {
                                    "location",
                                    color = "StatusLine",
                                },
                                {
                                    function()
                                        return ""
                                    end,
                                    separator = { left = "", right = "" },
                                },
                            },
                        },
                        inactive_sections = {
                            lualine_a = {},
                            lualine_b = {},
                            lualine_c = {},
                            lualine_x = {},
                            lualine_y = {},
                            lualine_z = {},
                        },
                        tabline = {},
                        extensions = {},
                    })
                end,
            },
            {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {
                        use_diagnostic_signs = true,
                        wrap = true,
                        -- your configuration comes here
                        -- or leave it empty to use the default settings
                        -- refer to the configuration section below
                    }
                end
            }
            -- You can disable default plugins as follows:
            -- ["goolord/alpha-nvim"] = { disable = true },

            -- You can also add new plugins here as well:
            -- Add plugins, the packer syntax without the "use"
            -- { "andweeb/presence.nvim" },
            -- {
            --   "ray-x/lsp_signature.nvim",
            --   event = "BufRead",
            --   config = function()
            --     require("lsp_signature").setup()
            --   end,
            -- },

            -- We also support a key value style plugin definition similar to NvChad:
            -- ["ray-x/lsp_signature.nvim"] = {
            --   event = "BufRead",
            --   config = function()
            --     require("lsp_signature").setup()
            --   end,
            -- },
        },
        -- All other entries override the require("<key>").setup({...}) call for default plugins
        ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
            -- config variable is the default configuration table for the setup function call
            -- local null_ls = require "null-ls"

            -- Check supported formatters and linters
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            config.sources = {
                -- Set a formatter
                -- null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.formatting.prettier,
            }
            return config -- return final config table
        end,
        treesitter = { -- overrides `require("treesitter").setup(...)`
            ensure_installed = {
                "bash",
                "cmake",
                "dockerfile",
                "dot",
                "go",
                "gomod",
                "help",
                "json",
                "lua",
                "make",
                "markdown",
                "proto",
                "rust",
                "toml",
                "vim",
                "yaml",
                "yang"
            },
        },
        -- use mason-lspconfig to configure LSP installations
        ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
            -- ensure_installed = { "sumneko_lua" },
        },
        -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
        ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
            -- ensure_installed = { "prettier", "stylua" },
        },
    },
    -- LuaSnip Options
    luasnip = {
        -- Extend filetypes
        filetype_extend = {
            -- javascript = { "javascriptreact" },
        },
        -- Configure luasnip loaders (vscode, lua, and/or snipmate)
        vscode = {
            -- Add paths for including more VS Code style snippets in luasnip
            paths = {},
        },
    },
    -- CMP Source Priorities
    -- modify here the priorities of default cmp sources
    -- higher value == higher priority
    -- The value can also be set to a boolean for disabling default sources:
    -- false == disabled
    -- true == 1000
    cmp = {
        source_priority = {
            nvim_lsp = 1000,
            luasnip = 750,
            buffer = 500,
            path = 250,
        },
    },
    -- Modify which-key registration (Use this with mappings table in the above.)
    ["which-key"] = {
        -- Add bindings which show up as group name
        register = {
            -- first key is the mode, n == normal mode
            n = {
                -- second key is the prefix, <leader> prefixes
                ["<leader>"] = {
                    -- third key is the key to bring up next level and its displayed
                    -- group name in which-key top level menu
                    ["b"] = { name = "Buffer" },
                },
            },
        },
    },
    -- This function is run last and is a good place to configuring
    -- augroups/autocommands and custom filetypes also this just pure lua so
    -- anything that doesn't fit in the normal config locations above can go here
    polish = function()
        -- Set up custom filetypes
        -- vim.filetype.add {
        --   extension = {
        --     foo = "fooscript",
        --   },
        --   filename = {
        --     ["Foofile"] = "fooscript",
        --   },
        --   pattern = {
        --     ["~/%.config/foo/.*"] = "fooscript",
        --   },
        -- }
    end,
}

return config
