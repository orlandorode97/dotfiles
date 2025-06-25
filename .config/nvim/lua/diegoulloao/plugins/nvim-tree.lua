return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  enable = true,
  config = function()
    require("nvim-tree").setup({
      update_cwd = true,
      hijack_cursor = true,
      git = {
        ignore = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = {
            enable = false,
          },
        },
        file_popup = {
          open_win_config = {
            col = 5,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,

      view = {
        width = {
          min = 30,
          max = 600,
        },
      },
      renderer = {
        highlight_git = true,
        indent_markers = {
          enable = true,
        },

        icons = {
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "◉",
            git = {
              unstaged = "",
              staged = "",
              unmerged = "",
              renamed = "",
              deleted = "",
              untracked = "",
              ignored = "",
            },
            folder = {
              default = "",
              open = "",
              symlink = "",
            },
          },
          show = {
            git = false,
            file = true,
            folder = true,
            folder_arrow = false,
          },
        },
      },
    })

    vim.cmd("colorscheme melange")
  end,
}
