-- settings
local settings = require("diegoulloao.settings")

vim.g.transparent_bg = true
return {
  "nyoom-engineering/oxocarbon.nvim",
  lazy = false,
  enabled = settings.theme == "oxocarbon",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme oxocarbon]])
    -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
  end,
}
