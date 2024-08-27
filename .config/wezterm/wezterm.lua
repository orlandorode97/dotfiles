local wezterm = require("wezterm")
local keys = require("keys")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = true

config.max_fps = 120
config.enable_wayland = false
config.warn_about_missing_glyphs = false
config.show_update_window = false
config.check_for_updates = false
-- Color palette for the backgrounds of each cell
config.default_cursor_style = "SteadyUnderline"
config.line_height = 1
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = keys

config.launch_menu = {
  { args = { "top" } },
  { args = { "nvim", "." } },
}
require("tabline")

return config
