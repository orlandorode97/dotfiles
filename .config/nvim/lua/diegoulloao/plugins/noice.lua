return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  config = function()
    require("notify").setup({
      stages = "fade",
      timeout = 2500,
      render = "compact",
      background_colour = "NormalFloat",
    })

    require("noice").setup({
      lsp = {
        -- better markdown hover/signature (works with cmp docs)
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false, -- floating search like cmdline
        command_palette = true, -- cmdline + popupmenu centered at top
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          border = { style = "rounded", padding = { 0, 1 } },
          win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "NoiceCmdlinePopupBorder" } },
        },
      },
    })

  end,
}
