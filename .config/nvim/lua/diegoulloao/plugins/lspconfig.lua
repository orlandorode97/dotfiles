-- require keybindings for lsp server
local attach_keymaps = require("diegoulloao.core.keymaps.lsp")

return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- used to enable autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- for emmet support
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- defaults for every server
    vim.lsp.config("*", { capabilities = capabilities })

    -- attach keymaps (replaces on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        attach_keymaps(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
      end,
    })

    -- per-server settings
    vim.lsp.config("yamlls", { settings = { yaml = { format = { enable = true } } } })
    vim.lsp.config("lua_ls", { settings = { Lua = { runtime = { version = "LuaJIT" } } } })
    vim.lsp.config("intelephense", {
      settings = { intelephense = { formatting = { tabSize = 4, insertSpaces = true } } },
    })

    vim.lsp.enable({
      "gopls", "ts_ls", "rust_analyzer", "eslint", "terraformls", "protols", "prismals",
      "yamlls", "lua_ls", "intelephense", "docker_compose_language_service", "dockerls", "ruby_lsp",
    })

    -- diagnostics look
    local e = vim.diagnostic.severity
    vim.diagnostic.config({
      signs = {
        text = {
          [e.ERROR] = "",
          [e.WARN] = "",
          [e.INFO] = "",
          [e.HINT] = "󰌵",
        },
      },
      virtual_text = { prefix = "●", spacing = 2, source = "if_many" },
      underline = true,
      severity_sort = true,
      update_in_insert = false,
      float = { border = "rounded", source = true, header = "", prefix = "" },
    })

    -- For PHP files, use 4 spaces for indentation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "php",
      command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab",
    })
  end,
}
