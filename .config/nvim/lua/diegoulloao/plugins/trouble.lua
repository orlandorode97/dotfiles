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

    local function set_highlights()
      local set = vim.api.nvim_set_hl
      set(0, "TroubleNormal", { bg = "#181825" })
      set(0, "TroubleNormalNC", { bg = "#181825" })
      set(0, "TroubleIndent", { fg = "#45475a" })
      set(0, "TroubleCount", { fg = "#1e1e2e", bg = "#a6e3a1", bold = true })
      set(0, "TroublePos", { fg = "#6c7086" })
    end
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })
  end,
}
