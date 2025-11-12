return {
  "dasupradyumna/midnight.nvim",
  lazy = false,
  priority = 1000,
  enabled = false,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#ff9cac" })
      end,
    })
    -- set colorscheme
    vim.cmd([[ colorscheme midnight]])
  end,
}
