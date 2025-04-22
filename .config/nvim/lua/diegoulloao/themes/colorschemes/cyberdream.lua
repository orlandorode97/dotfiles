-- settings
local settings = require("diegoulloao.settings")

return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  enabled = settings.theme == "cyberdream",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("cyberdream").setup({
      variant = "default",
      transparent = false,
      saturation = 0.5,
      overrides = function(c)
        return {
          CursorLine = { bg = c.bg },
          CursorLineNr = { fg = c.magenta },
        }
      end,
    })
    vim.cmd("colorscheme cyberdream")
  end,
}
