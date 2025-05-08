-- settings
local settings = require("diegoulloao.settings")

return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  enabled = settings.theme == "cyberdream",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    local function apply_theme()
      require("cyberdream").setup({
        variant = "default",
        transparent = false,
        saturation = 0.5,
        overrides = function(c)
          return {
            NvimTreeFolderIcon = { fg = "#ff9cac" },
          }
        end,
        extensions = {
          treesitter = true,
          treesittercontext = true,
        },
      })
      vim.cmd("colorscheme cyberdream")
    end

    apply_theme()
  end,
}
