-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"
vim.g.material_style = "deep ocean"

return {
  "marko-cerovac/material.nvim",
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  lazy = false,
  priority = 1000,
  enabled = settings.theme == "material",
  config = function()
    local colors = require("material/colors")
    colors.main.pink = "#ff9cac"
    require("material").setup({
      contrast = {
        sidebars = true,
        floating_windows = false,
        line_numbers = false,
        sign_column = false,
        cursor_line = false,
        popup_menu = true,
      },
      styles = {
        comments = { italic = true },
      },
      plugins = {
        "gitsigns",
        "nvim-cmp",
        "nvim-tree",
        "nvim-web-devicons",
        "indent-blankline",
      },
      disable = {
        colored_cursor = true,
        term_colors = true,
      },
      custom_highlights = {
        -- Git Commit Messages
        gitcommitHeader = { fg = colors.main.purple },
        gitcommitUnmerged = { fg = colors.main.green },
        gitcommitSelectedFile = { fg = colors.main.green },
        gitcommitDiscardedFile = { fg = colors.main.red },
        gitcommitUnmergedFile = { fg = colors.main.yellow },
        gitcommitSelectedType = { fg = colors.main.green },
        gitcommitSummary = { fg = colors.main.blue },
        gitcommitDiscardedType = { fg = colors.main.red },

        -- NvimTree
        NvimTreeIndentMarker = { fg = colors.editor.selection },
        NvimTreeFolderIcon = { fg = colors.editor.fg },
        NvimTreeFolderName = { fg = colors.main.blue },
        NvimTreeOpenedFolderName = { fg = colors.main.blue, italic = true },
        NvimTreeGitDirty = { fg = colors.main.yellow },
        NvimTreeGitStaged = { fg = colors.main.green },
        NvimTreeGitMerge = { fg = colors.main.red },
        NvimTreeGitRenamed = { fg = colors.main.orange },
        NvimTreeGitNew = { fg = colors.main.pink },
        NvimTreeGitDeleted = { fg = colors.main.red },
        NvimTreeGitIgnored = { fg = colors.syntax.comments },
        -- GitSigns
        GitSignsAdd = { fg = colors.main.green },
        GitSignsAddNr = { fg = colors.main.green },
        GitSignsAddLn = { fg = colors.main.green },
        GitSignsChange = { fg = colors.main.yellow },
        GitSignsChangeNr = { fg = colors.main.yellow },
        GitSignsChangeLn = { fg = colors.main.yellow },
        GitSignsDelete = { fg = colors.main.red },
        GitSignsDeleteNr = { fg = colors.main.red },
        GitSignsDeleteLn = { fg = colors.main.red },

        -- DiffView
        gitcommitNoBranch = { link = "gitcommitBranch" },
        gitcommitUntracked = { link = "gitcommitComment" },
        gitcommitDiscarded = { link = "gitcommitComment" },
        gitcommitSelected = { link = "gitcommitComment" },
        gitcommitDiscardedArrow = { link = "gitcommitDiscardedFile" },
        gitcommitSelectedArrow = { link = "gitcommitSelectedFile" },
        gitcommitUnmergedArrow = { link = "gitcommitUnmergedFile" },
      },
    })
    -- set colorscheme
    vim.cmd([[ colorscheme material ]])
  end,
}
