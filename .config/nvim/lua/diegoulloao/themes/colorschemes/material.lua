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
        -- Common
        Identifier = { fg = colors.main.cyan },
        Todo = { fg = colors.main.yellow, bold = true },
        DiffAdd = { bg = "#45493e" },
        DiffChange = { bg = "#384851" },
        DiffDelete = { fg = colors.editor.selection },
        DiffText = { bg = "#5b7881" },
        MatchParen = { fg = colors.syntax.comments, bg = colors.main.cyan },
        Search = { fg = colors.main.white, bg = colors.syntax.comments },
        IncSearch = { fg = colors.main.white, bg = colors.syntax.comments },
        StatusLine = { fg = colors.syntax.comments, bg = colors.editor.bg },
        StatusLineNC = { fg = colors.editor.selection, bg = colors.editor.bg },
        LspReferenceText = { bg = "#1F2233" },
        LspReferenceRead = { bg = "#1F2233" },
        LspReferenceWrite = { bg = "#1F2233" },
        Pmenu = { fg = colors.editor.fg, bg = colors.editor.border },
        PmenuSel = { bg = colors.syntax.comments },
        PmenuSbar = { bg = colors.editor.active },
        PmenuThumb = { bg = colors.editor.fg },
        NormalFloat = { bg = colors.editor.border },
        PreProc = { fg = colors.main.purple },

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

        -- Cmp
        CmpItemMenu = { fg = colors.main.gray },
        CmpItemAbbrMatch = { fg = colors.main.blue, bold = true },
        CmpItemAbbrDeprecated = { fg = colors.syntax.comments, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = colors.main.blue, bold = true },
        CmpItemKindText = { fg = colors.editor.fg },
        CmpItemKindMethod = { fg = colors.main.paleblue },
        CmpItemKindFunction = { fg = colors.main.purple },
        CmpItemKindConstructor = { fg = colors.main.cyan },
        CmpItemKindField = { fg = colors.main.yellow },
        CmpItemKindVariable = { fg = colors.main.purple },
        CmpItemKindClass = { fg = colors.editor.darkpurple },
        CmpItemKindInterface = { fg = colors.editor.darkorange },
        CmpItemKindModule = { fg = colors.editor.darkblue },
        CmpItemKindProperty = { fg = colors.editor.darkyellow },
        CmpItemKindUnit = { fg = colors.main.green },
        CmpItemKindValue = { fg = colors.main.pink },
        CmpItemKindEnum = { fg = colors.editor.darkgreen },
        CmpItemKindKeyword = { fg = colors.main.purple },
        CmpItemKindSnippet = { fg = colors.editor.darkcyan },
        CmpItemKindColor = { fg = colors.editor.darkred },
        CmpItemKindFile = { fg = colors.main.white },
        CmpItemKindReference = { fg = colors.main.orange },
        CmpItemKindFolder = { fg = colors.main.blue },
        CmpItemKindEnumMember = { fg = colors.main.green },
        CmpItemKindConstant = { fg = colors.editor.darkorange },
        CmpItemKindStruct = { fg = colors.main.purple },
        CmpItemKindEvent = { fg = colors.main.yellow },
        CmpItemKindOperator = { fg = colors.main.blue },

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
