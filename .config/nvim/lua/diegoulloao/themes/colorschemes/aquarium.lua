return {
  "frenzyexists/aquarium-vim",
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#ff9cac" })
      end,
    })

    vim.cmd.colorscheme("aquarium")
  end,
}
