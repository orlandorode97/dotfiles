local settings = require("diegoulloao.settings")

return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  cond = settings.theme == "catppuccin-mocha",
  config = function()
    require("catppuccin").setup({
      highlight_overrides = {
        all = function(colors)
          return {
            NvimTreeFolderIcon = { fg = "#ff9cac" },
          }
        end,
      },
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}
