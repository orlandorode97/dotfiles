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

        -- NvChad border style
        borderchars = {
          prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
          preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
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
