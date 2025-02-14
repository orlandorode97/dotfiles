-- settings

return {
  "dgox16/oldworld.nvim",
  lazy = false,
  enabled = true,
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
}
