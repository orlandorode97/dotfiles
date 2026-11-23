-- NOTE:
-- if neovim says that fzf is not installed, then:
-- 1. open Lazy
-- 2. go to fzf native
-- 3. press gb keys to force build the plugin

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzf-native.nvim",
    -- addons
    "ahmedkhalf/project.nvim",
    "olimorris/persisted.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  cmd = "Telescope",
  config = function()
    -- require telescope
    local telescope = require("telescope")

    -- require telescope actions
    local actions = require("telescope.actions")

    -- load fzf
    telescope.load_extension("fzf")

    -- projects extension integration for telescope
    telescope.load_extension("projects")

    -- persisted extension for session management
    telescope.load_extension("persisted")

    telescope.load_extension("ui-select")

    -- colored pill-like titles (Catppuccin Mocha)
    local function set_highlights()
      local set = vim.api.nvim_set_hl
      set(0, "TelescopeNormal", { bg = "#181825" })
      set(0, "TelescopeBorder", { fg = "#45475a", bg = "#181825" })
      set(0, "TelescopePromptNormal", { bg = "#313244" })
      set(0, "TelescopePromptBorder", { fg = "#313244", bg = "#313244" })
      set(0, "TelescopePromptTitle", { fg = "#1e1e2e", bg = "#f38ba8", bold = true })
      set(0, "TelescopePromptPrefix", { fg = "#f38ba8" })
      set(0, "TelescopeResultsTitle", { fg = "#1e1e2e", bg = "#89b4fa", bold = true })
      set(0, "TelescopePreviewTitle", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
      set(0, "TelescopeSelection", { bg = "#45475a", fg = "#cdd6f4", bold = true })
      set(0, "TelescopeSelectionCaret", { fg = "#cba6f7", bg = "#45475a" })
      set(0, "TelescopeMatching", { fg = "#89b4fa", bold = true })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

    -- custom setup
    telescope.setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "flex",

        -- NvChad UI style
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = "   ",

        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            prompt_position = "top",
          },
          height = 0.85,
          width = 0.80,
        },

        -- rounded borders
        borderchars = {
          prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },

        winblend = 0, -- transparency (NvChad default = 0)

        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "dist",
          "build",
          "__pycache__",
        },
      },

      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
          layout_config = { width = 0.6 },
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
        git_branches = {
          theme = "dropdown",
          previewer = false,
        },
        git_status = {
          theme = "dropdown",
          previewer = false,
        },
        live_grep = {
          previewer = true,
        },
      },

      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            previewer = false,
            sorting_strategy = "ascending",
          }),
        },
      },
    })
  end,
} -- telescope finder
