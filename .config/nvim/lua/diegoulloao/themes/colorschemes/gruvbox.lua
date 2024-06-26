-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "ellisonleao/gruvbox.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "gruvbox",
  config = function()
    -- custom setup
    require("gruvbox").setup({
      italic = {
        strings = false,
      },
      contrast = "", -- options: soft|hard|empty
    })

    -- set colorscheme
    vim.cmd([[ colorscheme gruvbox ]])
  end,
}
