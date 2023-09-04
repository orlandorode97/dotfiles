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
        "kyazdani42/nvim-palenight.lua",
        event = "BufRead",
        name = "palenight"
    },
    -- {

    --     "catppuccin/nvim",
    --     event = "BufRead",
    --     name = "catppuccin"
    -- },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        event = "BufRead",
        name = 'tokyonight',
        config = function()
            require('tokyonight').setup({
                style = 'night'
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
        enable = false,
        event = "BufRead",
        config = function()
            require("colorful-winsep").setup({
                highlight = {
                    fg = "#ea9a97",
                },
                -- timer refresh rate
                interval = 30,
                -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
                symbols = { "─", "│", "╭", "╮", "╰", "╯" },
                close_event = function()
                    -- Executed after closing the window separator
                end,
                create_event = function()
                    -- Executed after creating the window separator
                end,
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufRead",
        enable = true,
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "material",
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
                            color = { bg = "#212430", fg = "#c296eb" },
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
