-- settings
local settings = require("diegoulloao.settings")

return {
  "rose-pine/neovim",
  lazy = false,
  enabled = settings.theme == "rose-pine",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme rose-pine ]])
  end,
}
