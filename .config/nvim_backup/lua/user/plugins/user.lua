return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- nvim tree sitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    name = "nvim-treesitter-context",
  },
  {
    "EdenEast/nightfox.nvim",
    event = "BufRead",
    name = "nightfox",
  },
  {
    "catppuccin/nvim",
    event = "BufRead",
    name = "catppuccin",
  },
  {
    "pineapplegiant/spaceduck",
    event = "BufRead",
    name = "spaceduck",
  },
  {
    "rose-pine/neovim",
    event = "BufRead",
    name = "rose-pine",
  },
  {
    "michaelrommel/nvim-silicon",
    event = "BufRead",
    name = "silicon",
    init = function()
      local wk = require "which-key"
      wk.register({
        ["<leader>sp"] = { ":Silicon<CR>", "Snaptshot code" },
      }, { mode = "v" })
    end,
    config = function()
      require("silicon").setup {
        font = "CaskaydiaCove Nerd Font Propo",
        theme = "gruvbox-dark",
        background = "#94e2d5",
        window_title = function()
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end,
      }
    end,
  },
  {
    "folke/zen-mode.nvim",
    event = "BufRead",
    name = "zen-mode",
    opts = {
      window = {
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace characters
        },
      },
    },
  },
  -- Plenary
  {
    "nvim-lua/plenary.nvim",
    event = "BufRead",
    name = "plenary",
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
    name = "git-blame",
    enable = true,
  },
  -- neovim plugin for golang
  {
    "fatih/vim-go",
    event = "BufRead",
  },
  -- Multi cursors
  {
    "mg979/vim-visual-multi",
    event = "BufRead",
    name = "vim-visual-multi",
    enable = true,
  },
  -- modes nvim for current line
  {
    "mvllow/modes.nvim",
    config = function()
      require("modes").setup {
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
        ignore_filetypes = { "NvimTree", "TelescopePrompt" },
      }
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
      require("colorful-winsep").setup {
        highlight = {
          fg = "#ea9a97",
          bg = "#000000",
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
            local win_id = vim.fn.win_getid(vim.fn.winnr "h")
            local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
            if filetype == "NvimTree" then require("colorful-winsep").NvimSeparatorDel() end
          end
        end,
      }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    enable = true,
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = "ayu_dark",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              icon = "",
              separator = { left = "", right = "" },
            },
          },
          lualine_b = {
            {
              "filetype",
              icon_only = true,
              colored = true,
            },
            {
              "filename",
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
                error = { fg = "#820e2d", bg = "#0f111a" },
                warn = {
                  fg = "DiagnosticWarn",
                  bg = "#0f111a",
                },
                info = {
                  fg = "DiaganosticInfo",
                  bg = "#0f111a",
                },
                hint = { fg = "#92CDE7", bg = "#0f111a" },
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
              function() return "" end,
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
              function() return "" end,
              separator = { left = "", right = "" },
            },
            {
              "location",
              color = "StatusLine",
            },
            {
              function() return "" end,
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
      }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    event = "BufRead",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup {}
    end,
  },
  {
    "folke/trouble.nvim",
    event = "BufRead",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
        wrap = true,
        auto_preview = false,
      }
    end,
  },
  {
    "diegoulloao/neofusion.nvim",
    event = "BufRead",
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = "BufRead",
    lazy = false,
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        on_attach = function(bufnr)
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          local ok, api = pcall(require, "nvim-tree.api")
          assert(ok, "api module is not found")
          vim.keymap.set("n", "<CR>", api.node.open.tab_drop, opts "Tab drop")
        end,
        view = {
          width = 38,
        },
        renderer = {
          root_folder_label = false, -- hide root directory at the top
          indent_markers = {
            enable = true, -- folder level guide
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            glyphs = {
              folder = {
                default = "",
                open = "",
                empty = "",
                empty_open = "",
              },
              git = {
                unstaged = "",
                staged = "",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
            window_picker = {
              enable = false,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filters = {
          dotfiles = false,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        git = {
          enable = false,
        },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- require bufferline
      local bufferline = require "bufferline"

      -- custom setup
      bufferline.setup {
        options = {
          mode = "tabs", -- only show tabs and not all buffers
          numbers = "ordinal", -- add tabs ordinal numbers
          style_preset = bufferline.style_preset.default, -- default|minimal
          tab_size = 18,
          close_icon = "",
          show_buffer_icons = true,
          show_duplicate_prefix = true, -- show base path if tabs have the same name
          separator_style = "thick", -- slant|slope|thick|thin|{"|", "|"}
          diagnostics = "nvim_lsp", -- nvim lsp diagnostics integration in tabs or false
          indicator = {
            -- icon = "", -- ▎
            style = "icon", -- icon|underline|none
          },
          offsets = {
            -- avoid to show bufferline on top nvim-tree
            {
              filetype = "NvimTree",
              text = "File Explorer", -- title on top
              highlight = "Directory",
              separator = true, -- true is the default, or set custom
            },
            -- avoid to show bufferline on top saga outline symbols
            {
              filetype = "sagaoutline",
              text = "Symbols", -- title on top
              highlight = "Directory",
              separator = true, -- true is the default, or set custom
            },
          },
          diagnostics_indicator = function(count, level) -- diagnostics format
            -- display only the number if aspect is clean

            --- @diagnostic disable-next-line: undefined-field
            local icon = level:match "error" and " " or " "
            return " " .. icon .. count
          end,
          -- exclude some buffer and file types
          custom_filter = function(buf_number)
            local buftype = vim.api.nvim_buf_get_option(buf_number, "buftype")
            local filetype = vim.api.nvim_buf_get_option(buf_number, "filetype")

            -- exclude list
            local excluded_filetypes = {
              ["terminal"] = true,
              ["TelescopePrompt"] = true,
              ["NvimTree"] = true,
              ["sagaoutline"] = true,
              ["sagafinder"] = true,
              ["starter"] = true,
            }

            local excluded_buftypes = {
              ["nofile"] = true,
              ["terminal"] = true,
            }

            return not excluded_buftypes[buftype] and not excluded_filetypes[filetype]
          end,
        },
      }
    end,
  },
}
