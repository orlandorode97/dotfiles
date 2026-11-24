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
    require("ibl").setup(opts)
  end,
}
