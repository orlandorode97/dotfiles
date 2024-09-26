-- settings
local settings = require("diegoulloao.settings")

-- fidget
return {
  "j-hui/fidget.nvim",
  version = "legacy",
  enabled = false,
  opts = {
    text = {
      spinner = "star", -- dots | line | dots_scrolling | stari
    },
    window = {
      border = "rounded", -- single | double | shadow | rounded
      blend = settings.transparent_mode and 0 or 100, -- support for transparent background
    },
    notification = {
      window = {
        normal_hl = "MsgArea",
      },
    },
    sources = {
      ["null-ls"] = {
        ignore = true,
      },
    },
  },
}
