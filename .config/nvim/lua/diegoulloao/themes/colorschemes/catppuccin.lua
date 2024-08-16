-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "catppuccin/nvim",
  lazy = false,
  enabled = settings.theme == "catppuccin",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    require("catppuccin").setup({
      integrations = {
        cmp = true,
        fidget = true,
        gitsigns = true,
        harpoon = true,
        indent_blankline = {
          enabled = false,
          scope_color = "sapphire",
          colored_indent_levels = false,
        },
        mason = true,
        native_lsp = { enabled = true },
        noice = true,
        notify = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
      },
      color_overrides = {
        mocha = {
          text = "#F4CDE9",
          subtext1 = "#DEBAD4",
          subtext0 = "#C8A6BE",
          overlay2 = "#B293A8",
          overlay1 = "#9C7F92",
          overlay0 = "#866C7D",
          surface2 = "#705867",
          surface1 = "#5A4551",
          surface0 = "#44313B",

          base = "#352939",
          mantle = "#211924",
          crust = "#1a1016",
        },
      },
    })
    vim.cmd([[ colorscheme catppuccin-macchiato]])
    -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
  end,
}
