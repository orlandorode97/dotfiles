return {
  "nvimdev/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
    local function set_highlights()
      local set = vim.api.nvim_set_hl
      set(0, "SagaNormal", { bg = "#181825" })
      set(0, "SagaBorder", { fg = "#cba6f7", bg = "#181825" })
      set(0, "SagaTitle", { fg = "#1e1e2e", bg = "#cba6f7", bold = true })
      set(0, "SagaButton", { fg = "#89b4fa", bg = "#313244" })
      set(0, "SagaSelect", { fg = "#f5c2e7", bold = true })
      set(0, "SagaCount", { fg = "#1e1e2e", bg = "#a6e3a1" })
      -- winbar breadcrumbs
      set(0, "WinBar", { bg = "NONE" })
      set(0, "WinBarNC", { bg = "NONE" })
      set(0, "SagaSep", { fg = "#585b70", bg = "NONE" })
      set(0, "SagaFolder", { fg = "#6c7086", bg = "NONE" })
      set(0, "SagaFileName", { fg = "#f9e2af", bg = "NONE", bold = true })
      set(0, "SagaFileIcon", { fg = "#f9e2af", bg = "NONE" })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
  end,
  opts = {
    scroll_preview = {
      scroll_down = "<C-h>",
      scroll_up = "<C-l>",
    },
    finder = {
      keys = {
        edit = "<CR>",
      },
    },
    diagnostic = {
      auto_preview = false,
    },
    definition = {
      keys = {
        edit = "<CR>",
      },
    },
    symbol_in_winbar = {
      enable = true,
      separator = "  ",
      show_file = true,
      folder_level = 1, -- 0: display folder | 1: only file
      color_mode = true, -- color the symbol names like their kind
      hide_keyword = true,
      delay = 150,
    },
    lightbulb = {
      enable = false, -- enable by default
      sign = false, -- display sign at the column when code actions are available
    },
    ui = {
      theme = "round",
      border = "rounded",
      winblend = 0,
      title = true,
      expand = "",
      collapse = "",
      code_action = "󰌵",
      lines = { "└", "├", "│", "─", "┌" },
      button = { "", "" },
    },
    outline = {
      win_width = 35,
    },
  },
}
