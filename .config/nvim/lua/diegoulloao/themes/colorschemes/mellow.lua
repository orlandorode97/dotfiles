-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"
vim.g.mellow_transparent = true

return {
  "mellow-theme/mellow.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "mellow",
  config = function()
    -- set colorscheme
    vim.g.mellow_highlight_overrides = {
      ["NvimTreeFolderIcon"] = { fg = "#ff9cac" },
    }

    vim.cmd([[ colorscheme mellow ]])
  end,
}
