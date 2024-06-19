return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim",    enabled = vim.fn.executable "make" == 1, build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" }
  },
  cmd = "Telescope",
  opts = function()
    local actions = require "telescope.actions"
    return {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "󰜴 ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          n = { ["q"] = actions.close },
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true
        },
        find_files = {
          hidden = false
        }
      }
    }
  end,
  config = require "plugins.configs.telescope",
}
