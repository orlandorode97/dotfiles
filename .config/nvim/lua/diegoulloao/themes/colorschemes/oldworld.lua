-- settings
local settings = require("diegoulloao.settings")

return {
  "dgox16/oldworld.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "oldworld",
  config = function()
    -- custom setup
    require("oldworld").setup({
      terminal_colors = true,
      variant = "cooler",
      styles = {
        comments = { bold = true },    -- style for comments
        keywords = { bold = true },    -- style for keywords
        identifiers = { bold = true }, -- style for identifiers
        functions = { bold = true },   -- style for functions
        variables = { bold = true },   -- style for variables
        booleans = { bold = true },    -- style for booleans
      },

      highlight_overrides = {
        NvimTreeFolderIcon = { fg = "#ff9cac" },
      },
    })

    -- set colorscheme
    vim.cmd([[ colorscheme oldworld ]])
  end,
}
