-- configuration instructions
-- -- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
--
-- -- options
-- local settings = require("diegoulloao.settings")
--
-- -- for conciseness
-- local opt = vim.opt -- vim options
--
-- -- set options
-- opt.completeopt = "menu,menuone,noselect"
--
-- local cmp_kinds = {
--   Text = "󰉿",
--   Method = "󰆧",
--   Function = "󰊕",
--   Constructor = "",
--   Field = "󰜢",
--   Variable = "󰀫",
--   Class = "󰠱",
--   Interface = "",
--   Module = "",
--   Property = "󰜢",
--   Unit = "󰑭",
--   Value = "󰎠",
--   Enum = "",
--   Keyword = "󰌋",
--   Snippet = "",
--   Color = "󰏘",
--   File = "󰈙",
--   Reference = "󰈇",
--   Folder = "󰉋",
--   EnumMember = "",
--   Constant = "󰏿",
--   Struct = "󰙅",
--   Event = "",
--   Operator = "󰆕",
--   TypeParameter = "",
-- }
--
-- return {
--   "hrsh7th/nvim-cmp",
--   dependencies = {
--     "hrsh7th/cmp-buffer",
--     "hrsh7th/cmp-path",
--     "onsails/lspkind.nvim",
--     "L3MON4D3/LuaSnip",
--     "saadparwaiz1/cmp_luasnip",
--     "rafamadriz/friendly-snippets",
--   },
--   event = "InsertEnter",
--   config = function()
--     -- load friendly-snippets
--     require("luasnip.loaders.from_vscode").lazy_load()
--
--     -- require cmp
--     local cmp = require("cmp")
--
--     -- require luasnip
--     local luasnip = require("luasnip")
--
--     -- require lspkind
--     local lspkind = require("lspkind")
--
--     -- custom setup
--     cmp.setup({
--       window = {
--         completion = {
--           border = "rounded", -- single|rounded|none
--           -- custom colors
--           -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None", -- BorderBG|FloatBorder
--           side_padding = settings.cmp_style == "default" and 1 or 0, -- padding at sides
--           col_offset = settings.cmp_style == "default" and -1 or -4, -- move floating box left or right
--         },
--         documentation = {
--           border = "rounded", -- single|rounded|none
--           -- custom colors
--           winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None", -- BorderBG|FloatBorder
--         },
--       },
--       snippet = {
--         expand = function(args)
--           luasnip.lsp_expand(args.body)
--         end,
--       },
--       mapping = cmp.mapping.preset.insert({
--         ["<C-k>"] = cmp.mapping.select_prev_item(), -- select previous suggestion
--         ["<S-tab>"] = cmp.mapping.select_prev_item(), -- select previous suggestion (2)
--         ["<C-j>"] = cmp.mapping.select_next_item(), -- select next suggestion
--         ["<tab>"] = cmp.mapping.select_next_item(), -- select next suggestion (2)
--         ["<C-l>"] = cmp.mapping.scroll_docs(-4), -- scroll docs down
--         ["<C-h>"] = cmp.mapping.scroll_docs(4), -- scroll docs up
--         ["<C-e>"] = cmp.mapping.abort(), -- close completion window
--         ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
--         ["<CR>"] = cmp.mapping.confirm({ select = false }), -- confirm suggestion
--       }),
--       sources = cmp.config.sources({
--         { name = "nvim_lsp" }, -- lsp
--         { name = "luasnip" }, -- luasnips
--         { name = "buffer" }, -- text within the current buffer
--         { name = "path" }, -- file system paths
--       }),
--       formatting = {
--         fields = settings.cmp_style == "nvchad" and { "kind", "abbr", "menu" } or nil,
--         format = function(entry, item)
--           -- vscode like icons for cmp autocompletion
--           local fmt = lspkind.cmp_format({
--             -- with_text = false, -- hide kind beside the icon
--             mode = "symbol_text",
--             maxwidth = 50,
--             ellipsis_char = "...",
--           })(entry, item)
--
--           -- customize lspkind format
--           local strings = vim.split(fmt.kind, "%s", { trimempty = true })
--
--           -- strings[1] -> default icon
--           -- strings[2] -> kind
--
--           -- set different icon styles
--           fmt.kind = " " .. (cmp_kinds[strings[2]] or "") -- concatenate icon based on kind
--
--           -- append customized kind text
--           if settings.cmp_style == "nvchad" then
--             fmt.kind = fmt.kind .. " " -- just an extra space at the end
--             fmt.menu = strings[2] ~= nil and ("  " .. (strings[2] or "")) or ""
--           else
--             -- default and others
--             fmt.menu = strings[2] ~= nil and (strings[2] or "") or ""
--           end
--
--           return fmt
--         end,
--       },
--     })
--   end,
-- }
local config = function()
  local cmp = require("cmp")
  local lspkind = require("lspkind")

  vim.opt.completeopt = "menu,menuone,noselect"

  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),
    }),
    sources = {
      { name = "nvim_lsp" },
      { name = "path" },
    },
    window = {
      completion = { border = "solid" },
      documentation = { border = "solid" },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (strings[2] or "") .. ")"

        return kind
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
  },
  config = config,
}
