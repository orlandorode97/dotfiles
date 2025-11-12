return {
  "sam4llis/nvim-tundra",
  lazy = false,
  priority = 1000,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#ff9cac" })
      end,
    })

    vim.g.tundra_biome = "arctic" -- 'arctic' or 'jungle'
    vim.opt.background = "dark"
    vim.cmd("colorscheme tundra")
  end,
}
