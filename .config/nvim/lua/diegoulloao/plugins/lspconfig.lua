-- require keybindings for lsp server
local attach_keymaps = require("diegoulloao.core.keymaps.lsp")

return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- require lspconfig
    local lspconfig = require("lspconfig")

    -- used to enable autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- for emmet support
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- attach keymaps
    local on_attach = function(client, bufnr)
      attach_keymaps(client, bufnr)
    end

    lspconfig["gopls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["rust_analyzer"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["eslint"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["terraformls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["protols"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["prismals"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["yamlls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        yaml = {
          format = {
            enable = true,
          },
        },
      },
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
        },
      },
    })

    lspconfig["intelephense"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          formatting = {
            tabSize = 4,
            insertSpaces = true,
          },
        },
      },
    })

    lspconfig["docker_compose_language_service"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig["dockerls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- For PHP files, use 4 spaces for indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "php",
      command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab",
    })

    -- add borders to lsp info window
    require("lspconfig.ui.windows").default_options.border = "single"
  end,
}
