-- settings
local settings = require("diegoulloao.settings")

return {
  "eldritch-theme/eldritch.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "eldritch",
  config = function()
    -- custom setup
    require("eldritch").setup({
      transparent = true,
    })

    -- set colorscheme
    vim.cmd([[ colorscheme eldritch]])
  end,
}
