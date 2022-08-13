local wezterm = require 'wezterm'
return {
  font = wezterm.font('FiraCode Nerd Font', { weight = 'Bold'}),
  font_size = 15,
  color_scheme = 'nightfox',
  keys = {
    {
      key = 'e',
      mods = 'CTRL',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain'}
    }
  }
}
