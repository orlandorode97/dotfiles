-- settings
local settings = require("diegoulloao.settings")

return {
  "webhooked/kanso.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "kanso",
  config = function()
    -- custom setup
    require("kanso").setup({
      theme = "ink",
      overrides = function(colors)
        return {
          NvimTreeFolderIcon = { fg = "#ff9cac" },
        }
      end,
    })

    -- set colorscheme
    vim.cmd([[ colorscheme kanso ]])
  end,
}
