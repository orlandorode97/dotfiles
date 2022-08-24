local wezterm = require 'wezterm'
return {
  font = wezterm.font('FiraCode Nerd Font'),
  font_size = 15,
  -- color_scheme = "PencilDark", 
  color_scheme = "DoomOne", 

  keys = {
    {
      key = 'e',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain'}
    }
  }
}
