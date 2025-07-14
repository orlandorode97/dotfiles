-- settings
local settings = require("diegoulloao.settings")

-- set dark background
vim.opt.background = "dark"

return {
  "LunarVim/synthwave84.nvim",
  lazy = false,
  enabled = settings.theme == "synthwave84",
  priority = 1000,
  dependencies = {
    "nvim-lualine/lualine.nvim", -- load lualine first (applies hi groups correctly)
  },
  config = function()
    local function apply_theme()
      require("synthwave84").setup({
        glow = {
          error_msg = false,
          type2 = false,
          func = false,
          keyword = false,
          operator = false,
          buffer_current_target = false,
          buffer_visible_target = false,
          buffer_inactive_target = false,
        },
      })
      vim.cmd([[ colorscheme synthwave84 ]])
      vim.api.nvim_create_autocmd({ "ColorScheme", "BufEnter" }, {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#d65d0e" })
          vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { fg = "#d65d0e" })
        end,
      })
    end
    apply_theme()
  end,
}
