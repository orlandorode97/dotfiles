-- settings
local settings = require("diegoulloao.settings")

return {
  "savq/melange-nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "melange",
  config = function()
    -- set colorscheme
    vim.cmd([[ colorscheme melange ]])
  end,
}
