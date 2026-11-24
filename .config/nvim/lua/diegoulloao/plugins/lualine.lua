-- palette read from the active colorscheme
local function hl(name, attr, fallback)
  local v = vim.api.nvim_get_hl(0, { name = name, link = false })[attr]
  return v and string.format("#%06x", v) or fallback
end

local colors = {}
local function refresh_colors()
  colors.bg = hl("Normal", "bg", "#1e1e2e")
  colors.bg_alt = hl("CursorLine", "bg", hl("Visual", "bg", "#313244"))
  colors.fg = hl("Normal", "fg", "#cdd6f4")
  colors.fg_dim = hl("Comment", "fg", "#a6adc8")
  colors.red = hl("DiagnosticError", "fg", "#f38ba8")
  colors.green = hl("DiagnosticOk", "fg", hl("String", "fg", "#a6e3a1"))
  colors.yellow = hl("DiagnosticWarn", "fg", "#f9e2af")
  colors.blue = hl("Function", "fg", "#89b4fa")
  colors.purple = hl("Keyword", "fg", "#cba6f7")
  colors.cyan = hl("DiagnosticHint", "fg", "#94e2d5")
  colors.pink = hl("Constant", "fg", "#f5c2e7")
  colors.peach = hl("Number", "fg", "#fab387")
end
refresh_colors()

-- Rounded pill edges (nerd font powerline glyphs)
local L, R = vim.fn.nr2char(0xe0b6), vim.fn.nr2char(0xe0b4)
local pill = { left = L, right = R }
local gap = { function() return " " end, color = { bg = "NONE" }, padding = 0 }

-- Transparent middle so the pills "float"
local function theme_for(color)
  return {
    a = { bg = color, fg = colors.bg, gui = "bold" },
    b = { bg = colors.bg_alt, fg = colors.fg },
    c = { bg = "NONE", fg = colors.fg_dim },
  }
end

local function make_theme() return {
  normal = theme_for(colors.blue),
  insert = theme_for(colors.green),
  visual = theme_for(colors.purple),
  replace = theme_for(colors.red),
  command = theme_for(colors.yellow),
  terminal = theme_for(colors.cyan),
  inactive = theme_for(colors.bg_alt),
} end

local mode_colors = {}
local function refresh_modes()
  mode_colors = {
  n = colors.blue,
  i = colors.green,
  v = colors.purple,
  V = colors.purple,
  [""] = colors.purple,
  c = colors.yellow,
  R = colors.red,
  t = colors.cyan,
  }
end

local function mode_color()
  return { bg = mode_colors[vim.fn.mode()] or colors.blue, fg = colors.bg, gui = "bold" }
end

-- LSP + formatters + linters
local function get_lsp()
  local names = {}
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if c.name ~= "null-ls" then
      names[#names + 1] = c.name
    end
  end

  local ok_cf, conform = pcall(require, "conform")
  if ok_cf then
    for _, fmt in ipairs(conform.list_formatters_for_buffer()) do
      names[#names + 1] = fmt
    end
  end

  local ok_lint, lint = pcall(require, "lint")
  if ok_lint then
    local entries = lint.linters_by_ft[vim.bo.filetype]
    if type(entries) == "string" then
      names[#names + 1] = entries
    elseif type(entries) == "table" then
      vim.list_extend(names, entries)
    end
  end

  local seen, uniq = {}, {}
  for _, n in ipairs(names) do
    if not seen[n] then
      seen[n] = true
      uniq[#uniq + 1] = n
    end
  end

  return #uniq == 0 and "󰒲 none" or "󰒋 " .. table.concat(uniq, " · ")
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",

  config = function()
    local function setup()
      refresh_colors()
      refresh_modes()
      require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = make_theme(),
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "snacks_dashboard" },
        },
      },

      sections = {
        -- LEFT: every block is its own colored pill, with a gap between them
        lualine_a = {
          { "mode", icon = "", color = mode_color, separator = pill, padding = { left = 1, right = 1 } },
          gap,
        },

        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.bg, bg = colors.pink, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
          gap,
          {
            "filename",
            file_status = true,
            symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]" },
            color = { fg = colors.fg, bg = colors.bg_alt, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
        },

        lualine_c = {
          gap,
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.blue },
              hint = { fg = colors.cyan },
            },
          },
          {
            function()
              local s = vim.fn.searchcount({ maxcount = 9999, recompute = 1 })
              return " " .. s.current .. "/" .. s.total
            end,
            cond = function()
              return vim.v.hlsearch == 1 and vim.fn.searchcount().total > 0
            end,
            color = { fg = colors.cyan },
          },
        },

        -- RIGHT
        lualine_x = {
          {
            function()
              local ok, noice = pcall(require, "noice")
              return ok and noice.api.status.mode.get() or ""
            end,
            cond = function()
              local ok, noice = pcall(require, "noice")
              return ok and noice.api.status.mode.has()
            end,
            color = { fg = colors.purple, gui = "italic" },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
          gap,
        },

        lualine_y = {
          {
            "filetype",
            icon_only = false,
            color = { fg = colors.bg, bg = colors.cyan, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
          gap,
          {
            get_lsp,
            color = { bg = colors.peach, fg = colors.bg, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
          gap,
        },

        lualine_z = {
          {
            "location",
            icon = "󰽯",
            color = { bg = colors.green, fg = colors.bg, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
          gap,
          {
            "progress",
            color = { bg = colors.purple, fg = colors.bg, gui = "bold" },
            separator = pill,
            padding = { left = 1, right = 1 },
          },
        },
      },

      -- TABLINE
      tabline = {
        lualine_a = {
          {
            "buffers",
            separator = pill,
            buffers_color = {
              active = { bg = colors.blue, fg = colors.bg, gui = "bold" },
              inactive = { bg = colors.bg_alt, fg = colors.fg_dim },
            },
            symbols = { alternate_file = "", modified = " ●", directory = "" },
            filetype_names = {
              TelescopePrompt = "Telescope",
              dashboard = "Dashboard",
              fzf = "FZF",
            },
          },
        },
      },

      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },

      extensions = { "nvim-tree", "toggleterm", "mason", "fzf", "quickfix", "man", "lazy" },
    })
    end
    setup()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(setup) })
  end,
}
