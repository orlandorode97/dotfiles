-- settings
local settings = require("diegoulloao.settings")

-- set dark background

return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  enabled = settings.theme == "cyberdream",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme cyberdream ]])
  end,
}
