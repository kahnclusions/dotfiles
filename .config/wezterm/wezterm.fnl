(local wezterm (require :wezterm))

(fn active-mode [] 
  "Get current light/dark mode"
  (if wezterm.gui 
        (if (: (wezterm.gui.get_appearance) :find "Dark")
            :dark
            :light)
      :dark))

(fn colour-scheme [mode] 
  "Get colour scheme for active appearance"
  (case mode
      :light "Oasis Lagoon Light 2"
      :dark "Oasis Lagoon Dark"))

(local config {
   :font (wezterm.font_with_fallback ["Kahnsevka" "Symbols Nerd Font"])
   :max_fps 120
   :animation_fps 120
   :font_size 18.0
   :force_reverse_video_cursor true
   :debug_key_events false
   :color_scheme (colour-scheme (active-mode))
   :window_decorations "RESIZE"
   :window_padding { :left 0 :right 0 :top 0 :bottom 0 }
   :audible_bell "Disabled"
   :enable_tab_bar true
   :use_fancy_tab_bar false
   :tab_max_width 128
   :hide_tab_bar_if_only_one_tab true
   :tab_bar_at_bottom true
   :use_resize_increments false
   :leader { :key "a" :mods "CTRL" :timeout_milliseconds 1000 }
   :keys (require :keys)
})

config
