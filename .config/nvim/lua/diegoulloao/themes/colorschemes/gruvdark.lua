return {
  "darianmorat/gruvdark.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    require("gruvdark").setup({
      highlights = {
        NvimTreeFolderIcon = { fg = "#ff9cac" },
      },
    })
    -- set colorscheme
    vim.cmd([[ colorscheme gruvdark]])
  end,
}
