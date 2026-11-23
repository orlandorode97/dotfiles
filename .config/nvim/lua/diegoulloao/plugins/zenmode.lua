return {
  "folke/zen-mode.nvim",
  cmd = { "ZenMode" },
  opts = {
    window = {
      backdrop = 0.92, -- slightly dimmed background around the text
      width = 100,
      height = 0.9,
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = "0", -- disable fold column
        list = false, -- disable whitespace characters
        winbar = "", -- hide breadcrumbs
      },
    },
    plugins = {
      options = { enabled = true, ruler = false, showcmd = false, laststatus = 0 },
      gitsigns = { enabled = true }, -- hide git signs
      wezterm = { enabled = true, font = "+2" }, -- bigger font in wezterm
    },
    options = {
      laststatus = 0,
    },
    on_open = function()
      vim.o.cmdheight = 1
      vim.diagnostic.config({ virtual_text = false }) -- no inline noise
      pcall(function() require("ibl").setup_buffer(0, { enabled = false }) end)
    end,
    on_close = function()
      vim.o.cmdheight = 0
      vim.diagnostic.config({ virtual_text = { prefix = "●", spacing = 2, source = "if_many" } })
      pcall(function() require("ibl").setup_buffer(0, { enabled = true }) end)
    end,
  },
}
