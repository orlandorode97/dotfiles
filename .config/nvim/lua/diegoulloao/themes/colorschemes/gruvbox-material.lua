-- settings
local settings = require("diegoulloao.settings")

return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    -- set colorscheme
    vim.g.gruvbox_material_enable_italic = true
    vim.gruvbox_material_background = "soft"
    vim.cmd.colorscheme("gruvbox-material")
  end,
}
