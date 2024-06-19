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
    local eslint_d = require("none-ls.diagnostics.eslint_d")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- custom setup
    null_ls.setup({
      on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup('null_format', {clear = true})
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            desc = 'Fix and format',
            callback = function()
              vim.cmd('EslintFixAll')
              vim.lsp.buf.format({id = client.id})
            end
          })
        end,
        sources = {
          null_ls.builtins.formatting.prettier.with({
            prefer_local = 'node_modules/.bin',
          })
        }
    })
  end,
}
