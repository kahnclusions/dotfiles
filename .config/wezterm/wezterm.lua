-- [nfnl] wezterm.fnl
local wezterm = require("wezterm")
local function active_mode()
  if wezterm.gui then
    if wezterm.gui.get_appearance():find("Dark") then
      return "dark"
    else
      return "light"
    end
  else
    return "dark"
  end
end
local function colour_scheme(mode)
  if (mode == "light") then
    return "Oasis Lagoon Light 2"
  elseif (mode == "dark") then
    return "Oasis Lagoon Dark"
  else
    return nil
  end
end
local config = {font = wezterm.font_with_fallback({"Kahnsevka", "Symbols Nerd Font"}), max_fps = 120, animation_fps = 120, font_size = 18, force_reverse_video_cursor = true, color_scheme = colour_scheme(active_mode()), window_decorations = "RESIZE", window_padding = {left = 0, right = 0, top = 0, bottom = 0}, audible_bell = "Disabled", enable_tab_bar = true, tab_max_width = 128, hide_tab_bar_if_only_one_tab = true, tab_bar_at_bottom = true, leader = {key = "a", mods = "CTRL", timeout_milliseconds = 1000}, keys = require("keys"), debug_key_events = false, use_fancy_tab_bar = false, use_resize_increments = false}
return config
