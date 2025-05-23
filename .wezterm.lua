local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Tomorrow Night (Gogh)"
config.font_size = 14.0
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
-- Make bold a little bolder
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	},
}

local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

config.keys = {
	{
		key = "E",
		mods = "CTRL",
		action = wezterm.action.QuickSelectArgs({
			label = "open url",
			patterns = {
				"https?://\\S+",
			},
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				wezterm.log_info("opening: " .. url)
				wezterm.open_with(url)
			end),
		}),
	},
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
