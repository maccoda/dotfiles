local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Gruvbox Dark (Gogh)'
config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.keys = {
  {
    key = 'E',
    mods = 'CTRL',
    action = wezterm.action.QuickSelectArgs {
      label = 'open url',
      patterns = {
        'https?://\\S+',
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(url)
      end),
    },
  },
}


return config
