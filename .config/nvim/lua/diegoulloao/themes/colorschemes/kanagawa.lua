-- settings
local settings = require("diegoulloao.settings")

return {
  "rebelot/kanagawa.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "kanagawa",
  config = function()
    -- custom setup
    require("kanagawa").setup({
      compile = false, -- enable compiling the colorscheme
      undercurl = true, -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false, -- do not set background color
      dimInactive = false, -- dim inactive window `:h hl-NormalNC`
      terminalColors = true, -- define vim.g.terminal_color_{0,17}
      colors = { -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
        return {}
      end,
      theme = "wave", -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = "wave", -- try "dragon" !
        light = "lotus",
      },
    })

    -- set colorscheme
    vim.cmd([[ colorscheme kanagawa ]])
  end,
}
