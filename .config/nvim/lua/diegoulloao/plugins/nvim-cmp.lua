-- Catppuccin Mocha colors per completion kind
local kind_colors = {
  Text = "#a6adc8", Method = "#89b4fa", Function = "#89b4fa", Constructor = "#74c7ec",
  Field = "#94e2d5", Variable = "#f5c2e7", Class = "#f9e2af", Interface = "#f9e2af",
  Module = "#fab387", Property = "#94e2d5", Unit = "#a6e3a1", Value = "#fab387",
  Enum = "#f9e2af", Keyword = "#cba6f7", Snippet = "#f38ba8", Color = "#f5c2e7",
  File = "#89b4fa", Reference = "#f5c2e7", Folder = "#89b4fa", EnumMember = "#fab387",
  Constant = "#fab387", Struct = "#f9e2af", Event = "#f38ba8", Operator = "#cba6f7",
  TypeParameter = "#f2cdcd",
}

local function set_highlights()
  local set = vim.api.nvim_set_hl
  set(0, "CmpPmenu", { bg = "#181825" })
  set(0, "CmpSel", { bg = "#45475a", bold = true })
  set(0, "CmpBorder", { fg = "#cba6f7", bg = "#181825" })
  set(0, "CmpDoc", { bg = "#1e1e2e" })
  set(0, "CmpDocBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
  set(0, "CmpItemAbbr", { fg = "#cdd6f4" })
  set(0, "CmpItemAbbrDeprecated", { fg = "#6c7086", strikethrough = true })
  set(0, "CmpItemAbbrMatch", { fg = "#89b4fa", bold = true })
  set(0, "CmpItemAbbrMatchFuzzy", { fg = "#89b4fa", bold = true })
  set(0, "CmpItemMenu", { fg = "#6c7086", italic = true })
  set(0, "CmpGhostText", { fg = "#585b70", italic = true })
  for kind, color in pairs(kind_colors) do
    set(0, "CmpItemKind" .. kind, { fg = color })
  end
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
