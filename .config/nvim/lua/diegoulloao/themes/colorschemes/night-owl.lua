-- settings
local settings = require("diegoulloao.settings")

return {
  "oxfist/night-owl.nvim",
  lazy = false,
  enabled = settings.theme == "night-owl",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    local function apply_theme()
      -- load the colorscheme here
      require("night-owl").setup({
        highlights = {
          NvimTreeFolderIcon = { fg = "#ff9cac" },
        },
      })
      vim.cmd.colorscheme("night-owl")
      vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#ff9cac" })

      -- require("cyberdream").setup({
      --   variant = "default",
      --   transparent = false,
      --   saturation = 0.5,
      --   overrides = function(c)
      --     return {
      --       NvimTreeFolderIcon = { fg = "#ff9cac" },
      --     }
      --   end,
      --   extensions = {
      --     treesitter = true,
      --     treesittercontext = true,
      --   },
      -- })
      -- vim.cmd("colorscheme cyberdream")
    end

    apply_theme()
  end,
}
