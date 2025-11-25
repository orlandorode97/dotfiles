-- PALETA MÍNIMA (puedes cambiar colores fácilmente)
local colors = {
  bg = "#1e1e2e",
  bg_alt = "#181825",
  fg = "#cdd6f4",
  fg_dim = "#a6adc8",
  red = "#f38ba8",
  green = "#a6e3a1",
  yellow = "#f9e2af",
  blue = "#89b4fa",
  purple = "#cba6f7",
  cyan = "#94e2d5",
  gray = "#45475a",
}

-- MODE COLORS
local function mode_color()
  local mc = {
    n = colors.blue,
    i = colors.green,
    v = colors.purple,
    V = colors.purple,
    [""] = colors.purple,
    c = colors.yellow,
    R = colors.red,
    t = colors.cyan,
  }
  return { bg = mc[vim.fn.mode()] or colors.blue, fg = colors.bg, gui = "bold" }
end

-- LSP + FORMATTERS + LINTERS
local function get_lsp()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  if #clients == 0 then
    return " none"
  end

  local names = {}
  for _, c in ipairs(clients) do
    if c.name ~= "null-ls" then
      table.insert(names, c.name)
    end
  end

  -- conform
  local ok_cf, conform = pcall(require, "conform")
  if ok_cf then
    for _, fmt in ipairs(conform.list_formatters_for_buffer()) do
      table.insert(names, fmt)
    end
  end

  -- lint
  local ok_lint, lint = pcall(require, "lint")
  if ok_lint then
    local ft = vim.bo.filetype
    local entries = lint.linters_by_ft[ft]
    if type(entries) == "string" then
      table.insert(names, entries)
    elseif type(entries) == "table" then
      for _, item in ipairs(entries) do
        table.insert(names, item)
      end
    end
  end

  -- unique
  local seen, uniq = {}, {}
  for _, n in ipairs(names) do
    if not seen[n] then
      uniq[#uniq + 1] = n
      seen[n] = true
    end
  end

  return " " .. table.concat(uniq, ", ")
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",

  config = function()
    require("lualine").setup({

      -----------------------------------------------------------------------
      -- OPTIONS
      -----------------------------------------------------------------------
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "snacks_dashboard" },
        },
      },

      -----------------------------------------------------------------------
      -- STATUSLINE
      -----------------------------------------------------------------------
      sections = {

        -- LEFT
        lualine_a = {
          { "mode", color = mode_color, separator = { left = "", right = "" } },
        },

        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.blue, bg = colors.bg_alt, gui = "bold" },
            separator = { left = "", right = "" },
          },
        },

        lualine_c = {
          {
            "filename",
            color = { fg = colors.yellow, gui = "bold" },
            separator = { left = "", right = "" },
          },

          -- search count
          {
            function()
              local s = vim.fn.searchcount({ maxcount = 9999, recompute = 1 })
              return s.total > 0 and (" " .. s.current .. "/" .. s.total) or ""
            end,
            cond = function()
              return vim.fn.searchcount().total > 0
            end,
            color = { fg = colors.cyan },
          },
        },

        -- RIGHT
        lualine_x = {
          -- Noice macro indicator
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
        },

        lualine_y = {

          -- DIFF
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
            color = { bg = colors.bg_alt },
            separator = { left = "", right = "" },
          },

          -- DIAGNOSTICS
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.blue },
              hint = { fg = colors.cyan },
            },
            color = { bg = colors.bg_alt },
            separator = { left = "" },
          },
        },

        lualine_z = {

          {
            get_lsp,
            color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
            separator = { left = "", right = "" },
          },

          {
            "location",
            color = { bg = colors.green, fg = colors.bg, gui = "bold" },
            separator = { left = "", right = "" },
          },
        },
      },

      -----------------------------------------------------------------------
      -- TABLINE (actualizado, más bonito, VSCode-like)
      -----------------------------------------------------------------------
      tabline = {
        lualine_a = {
          {
            "buffers",

            separator = { right = "" },

            buffers_color = {
              active = { bg = colors.blue, fg = colors.bg, gui = "bold" },
              inactive = { bg = colors.bg_alt, fg = colors.fg_dim },
            },

            symbols = {
              alternate_file = "",
              modified = "●",
              directory = "",
            },

            filetype_names = {
              TelescopePrompt = "Telescope",
              dashboard = "Dashboard",
              fzf = "FZF",
            },
          },
        },

        lualine_z = {
          {
            function()
              return ""
            end,
            color = { fg = colors.blue, bg = colors.bg_alt },
            separator = { left = "", right = "" },
          },
        },
      },

      -----------------------------------------------------------------------
      -- INACTIVE
      -----------------------------------------------------------------------
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      -----------------------------------------------------------------------
      -- EXTENSIONS
      -----------------------------------------------------------------------
      extensions = {
        "nvim-tree",
        "toggleterm",
        "mason",
        "fzf",
        "quickfix",
        "man",
        "lazy",
      },
    })
  end,
}
