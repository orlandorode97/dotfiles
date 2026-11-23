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
    local function set_highlights()
      local set = vim.api.nvim_set_hl
      set(0, "WhichKey", { fg = "#cba6f7", bold = true })
      set(0, "WhichKeyGroup", { fg = "#89b4fa" })
      set(0, "WhichKeyDesc", { fg = "#cdd6f4" })
      set(0, "WhichKeySeparator", { fg = "#585b70" })
      set(0, "WhichKeyIcon", { fg = "#f5c2e7" })
      set(0, "WhichKeyNormal", { bg = "#181825" })
      set(0, "WhichKeyBorder", { fg = "#cba6f7", bg = "#181825" })
      set(0, "WhichKeyTitle", { fg = "#1e1e2e", bg = "#cba6f7", bold = true })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
  end,
}
