return {
    -- You can also add new plugins here as well:
    -- Add plugins, the lazy syntax
    -- "andweeb/presence.nvim",
    -- {
    --   "ray-x/lsp_signature.nvim",
    --   event = "BufRead",
    --   config = function()
    --     require("lsp_signature").setup()
    --   end,
    -- }
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
    -- catppuccin theme
    {
        "catppuccin/nvim",
        event = "BufRead",
        name = "catppuccin"
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
        enable = true
    },
    -- neovim plugin for golang
    {
        "fatih/vim-go",
        event = "BufRead",
    },
    -- Git diff view
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
        name = 'diffview',
        enable = true,
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
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
        end
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        enable = true,
        event = "BufRead",
        config = function()
            require("colorful-winsep").setup({
                highlight = {
                    fg = "#ea9a97",
                },
                -- timer refresh rate
                interval = 30,
                -- This plugin will not be activated for filetype in the following table.
                no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
                -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
                event = "BufRead",
                symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
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
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "rose-pine",
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
