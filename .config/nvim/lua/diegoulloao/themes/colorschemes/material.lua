-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "marko-cerovac/material.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "material",
  config = function()
    -- set colorscheme
    vim.cmd([[ colorscheme material ]])
  end,
}
