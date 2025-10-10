local colors = require("oldworld.palette")

local extensions = require("diegoulloao.extensions.lualine")
local modecolor = {
  n = colors.red,
  i = colors.cyan,
  v = colors.purple,
  [""] = colors.purple,
  V = colors.red,
  c = colors.yellow,
  no = colors.red,
  s = colors.yellow,
  S = colors.yellow,
  [""] = colors.yellow,
  ic = colors.yellow,
  R = colors.green,
  Rv = colors.purple,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.bright_red,
}

local space = {
  function()
    return " "
  end,
  color = { bg = colors.bg_dark, fg = colors.blue },
}

local filename = {
  "filename",
  color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
}

local filetype = {
  "filetype",
  icons_enabled = false,
  color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  icon = "",
  color = { bg = colors.green, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
}

local location = {
  "location",
  color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
}

local diff = {
  "diff",
  color = { bg = colors.gray2, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
  symbols = { added = " ", modified = " ", removed = " " },

  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
}

local macro = {
  function()
    return require("noice").api.status.mode.get()
  end,
  cond = function()
    return require("noice").api.status.mode.has()
  end,
  color = { fg = colors.red, bg = colors.bg_dark, gui = "italic,bold" },
}

local modes = {
  "mode",
  color = function()
    local mode_color = modecolor
    return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
  end,
  separator = { left = "", right = "" },
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
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.purple },
    hint = { fg = colors.cyan },
  },
  color = { bg = colors.gray2, fg = colors.blue, gui = "bold" },
  separator = { left = "" },
}

local lsp = {
  function()
    return getLspName()
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.purple, fg = colors.bg, gui = "italic,bold" },
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
        theme = "catppuccin",
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
            function()
              return ""
            end,
            separator = { left = "", right = "" },
          },

          dia,
          lsp,
          location,
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

-- require custom extensions
-- local extensions = require("diegoulloao.extensions.lualine")
--
-- -- require settings
-- local settings = require("diegoulloao.settings")
--
-- -- theme
-- local get_lualine_theme = function()
--   if settings.theme == "neofusion" then
--     local lualine_neofusion = require("neofusion.lualine")
--
--     -- swap modes
--     local tmp_mode = lualine_neofusion.normal
--     lualine_neofusion.normal = lualine_neofusion.visual
--     lualine_neofusion.visual = tmp_mode
--
--     return lualine_neofusion
--   end
--
--   -- require lualine theme
--   local status, lualine_theme = pcall(require, "lualine.themes." .. settings.theme)
--   if not status then
--     return require("lualine.themes.auto")
--   end
--   --
--   -- -- export lualine theme
--   return lualine_theme
-- end
--
-- -- customized separators
-- local lualine_separators = {
--   ["rect"] = {
--     section = { left = "", right = "" },
--     component = { left = "", right = "" },
--   },
--   ["triangle"] = {
--     section = { left = "", right = "" },
--     component = { left = "", right = "" },
--   },
--   ["semitriangle"] = {
--     section = { left = "", right = "" },
--     component = { left = "", right = "" },
--   },
--   ["curve"] = {
--     section = { left = "", right = "" },
--     component = { left = "", right = "" },
--   },
-- }
--
-- -- current separator
-- local separators = lualine_separators[settings.lualine_separator]
--
-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = {
--     "folke/noice.nvim",
--     "nvim-tree/nvim-web-devicons",
--   },
--   config = function()
--     -- require noice
--     local noice = require("noice")
--
--     -- require lazy extensions
--     local lazy_status = require("lazy.status")
--
--     -- custom setup
--     require("lualine").setup({
--       options = {
--         theme = get_lualine_theme(),
--         globalstatus = true,
--         component_separators = separators.component,
--         section_separators = separators.section,
--         disabled_filetypes = { "dashboard", "packer", "help" },
--         ignore_focus = {}, -- add filetypes
--       },
--       -- man:124 for sections doc
--       sections = {
--         lualine_a = {
--           {
--             "mode",
--             icon = "",
--             separator = { left = "", right = "" },
--           },
--         },
--
--         lualine_b = {
--           {
--             "branch",
--             icon = "", -- disable icon
--             padding = { left = 1, right = 1 },
--           },
--         },
--         lualine_c = {
--           -- filetype icon
--           {
--             "filetype",
--             icon_only = true,
--             padding = { left = 2, right = 0 },
--             color = "_lualine_c_filetype",
--           },
--           -- filename
--           {
--             "filename",
--             file_status = true, -- display file status (read only, modified)
--             path = 1, -- 0: just name, 1: relative path, 2: absolute path, 3: absolute path with ~ as home directory
--             symbols = {
--               unnamed = "",
--               readonly = "",
--               modified = "",
--             },
--             padding = { left = 1 },
--             color = { gui = "bold" },
--           },
--         },
--         lualine_x = {
--           {
--             lazy_status.updates,
--             cond = lazy_status.has_updates,
--             -- color = { fg = "" },
--           },
--           -- number of changes in file
--           {
--             "diff",
--             colored = true,
--             padding = { right = 2 },
--             symbols = {
--               added = "+",
--               modified = "|",
--               removed = "-",
--             },
--           },
--           -- status like @recording
--           {
--             noice.api.statusline.mode.get,
--             cond = noice.api.statusline.mode.has,
--             -- color = { fg = "" },
--           },
--           -- "encoding",
--           -- "filetype",
--           -- "bo:filetype",
--           -- "fileformat",
--         },
--         lualine_y = {},
--         lualine_z = {
--           {
--             function()
--               return ""
--             end,
--             separator = { left = "", right = "" },
--           },
--           {
--             "searchcount",
--             color = "StatusLine",
--           },
--           {
--             "progress",
--             color = "StatusLine",
--           },
--           {
--             function()
--               return ""
--             end,
--             separator = { left = "", right = "" },
--           },
--           {
--             "location",
--             color = "StatusLine",
--           },
--           {
--             function()
--               return ""
--             end,
--             separator = { left = "", right = "" },
--           },
--         },
--       },
--       extensions = {
--         "nvim-tree",
--         "toggleterm",
--         "mason",
--         "fzf",
--         "quickfix",
--         "man",
--         "lazy",
--         extensions.telescope,
--         extensions.lspinfo,
--         extensions.saga,
--         extensions.btw,
--       },
--     })
--   end,
-- }
