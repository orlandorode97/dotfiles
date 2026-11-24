return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▁" },
      topdelete = { text = "▁" },
      changedelete = { text = "▎" },
      untracked = { text = "┆" },
    },
    preview_config = {
      border = "rounded", -- single|rounded
      style = "minimal",
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 300,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "  <author> • <author_time:%d %b %Y> • <summary>",
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)
    local function blame() vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" }) end
    blame()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = blame })
  end,
}
