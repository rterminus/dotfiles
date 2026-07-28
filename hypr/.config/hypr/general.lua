hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(444444ee)", "rgba(111111ee)" }, angle = 45 },
			inactive_border = "rgba(111111ee)",
		},
		layout = "dwindle",
	},
	dwindle = { preserve_split = true },
	cursor = { enable_hyprcursor = true, sync_gsettings_theme = true },
	render = { direct_scanout = false },
	misc = { disable_hyprland_logo = true, force_default_wallpaper = 0 },
})
