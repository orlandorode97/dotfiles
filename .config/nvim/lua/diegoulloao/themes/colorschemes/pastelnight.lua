-- settings
local settings = require("diegoulloao.settings")

vim.g.transparent_bg = true
return {
  "pauchiner/pastelnight.nvim",
  lazy = false,
  enabled = settings.theme == "pastelnight",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.cmd([[ colorscheme pastelnight]])
    -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
    vim.api.nvim_set_hl(0, "Visual", { bg = "#555555", fg = "NONE" }) -- Change #555555 to your preferred color
  end,
}
