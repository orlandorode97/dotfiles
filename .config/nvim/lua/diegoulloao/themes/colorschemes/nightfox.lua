-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.g.material_style = "darker"

return {
  "EdenEast/nightfox.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    require("nightfox").setup({
      groups = {
        all = {
          NvimTreeFolderIcon = { fg = "#ff9cac" },
        },
      },
    })
    -- set colorscheme
    vim.cmd([[ colorscheme duskfox]])
  end,
}
