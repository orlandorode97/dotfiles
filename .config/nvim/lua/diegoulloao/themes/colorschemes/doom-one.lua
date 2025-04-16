-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "NTBBloodbath/doom-one.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "doom-one",
  config = function()
    -- set colorscheme
    vim.cmd([[ colorscheme doom-one ]])

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.cmd("highlight Visual guibg=#44475a guifg=NONE")
      end,
    })
  end,
}
