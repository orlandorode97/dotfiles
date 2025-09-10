-- settings
local settings = require("diegoulloao.settings")

return {
  "nyoom-engineering/oxocarbon.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  config = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#d65d0e" })
    -- set colorscheme
    vim.cmd([[ colorscheme oxocarbon ]])
  end,
}
