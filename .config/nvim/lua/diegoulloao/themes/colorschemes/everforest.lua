-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "neanias/everforest-nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "everforest",
  config = function()
    -- custom setup
    require("everforest").setup({
      italic = {
        strings = false,
      },
      constrant = "soft",
      on_highlights = function(hl, palette)
        hl.NvimTreeFolderIcon = { fg = "#ff9cac" }
      end,
    })

    -- set colorscheme
    vim.cmd([[ colorscheme everforest ]])

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.cmd("highlight Visual guibg=#44475a guifg=NONE")
      end,
    })
  end,
}
