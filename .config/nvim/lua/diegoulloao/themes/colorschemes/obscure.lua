-- settings
local settings = require("diegoulloao.settings")

return {
  "killitar/obscure.nvim",
  lazy = false,
  enabled = settings.theme == "obscure",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("obscure").setup({
      transparent = true,
    })
    vim.cmd([[ colorscheme obscure ]])
  end,
}
