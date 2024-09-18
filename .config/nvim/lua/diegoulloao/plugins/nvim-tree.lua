-- indent char from settings
local settings = require("diegoulloao.settings")

-- disable indent guides if aspect is clean
local enable = true
if settings.aspect == "clean" then
  enable = false
end

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
          col = 1,
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
  },
  view = {
    width = 32,
  },
  renderer = {
    highlight_git = true,
    root_folder_modifier = ":t",
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
      indent_markers = {
        enable = true,
      },
    },
  },
}
