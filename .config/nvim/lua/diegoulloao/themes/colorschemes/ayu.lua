-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "ayu",
  config = function()
    -- require ayu
    local ayu = require("ayu")

    -- custom setup
    ayu.setup({
      mirage = false, -- set true to use 'mirage' version instead of 'dark'
    })

    -- apply colorscheme
    ayu.colorscheme()
  end,
}
