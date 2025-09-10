-- settings
local settings = require("diegoulloao.settings")

return {
  "ellisonleao/gruvbox.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  config = function()
    -- custom setup
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      italic = {
        strings = false,
      },
      contrast = "soft", -- options: soft|hard|empty
      transparent_mode = true,
      overrides = {
        NvimTreeFolderIcon = { fg = "#d65d0e" },
      },
    })

    -- set colorscheme
    vim.cmd([[ colorscheme gruvbox ]])
  end,
}
