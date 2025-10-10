return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
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
    vim.cmd.colorscheme("catppuccin")
  end,
}
