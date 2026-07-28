hl.config({
	decoration = {
		active_opacity = 0.8,
		inactive_opacity = 0.6,
		fullscreen_opacity = 1.0,

		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			noise = 0.02,
			contrast = 0.9,
			brightness = 0.9,
			vibrancy = 0.2,
			vibrancy_darkness = 0.0,
		},

		shadow = {
			enabled = true,
			range = 30,
			render_power = 3,
			color = "rgba(00000066)",
		},
	},
})
