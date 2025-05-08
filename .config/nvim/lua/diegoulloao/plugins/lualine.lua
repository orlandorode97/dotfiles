local colors = require("kanso.colors").setup({ theme = "ink" }).palette

local extensions = require("diegoulloao.extensions.lualine")

local modecolor = {
  n = colors.inkRed,
  i = colors.inkTeal,
  v = colors.inkViolet,
  [""] = colors.inkViolet,
  V = colors.inkRed,
  c = colors.inkYellow,
  no = colors.inkRed,
  s = colors.inkYellow,
  S = colors.inkYellow,
  [""] = colors.inkYellow,
  ic = colors.inkYellow,
  R = colors.inkGreen,
  Rv = colors.inkViolet,
  cv = colors.inkRed,
  ce = colors.inkRed,
  r = colors.inkTeal,
  rm = colors.inkTeal,
  ["r?"] = colors.inkTeal,
  ["!"] = colors.inkRed,
  t = colors.inkOrange2,
}

local theme = {
  normal = {
    a = { fg = colors.zen2, bg = colors.inkBlue },
    b = { fg = colors.inkBlue, bg = colors.zen3 },
    c = { fg = colors.inkWhite, bg = colors.zen3 },
    z = { fg = colors.inkWhite, bg = colors.zen3 },
  },
  insert = { a = { fg = colors.zen2, bg = colors.inkOrange } },
  visual = { a = { fg = colors.zen2, bg = colors.inkGreen } },
  replace = { a = { fg = colors.zen2, bg = colors.inkGreen } },
}

-- Space, filename, filetype, and other components will follow the same color scheme updates
local space = {
  function()
    return " "
  end,
  color = { bg = colors.zen3, fg = colors.inkBlue },
}

local filename = {
  "filename",
  color = { bg = colors.inkBlue, fg = colors.zen2, gui = "bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkViolet }, -- Updated color for the separators
}

local filetype = {
  "filetype",
  icons_enabled = false,
  color = { bg = colors.inkGreen2, fg = colors.inkBlue, gui = "italic,bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkYellow }, -- Updated color for the separators
}

local branch = {
  "branch",
  icon = "",
  color = { bg = colors.inkGreen, fg = colors.zen2, gui = "bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkOrange2 }, -- Updated color for the separators
}

local location = {
  "location",
  color = { bg = colors.inkYellow, fg = colors.zen3, gui = "bold" }, -- Updated fg to zen3 for better contrast
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkBlue }, -- Adjust separator color
}
local diff = {
  "diff",
  color = { bg = colors.pearlYellow, fg = colors.zen2, gui = "bold" },
  separator = { left = "|", right = "|" },
  symbols = { added = " ", modified = " ", removed = " " },
  separator_color = { fg = colors.inkRed }, -- Updated color for the separators

  diff_color = {
    added = { fg = colors.pearlGreen3 },
    modified = { fg = colors.inkYellow },
    removed = { fg = colors.inkRed },
  },
}

local macro = {
  function()
    return require("noice").api.status.mode.get()
  end,
  cond = function()
    return require("noice").api.status.mode.has()
  end,
  color = { fg = colors.inkRed, bg = colors.zen3, gui = "italic,bold" },
  separator_color = { fg = colors.inkTeal }, -- Updated color for the separators
}

local modes = {
  "mode",
  color = function()
    local mode_color = modecolor
    return { bg = mode_color[vim.fn.mode()], fg = colors.zen2, gui = "bold" }
  end,
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkViolet }, -- Updated color for the separators
}

local function getLspName()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })
  local buf_ft = vim.bo.filetype
  if next(buf_clients) == nil then
    return "  No servers"
  end
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local lint_s, lint = pcall(require, "lint")
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == "table" then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == "string" then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  local ok, conform = pcall(require, "conform")
  local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
  if ok then
    for formatter in formatters:gmatch("%w+") do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end

  local hash = {}
  local unique_client_names = {}

  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      unique_client_names[#unique_client_names + 1] = v
      hash[v] = true
    end
  end
  local language_servers = table.concat(unique_client_names, ", ")

  return "  " .. language_servers
end

local dia = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  diagnostics_color = {
    error = { fg = colors.inkRed },
    warn = { fg = colors.inkYellow },
    info = { fg = colors.inkViolet },
    hint = { fg = colors.inkTeal },
  },
  color = { bg = colors.inkGreen2, fg = colors.inkBlue, gui = "bold" },
  separator = { left = "|" },
  separator_color = { fg = colors.inkOrange2 }, -- Updated color for the separators
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.inkViolet }, -- Updated color for the separators
  color = { bg = colors.inkViolet, fg = colors.zen2, gui = "italic,bold" },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  after = "noice.nvim",
  config = function()
    require("lualine").setup({
      options = {
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
      },

      sections = {
        lualine_a = {
          modes,
        },
        lualine_b = {
          space,
        },
        lualine_c = {
          filename,
          filetype,
          {
            function()
              local search = vim.fn.searchcount({ maxcount = 9999, recompute = 1 })
              if search.total > 0 then
                return " " .. search.current .. "/" .. search.total -- Shows current match / total
              end
              return ""
            end,
            cond = function()
              return vim.fn.searchcount().total > 0 -- Only show if search is active
            end,
          },
          space,
          space,
        },
        lualine_x = {
          space,
        },
        lualine_y = { macro, space, branch, diff },
        lualine_z = {
          {
            "location",
            separator = { left = "|", right = "|" },
            separator_color = { fg = colors.inkBlue },
            color = { fg = colors.zen2, bg = colors.inkYellow },
          },
          lsp,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "nvim-tree",
        "toggleterm",
        "mason",
        "fzf",
        "quickfix",
        "man",
        "lazy",
        extensions.telescope,
        extensions.lspinfo,
        extensions.saga,
        extensions.btw,
      },
    })
  end,
}
