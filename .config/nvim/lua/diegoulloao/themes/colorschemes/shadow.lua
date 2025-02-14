return {
  "rjshkhr/shadow.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    vim.opt.termguicolors = true
    vim.cmd.colorscheme("shadow")
  end,
}
