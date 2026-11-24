return {
  "folke/trouble.nvim",
  event = "BufRead",
  config = function()
    require("trouble").setup({
      use_diagnostic_signs = true,
      wrap = true,
      auto_preview = false,
      focus = true,
      icons = {
        indent = {
          top = "│ ",
          middle = "├╴",
          last = "╰╴",
          fold_open = " ",
          fold_closed = " ",
          ws = "  ",
        },
      },
    })

  end,
}
