return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = { char = "▏", tab_char = "▏" },
    scope = { char = "▎", show_start = false, show_end = false },
    exclude = { filetypes = { "dashboard", "NvimTree", "lazy", "mason", "help", "alpha" } },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#313244" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#cba6f7" })
    require("ibl").setup(opts)
  end,
}
