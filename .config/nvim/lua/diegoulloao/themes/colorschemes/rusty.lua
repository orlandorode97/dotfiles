local settings = require("diegoulloao.settings")

return {
  "armannikoyan/rusty",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("rusty").setup({})
    vim.cmd([[colorscheme rusty]])
  end,
}
