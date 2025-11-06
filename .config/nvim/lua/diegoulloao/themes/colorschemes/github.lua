-- settings
local settings = require("diegoulloao.settings")

return {
  "projekt0n/github-nvim-theme",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  config = function()
    require("github-theme").setup({
      groups = {
        all = {
          NvimTreeFolderIcon = { fg = "#d65d0e" },
        },
      },
    })

    vim.cmd("colorscheme github_dark_dimmed")
  end,
}
