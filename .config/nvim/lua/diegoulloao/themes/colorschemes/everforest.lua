-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "neanias/everforest-nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "everforest",
  config = function()
    -- custom setup
    require("everforest").setup({
      italic = {
        strings = false,
      },
      contrast = "", -- options: soft|hard|empty
    })

    -- set colorscheme
    vim.cmd([[ colorscheme everforest ]])
  end,
}
