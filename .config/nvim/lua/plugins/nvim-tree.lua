-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- custom setup
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
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
      dotfiles = true,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
  },
}
