local wezterm = require("wezterm")

return {
  {
    key = "e",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  -- Shift + Fn + Up Arrow (PageUp)
  { key = "UpArrow",   mods = "SHIFT|CTRL", action = wezterm.action.ScrollToTop },

  -- Shift + Fn + Down Arrow (PageDown)
  { key = "DownArrow", mods = "SHIFT|CTRL", action = wezterm.action.ScrollToBottom },
  {
    key = "d",
    mods = "CMD",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane({ confirm = false }),
  },
  { key = "F11", mods = "",    action = wezterm.action.ToggleFullScreen },
  { key = "y",   mods = "CMD", action = wezterm.action.EmitEvent("toggle-colorscheme") },
}
