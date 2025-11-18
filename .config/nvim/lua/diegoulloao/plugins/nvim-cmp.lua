local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noselect",
      scrollbar = true,
    },

    window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        -- winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
        --winhighlight = "Normal:CmpDoc,FloatBorder:CmpBorder,Search:None",
      }),
    },

    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-Space>"] = cmp.mapping.complete(),
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500, keyword_length = 2 },
      { name = "path", priority = 250 },
    }),

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
        before = function(entry, vim_item)
          -- 🔸 New icons per source
          local menu_icon = {
            nvim_lsp = "  LSP",
            luasnip = "  Snip",
            buffer = "  Buf",
            path = "  Path",
            nvim_lua = "  Lua",
            emoji = "󰞅  Emoji",
            cmp_git = "  Git",
          }

          vim_item.menu = menu_icon[entry.source.name] or ""
          return vim_item
        end,
      }),
    },
  })
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  event = "InsertEnter",
  config = config,
}
