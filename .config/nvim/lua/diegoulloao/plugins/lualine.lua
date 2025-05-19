local colors = require("nightfox.palette").load("duskfox")

local extensions = require("diegoulloao.extensions.lualine")

-- map vim modes to your palette colors
local modecolor = {
  n = colors.red.base,
  i = colors.cyan.base,
  v = colors.magenta.base,
  [""] = colors.magenta.base,
  V = colors.red.base,
  c = colors.yellow.base,
  no = colors.red.base,
  s = colors.yellow.base,
  S = colors.yellow.base,
  [""] = colors.yellow.base,
  ic = colors.yellow.base,
  R = colors.green.base,
  Rv = colors.magenta.base,
  cv = colors.red.base,
  ce = colors.red.base,
  r = colors.cyan.base,
  rm = colors.cyan.base,
  ["r?"] = colors.cyan.base,
  ["!"] = colors.red.base,
  t = colors.orange.base,
}

-- theme sections using your palette
local theme = {
  normal = {
    a = { fg = colors.bg1, bg = colors.blue.base },
    b = { fg = colors.blue.base, bg = colors.red.base },
    c = { fg = colors.bg1, bg = colors.red.base },
    z = { fg = colors.bg1, bg = colors.red.base },
  },
  insert = { a = { fg = colors.bg1, bg = colors.orange.base } },
  visual = { a = { fg = colors.bg1, bg = colors.green.base } },
  replace = { a = { fg = colors.bg1, bg = colors.green.base } },
}

-- simple space component
local space = {
  function()
    return " "
  end,
  color = { bg = colors.red.base, fg = colors.blue.base },
}

-- filename, filetype, branch, etc.
local filename = {
  "filename",
  color = { bg = colors.blue.base, fg = colors.bg1, gui = "bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.magenta.base },
}

local filetype = {
  "filetype",
  icons_enabled = false,
  color = { bg = colors.green.base, fg = colors.blue.base, gui = "italic,bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.yellow.base },
}

local branch = {
  "branch",
  icon = "",
  color = { bg = colors.green.base, fg = colors.bg1, gui = "bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.orange.base },
}

local location = {
  "location",
  color = { bg = colors.yellow.base, fg = colors.bg1, gui = "bold" },
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.blue.base },
}

local diff = {
  "diff",
  color = { bg = colors.yellow.base, fg = colors.bg1, gui = "bold" },
  separator = { left = "|", right = "|" },
  symbols = { added = " ", modified = " ", removed = " " },
  separator_color = { fg = colors.red.base },
  diff_color = {
    added = { fg = colors.green.base },
    modified = { fg = colors.yellow.base },
    removed = { fg = colors.red.base },
  },
}

local macro = {
  function()
    return require("noice").api.status.mode.get()
  end,
  cond = function()
    return require("noice").api.status.mode.has()
  end,
  color = { fg = colors.red.base, bg = colors.fg1, gui = "italic,bold" },
  separator_color = { fg = colors.cyan.base },
}

local modes = {
  "mode",
  color = function()
    return { bg = modecolor[vim.fn.mode()], fg = colors.bg1, gui = "bold" }
  end,
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.magenta.base },
}

-- LSP name helper unchanged
local function getLspName()
  -- ... your existing getLspName implementation ...
end

local dia = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  diagnostics_color = {
    error = { fg = colors.red.base },
    warn = { fg = colors.yellow.base },
    info = { fg = colors.magenta.base },
    hint = { fg = colors.cyan.base },
  },
  color = { bg = colors.green.base, fg = colors.blue.base, gui = "bold" },
  separator = { left = "|" },
  separator_color = { fg = colors.orange.base },
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = "|", right = "|" },
  separator_color = { fg = colors.magenta.base },
  color = { bg = colors.magenta.base, fg = colors.bg1, gui = "italic,bold" },
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
        globalstatus = true,
      },
      sections = {
        lualine_a = { modes },
        lualine_b = { space },
        lualine_c = {
          filename,
          filetype,
          {
            function()
              local sc = vim.fn.searchcount({ maxcount = 9999, recompute = 1 })
              return sc.total > 0 and (" " .. sc.current .. "/" .. sc.total) or ""
            end,
            cond = function()
              return vim.fn.searchcount().total > 0
            end,
          },
          space,
          space,
        },
        lualine_x = { space },
        lualine_y = { macro, space, branch, diff },
        lualine_z = { location, lsp },
      },
      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
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
