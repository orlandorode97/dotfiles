local function set_highlights()
  local set = vim.api.nvim_set_hl
  set(0, "CmpPmenu", { link = "NormalFloat" })
  set(0, "CmpSel", { link = "PmenuSel" })
  set(0, "CmpBorder", { link = "FloatBorder" })
  set(0, "CmpDoc", { link = "NormalFloat" })
  set(0, "CmpDocBorder", { link = "FloatBorder" })
end

local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")

  vim.opt.completeopt = "menu,menuone,noselect"
  set_highlights()
  vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noselect",
      scrollbar = true,
    },

    window = {
      completion = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      }),
      documentation = cmp.config.window.bordered({
        border = "rounded",
        winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,Search:None",
      }),
    },

    experimental = { ghost_text = true },

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
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
      format = function(entry, item)
        local menu = {
          nvim_lsp = "LSP", luasnip = "Snip", buffer = "Buf", path = "Path",
        }
        item.kind_hl_group = "CmpItemKind" .. item.kind
        item.kind = " " .. (lspkind.symbolic(item.kind, { mode = "symbol" }) or "") .. " "
        item.menu = "  " .. (menu[entry.source.name] or entry.source.name)
        if #item.abbr > 40 then
          item.abbr = item.abbr:sub(1, 39) .. "…"
        end
        return item
      end,
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
