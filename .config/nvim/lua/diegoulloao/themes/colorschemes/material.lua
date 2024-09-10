-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.g.material_style = "darker"

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
        terminal = false,            -- Enable contrast for the built-in terminal
        sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false,    -- Enable contrast for floating windows
        cursor_line = false,         -- Enable darker background for the cursor line
        lsp_virtual_text = false,    -- Enable contrasted background for lsp virtual text
        non_current_windows = false, -- Enable contrasted background for non-current windows
        filetypes = {},              -- Specify which filetypes get
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
        "trouble",
        "telescope",
      },
      disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false,        -- Disable borders between vertically split windows
        background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false,    -- Prevent the theme from setting terminal colors
        eob_lines = false,      -- Hide the end-of-buffer lines
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
        NvimTreeFolderIcon = { fg = colors.main.orange },
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
