-- settings
local settings = require("diegoulloao.settings")

-- vim.g.oh_lucy_transparent_background = true

return {
  "Yazeed1s/oh-lucy.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme oh-lucy ]])
  end,
}
