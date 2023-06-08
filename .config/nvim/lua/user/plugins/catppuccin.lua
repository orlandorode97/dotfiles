return {
  "catppuccin/nvim",
  name = "catppuccin",
  enable = true,
  config = function()
    local THEME_NAME = "carbon"

    local colors_overrides = THEME_NAME ~= "catppuccin" and require("user.plugins.themes." .. THEME_NAME) or
        {}

    require("catppuccin").setup({
      background = {
        light = "latte",
        dark = "mocha",
      },
      color_overrides = colors_overrides,
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "bold" },
        operators = {},
      },
      no_italic = true,
      transparent_background = false,
      show_end_of_buffer = false,
      highlight_overrides = {
        all = function(colors)
          return {
            NormalFloat = { bg = colors.base },
            FloatBorder = { bg = colors.base, fg = colors.surface0 },
            LspInfoBorder = { link = "FloatBorder" },
            NullLsInfoBorder = { link = "FloatBorder" },
            VertSplit = { bg = colors.base, fg = colors.surface0 },
            CursorLineNr = { fg = colors.mauve, style = { "bold" } },
            Pmenu = { bg = colors.mantle, fg = "" },
            PmenuSel = { bg = colors.crust, fg = "" },
            TelescopeSelection = { bg = colors.surface0 },
            TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
            TelescopePromptPrefix = { bg = colors.surface0 },
            TelescopePromptNormal = { bg = colors.surface0 },
            TelescopeResultsNormal = { bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.crust },
            TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
            TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
            TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
            TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
            TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
            TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
            GitSignsChange = { fg = colors.peach },
            NvimTreeIndentMarker = { fg = colors.surface0 },
            WhichKeyFloat = { bg = colors.mantle },
            LineNr = { fg = colors.surface1 },
            IndentBlanklineChar = { fg = colors.surface0 },
            IndentBlanklineContextChar = { fg = colors.surface2 },

            Structure = { fg = THEME_NAME == "carbon" and colors.pink or colors.yellow },
            StorageClass = { fg = THEME_NAME == "carbon" and colors.pink or colors.yellow },
            Type = { fg = THEME_NAME == "carbon" and colors.pink or colors.yellow, style = { "bold" } },
            Constant = { fg = THEME_NAME == "carbon" and colors.text or colors.peach, style = { "bold" } },
            Number = { fg = THEME_NAME == "carbon" and colors.text or colors.peach },
            Float = { fg = THEME_NAME == "carbon" and colors.text or colors.peach },
            Boolean = { fg = THEME_NAME == "carbon" and colors.text or colors.peach },

            ["@function.builtin"] = { fg = THEME_NAME == "carbon" and colors.text or colors.peach },
            ["@method"] = { fg = THEME_NAME == "carbon" and colors.pink or colors.peach },
            ["@constant"] = { fg = THEME_NAME == "carbon" and colors.text or colors.peach, style = { "bold" } },
            ["@variable.builtin"] = { fg = THEME_NAME == "carbon" and colors.text or colors.red },
            ["@type.builtin"] = { fg = THEME_NAME == "carbon" and colors.pink or colors.yellow, style = { "bold" } },
          }
        end,
      },
    })

    vim.api.nvim_command("colorscheme catppuccin")
  end,
}
