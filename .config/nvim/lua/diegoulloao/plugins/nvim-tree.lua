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
        enable = true,
        show_on_dirs = true,
        icons = { hint = "󰌵", info = "", warning = "", error = "" },
      },

      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 5000,
      },

      view = {
        cursorline = true,
        width = 34,
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
        highlight_git = "name",
        highlight_opened_files = "icon",
        root_folder_label = function(path)
          return "  " .. vim.fn.fnamemodify(path, ":t")
        end,
        indent_markers = { enable = true, icons = { corner = "╰", edge = "│", item = "│", none = " " } },
        special_files = { "README.md", "Makefile", "go.mod", "package.json", "Cargo.toml" },
        icons = {
          show = { file = true, folder = true, folder_arrow = true, git = true, diagnostics = true },
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
            },
            git = {
              unstaged = "󰄱",
              staged = "󰱒",
              unmerged = "",
              renamed = "➜",
              untracked = "󰐕",
              deleted = "󰍴",
              ignored = "◌",
            },
          },
        },
      },
    })

    -- Catppuccin Mocha colors
    local function set_highlights()
      local set = vim.api.nvim_set_hl
      set(0, "NvimTreeNormal", { bg = "#181825" })
      set(0, "NvimTreeEndOfBuffer", { bg = "#181825", fg = "#181825" })
      set(0, "NvimTreeWinSeparator", { fg = "#181825", bg = "#181825" })
      set(0, "NvimTreeCursorLine", { bg = "#313244", bold = true })
      set(0, "NvimTreeRootFolder", { fg = "#cba6f7", bold = true })
      set(0, "NvimTreeFolderName", { fg = "#89b4fa" })
      set(0, "NvimTreeOpenedFolderName", { fg = "#89b4fa", bold = true })
      set(0, "NvimTreeFolderIcon", { fg = "#f9e2af" })
      set(0, "NvimTreeIndentMarker", { fg = "#45475a" })
      set(0, "NvimTreeSpecialFile", { fg = "#f5c2e7", bold = true, underline = true })
      set(0, "NvimTreeGitDirty", { fg = "#f9e2af" })
      set(0, "NvimTreeGitNew", { fg = "#a6e3a1" })
      set(0, "NvimTreeGitDeleted", { fg = "#f38ba8" })
      set(0, "NvimTreeGitIgnored", { fg = "#6c7086" })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

  end,
}
