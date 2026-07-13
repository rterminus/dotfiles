require("config.options")
require("config.keymaps")
require("config.autocmds")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = { import = "plugins" },
	rocks = { enabled = false },
	defaults = { lazy = false },
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

vim.treesitter.language.register("markdown", "telekasten")
local zettel_home = vim.fn.expand("~/second-brain")

require("telekasten").setup({
	home = zettel_home,

	dailies = zettel_home .. "/50-periodic/daily",
	weeklies = zettel_home .. "/50-periodic/weekly",
	templates = zettel_home .. "/99-meta/templates",

	image_subdir = zettel_home .. "/99-meta/attachments",

	command_palette_theme = "ivy",
	show_tags_theme = "ivy",

	extension = ".md",
	new_note_location = "smart",

	template_new_note = zettel_home .. "/99-meta/templates/new_note.md",
	template_new_daily = zettel_home .. "/99-meta/templates/daily.md",
	template_new_weekly = zettel_home .. "/99-meta/templates/weekly.md",
})
