local wezterm = require("wezterm")

local mykeys = {
	{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "Tab", mods = "SHIFT|CTRL", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
}

for i = 1, 8 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action({ ActivateTab = i - 1 }),
	})
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return require("themes.rose-pine.rose-pine").colors()
	else
		return require("themes.rose-pine.rose-pine-dawn").colors()
	end
end

return {
	font = wezterm.font_with_fallback({
		"Pragmasevka",
		"Symbols Nerd Font",
	}),
	font_size = 16.0,
	force_reverse_video_cursor = false,
	debug_key_events = true,
	colors = scheme_for_appearance(get_appearance()),
	window_decorations = "RESIZE",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	audible_bell = "Disabled",
	-- Tab bar
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	tab_max_width = 64,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_resize_increments = false,
	-- Keyboard mapping
	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = mykeys,
	-- window_background_opacity = 1,
	-- macos_window_background_blur = 30,
}
