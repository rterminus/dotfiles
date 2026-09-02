hl.config({
	decoration = {
		active_opacity = 0.8,
		inactive_opacity = 0.6,
		fullscreen_opacity = 1.0,

		blur = {
			enabled = true,
			size = 10,
			passes = 2,
      contrast = 0.9,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			noise = 0.02,
			brightness = 0.8,
			vibrancy = 0.35,
			vibrancy_darkness = 0.35,
      special = false,
			-- variant = "acrylic"
		},

		shadow = {
			enabled = true,
			range = 30,
			render_power = 3,
			color = "rgba(00000066)",
		},
	},
})
