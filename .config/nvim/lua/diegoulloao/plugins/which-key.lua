return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix", -- classic | modern | helix
    delay = 300,
    win = {
      border = "rounded",
      padding = { 1, 2 },
      title = true,
      title_pos = "center",
    },
    icons = {
      breadcrumb = "",
      separator = "",
      group = " ",
      mappings = true,
    },
    spec = {
      { "<leader>g", group = "git" },
      { "<leader>t", group = "trouble" },
    },
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
