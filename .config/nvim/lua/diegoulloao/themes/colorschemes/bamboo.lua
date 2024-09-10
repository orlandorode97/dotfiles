-- settings
local settings = require("diegoulloao.settings")

return {
  "ribru17/bamboo.nvim",
  lazy = false,
  enabled = settings.theme == "bamboo",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("bamboo").setup({
      transparent = true,
    })
    require("bamboo").load()
  end,
}
