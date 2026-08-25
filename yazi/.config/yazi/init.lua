require("starship"):setup()

-- require("auto-layout"):setup()

require("yaziline"):setup({
	separator_style = "empty",
	color = "#888888",
	secondary_color = "#1a1a1a",
	default_files_color = "#4c4c4c",
	selected_files_color = "#eeeeee",
	yanked_files_color = "#D6D6D6",
	cut_files_color = "#030303",
})

function Status:render()
	local left = self:children_render(self.LEFT)
	local right = self:children_render(self.RIGHT)
	return {
		ui.Line({ left, ui.Span("  │  "), right }),
	}
end
