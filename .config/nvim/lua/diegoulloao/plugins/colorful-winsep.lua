-- require settings
local settings = require("diegoulloao.settings")

return {
  "nvim-zh/colorful-winsep.nvim",
  commit = "db2923c8392bcc7476e8cb7aa312af4f624ca005",
  config = function()
    require("colorful-winsep").setup({
      highlight = {
        fg = "#ea9a97",
      },
      -- timer refresh rate
      interval = 30,
      no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
      -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
      symbols = { "─", "│", "╭", "╮", "╰", "╯" },
      close_event = function()
        -- Executed after closing the window separator
      end,
      create_event = function()
        local win_n = require("colorful-winsep.utils").calculate_number_windows()
        if win_n == 2 then
          local win_id = vim.fn.win_getid(vim.fn.winnr("h"))
          local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype")
          if filetype == "NvimTree" then
            require("colorful-winsep").NvimSeparatorDel()
          end
        end
      end,
    })
  end,
}
