return {
  "nvimdev/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require("lspsaga").setup(opts)
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
