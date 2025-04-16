return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- custom setup
    null_ls.setup({
      border = "single",
      sources = {
        formatting.prettierd.with({
          extra_filetypes = { "svelte", "astro", "php", "yaml" },
          filetypes = { "yaml" },
        }),
        formatting.stylua,
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      null_ls.disable({
        filetypes = { "typescript" },
      }),
    })
  end,
}
