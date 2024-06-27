-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.g.tundra_biome = "jungle" -- 'arctic' or 'jungle'

return {
  "sam4llis/nvim-tundra",
  lazy = false,
  enabled = settings.theme == "tundra",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme tundra ]])
  end,
}
