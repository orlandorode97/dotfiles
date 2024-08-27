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
    require("rose-pine").setup({
      variant = "moon",
      extend_background_behind_borders = true,
      styles = {
        transparency = true,
      },
    })
    vim.cmd([[ colorscheme rose-pine ]])
  end,
}
