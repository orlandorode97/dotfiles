return {
  "folke/trouble.nvim",
  event = "BufRead",
  config = function()
    require("trouble").setup({
      use_diagnostic_signs = true,
      wrap = true,
      auto_preview = false,
    })
  end,
}
