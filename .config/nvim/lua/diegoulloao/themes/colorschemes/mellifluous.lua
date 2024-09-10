-- settings
local settings = require("diegoulloao.settings")

return {
  "ramojus/mellifluous.nvim",
  lazy = false,
  enabled = settings.theme == "mellifluous",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("mellifluous").setup({
      transparent_background = {
        enabled = false,
      },
    })
    vim.cmd("colorscheme mellifluous")
  end,
}
