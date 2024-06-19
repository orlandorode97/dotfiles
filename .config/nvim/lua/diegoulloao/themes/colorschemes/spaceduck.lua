-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "pineapplegiant/spaceduck",
  lazy = false,
  enabled = settings.theme == "spaceduck",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme spaceduck ]])
  end,
}
