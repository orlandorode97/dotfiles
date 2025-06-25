-- settings
local settings = require("diegoulloao.settings")

return {
  "baliestri/aura-theme",
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "aura",
  config = function(plugin)
    vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    vim.cmd([[colorscheme aura-soft-dark]])
  end,
}
