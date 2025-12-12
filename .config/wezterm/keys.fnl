(local wezterm (require :wezterm))
(local keys [{ :key "-" :mods "LEADER" :action (wezterm.action { :SplitVertical { :domain "CurrentPaneDomain" } }) }
	          { :key "\\" :mods "LEADER" :action (wezterm.action { :SplitHorizontal { :domain "CurrentPaneDomain" } }) }
	          { :key "z" :mods "LEADER" :action "TogglePaneZoomState" }
	          { :key "c" :mods "LEADER" :action (wezterm.action { :SpawnTab "CurrentPaneDomain" }) }
	          { :key "Tab" :mods "CTRL" :action (wezterm.action { :ActivateTabRelative 1 }) }
	          { :key "Tab" :mods "SHIFT|CTRL" :action (wezterm.action { :ActivateTabRelative -1 }) }
	          { :key "n" :mods "LEADER" :action (wezterm.action { :ActivateTabRelative 1 }) }
	          { :key "p" :mods "LEADER" :action (wezterm.action { :ActivateTabRelative -1 }) }
	          { :key "r" :mods "CMD|SHIFT" :action wezterm.action.ReloadConfiguration }])

(for [i 1 8] 
   (table.insert keys 
      { :key (tostring i) :mods "LEADER" :action (wezterm.action { :ActivateTab (- i 1) }) }))

keys
