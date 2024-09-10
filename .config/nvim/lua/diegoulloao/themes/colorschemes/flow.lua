-- settings
local settings = require("diegoulloao.settings")

return {
  "0xstepit/flow.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "flow",
  config = function()
    -- custom setup
    require("flow").setup({
      transparent = true,
      fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
      mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
      aggressive_spell = false, -- Display colors for spell check.
    })

    -- set colorscheme
    vim.cmd([[ colorscheme flow ]])
  end,
}
