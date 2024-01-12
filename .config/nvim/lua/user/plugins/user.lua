return {
    -- nvim tree sitter context
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        name = "nvim-treesitter-context"
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufRead",
        name = "nvim-treesitter-context"
    },
    {
        "folke/zen-mode.nvim",
        event = "BufRead",
        name = "zen-mode",
        opts = {
            window = {
                options = {
                    signcolumn = "no",      -- disable signcolumn
                    number = false,         -- disable number column
                    relativenumber = false, -- disable relative numbers
                    cursorline = false,     -- disable cursorline
                    cursorcolumn = false,   -- disable cursor column
                    foldcolumn = "0",       -- disable fold column
                    list = false,           -- disable whitespace characters
                },
            }
        }
    },
    {
        "catppuccin/nvim",
        event = "BufRead",
        name = "catppuccin",
    },
    {
        "ixru/nvim-markdown",
        event = "BufRead",
        name = "nvim-markdown"
    },
    {
        "craftzdog/solarized-osaka.nvim",
        event = "BufRead",
        name = "solarized-osaka"
    },
    {
        "kyazdani42/nvim-palenight.lua",
        event = "BufRead",
        name = "palenight"
    },
    {

        "projekt0n/caret.nvim",
        event = "BufRead",
        name = "caret"
    },
    {

        "bluz71/vim-moonfly-colors",
        event = "BufRead",
        name = "moonfly"
    },
    {

        "lunarvim/horizon.nvim",
        event = "BufRead",
        name = "horizon"
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        event = "BufRead",
        name = 'tokyonight',
        config = function()
            require('tokyonight').setup({
                style = 'storm'
            })
        end
    },
    {
        "tjdevries/colorbuddy.nvim",
        name = "colorbuddy",
        enable = true,
        event = "BufRead",
    },
    {
        "sainnhe/edge",
        name = "edge",
        enable = true,
        event = "BufRead",
    },
    {
        'glepnir/zephyr-nvim',
        name = "zephyr",
        enable = true,
        event = "BufRead",
    },
    {
        'Alexis12119/nightly.nvim',
        name = "nightly",
        enable = true,
        event = "BufRead",
    },
    {
        'Everblush/nvim',
        name = "everblush",
        enable = true,
        event = "BufRead",
    },
    {
        "nobbmaestro/nvim-andromeda",
        name = "andromeda",
        enable = true,
        event = "BufRead",
    },
    {
        "navarasu/onedark.nvim",
        event = "BufRead",
        name = "onedark"
    },
    -- Plenary
    {
        "nvim-lua/plenary.nvim",
        event = "BufRead",
        name = 'plenary'
    },
    -- bufferline
    {
        "akinsho/bufferline.nvim",
        event = "BufRead",
        name = 'bufferline'
    },
    -- rose pine
    {
        'rose-pine/neovim',
        event = "BufRead",
        name = 'rose-pine'
    },
    -- nvim dap for debugger
    {
        "mfussenegger/nvim-dap",
        event = "BufRead",
    },
    -- nvim dap for go debugger
    {
        "leoluz/nvim-dap-go",
        event = "BufRead",
    },
    -- nvim dap ui for debugger
    {
        "rcarriga/nvim-dap-ui",
        event = "BufRead",
    },
    -- nvim dap for text in real time.
    {
        "theHamsta/nvim-dap-virtual-text",
        event = "BufRead",
    },
    -- git blame for commits.
    {
        "f-person/git-blame.nvim",
        event = "BufRead",
        name = 'git-blame',
        enable = true,
    },
    -- neovim plugin for golang
    {
        "fatih/vim-go",
        event = "BufRead",
    },
    -- dbml syntax
    {
        "jidn/vim-dbml",
        event = "BufRead",
    },
    -- Multi cursors
    {
        "mg979/vim-visual-multi",
        event = "BufRead",
        name = "vim-visual-multi",
        enable = true
    },
    -- Material theme
    {
        "marko-cerovac/material.nvim",
        event = "BufRead",
    },
    -- modes nvim for current line
    {
        "mvllow/modes.nvim",
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
        end,
        enable = true,
        event = "BufRead",
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        enable = true,
        commit = "db2923c8392bcc7476e8cb7aa312af4f624ca005",
        event = { "WinNew" },
        config = function()
            require("colorful-winsep").setup({
                highlight = {
                    fg = "#ea9a97",
                },
                -- timer refresh rate
                interval = 30,
                no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
                -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
                symbols = { "─", "│", "╭", "╮", "╰", "╯" },
                close_event = function()
                    -- Executed after closing the window separator
                end,
                create_event = function()
                    local win_n = require("colorful-winsep.utils").calculate_number_windows()
                    if win_n == 2 then
                        local win_id = vim.fn.win_getid(vim.fn.winnr('h'))
                        local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), 'filetype')
                        if filetype == "NvimTree" then
                            require('colorful-winsep').NvimSeparatorDel()
                        end
                    end
                end,
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        enable = true,
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "horizon",
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
                            --                            color = { bg = "#13141c", fg = "#ffffff" },
                        },
                        {
                            "filename",
                            --  color = { bg = "#13141c", fg = "#ffffff" },
                            separator = { left = "", right = "" },
                        },
                        {
                            "branch",
                            icon = "",
                            colored = true,
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
                            --                        color = { bg = "#212430", fg = "#c296eb" },
                            separator = { left = "", right = "" },
                        },
                    },
                    lualine_c = {
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
                                warn = {
                                    fg = 'DiagnosticWarn',
                                    bg = '#0f111a'
                                },
                                info = {
                                    fg = 'DiaganosticInfo',
                                    bg = '#0f111a'
                                },
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
        event = "BufRead",
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
}
