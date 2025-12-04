return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      hijack_cursor = true,

      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },

      actions = {
        open_file = {
          quit_on_open = false,
          window_picker = { enable = false },
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

      diagnostics = {
        enable = false,
      },

      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 5000,
      },

      view = {
        cursorline = false,
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },

      renderer = {
        highlight_git = false,
        root_folder_label = ":~:s?$?",
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          -- No necesitas definir todos los glyphs si lo delegas a mini.icons
          -- Pero si quieres, puedes poner algunos:
          glyphs = {
            git = {
              unstaged = "", -- solo un ejemplo
              staged = "✓",
              untracked = "?",
            },
          },
        },
      },
    })

    -- Tu colorscheme o lo que quieras
    vim.cmd("colorscheme kanagawa-wave")
  end,
}
