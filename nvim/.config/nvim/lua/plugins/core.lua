return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "█",
					package_pending = "󰔟",
					package_uninstalled = "󰄱",
				},
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)

			local highlights = {
				"MasonHighlight",
				"MasonHighlightSecondary",
				"MasonHighlightBlockSecondary",
				"MasonHighlightBlockComplimentary",
				"MasonHeading",
				"MasonWarning",
				"MasonMuted",
			}

			for _, group in ipairs(highlights) do
				vim.api.nvim_set_hl(0, group, { link = "Normal" })
			end

			vim.api.nvim_set_hl(0, "MasonHeader", { reverse = true })
			vim.api.nvim_set_hl(0, "MasonHighlightBlock", { reverse = true })
			vim.api.nvim_set_hl(0, "MasonHighlightBlockBold", { reverse = true, bold = true })
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "harpoon: add file" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "harpoon: toggle menu" })
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = { enabled = true, view = "cmdline" },
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			messages = { enabled = true, view = "mini", view_error = "mini", view_warn = "mini" },
			routes = {
				{ filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
				{ filter = { event = "notify", find = "No items found at position" }, opts = { skip = true } },
			},
		},
		keys = { { "<leader>n", "<cmd>NoiceHistory<cr>", desc = "notification history" } },
		dependencies = { "MunifTanjim/nui.nvim" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "Avante" },
		opts = {
			file_types = { "markdown", "Avante" },

			heading = {
				sign = false,
				icons = { "█ ", "▓ ", "▒ ", "░ ", "│ ", "· " },
			},

			bullet = {
				icons = { "■", "□", "▪", "▫" },
			},

			dash = {
				icon = "─",
				width = "block",
			},

			checkbox = {
				unchecked = { icon = "[ ]" },
				checked = { icon = "[x]" },
				custom = {
					todo = { raw = "[-]", rendered = "[-]", highlight = "RenderMarkdownQuote" },
				},
			},
		},
	},
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {},
		keys = { { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "diagnostics toggle" } },
	},
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>-", "<cmd>Yazi<cr>", desc = "open yazi" },
			{ "<leader>_", "<cmd>Yazi cwd<cr>", desc = "open yazi (cwd)" },
		},
		opts = {
			opener = function(url)
				require("yazi").open(url)
			end,
		},
	},
	{ "vim-test/vim-test", keys = { { "<leader>tn", "<cmd>TestNearest<cr>" }, { "<leader>tf", "<cmd>TestFile<cr>" } } },
	{
		"preservim/vimux",
		cmd = { "VimuxRunCommand", "VimuxPromptCommand" },
		keys = { { "<leader>vp", "<cmd>VimuxPromptCommand<cr>" } },
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"bjarneo/ash.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("ash")
			local function apply_ash_adjust()
				local function inject_style(group, styles)
					local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
					if hl and not vim.tbl_isempty(hl) then
						local new_hl = vim.tbl_extend("force", hl, styles)
						vim.api.nvim_set_hl(0, group, new_hl)
					end
				end

				local bold_groups = {
					"Keyword",
					"Statement",
					"Conditional",
					"Repeat",
					"Label",
					"Function",
					"Type",
					"Structure",
					"StorageClass",
					"Operator",
					"@keyword",
					"@function",
					"@function.method",
					"@function.call",
					"@type",
					"@module",
					"@namespace",
					"@constructor",
					"Directory",
					"Title",
				}
				local italic_groups = { "Comment", "String", "@comment", "@string" }

				for _, g in ipairs(bold_groups) do
					inject_style(g, { bold = true })
				end
				for _, g in ipairs(italic_groups) do
					inject_style(g, { italic = true })
				end
				inject_style("@type.builtin", { bold = true, italic = true })

				local fg_main, fg_dim, fg_dark, bg_status, bg_none, black, bg_hl =
					"#C6C6C6", "#707070", "#3A3A3A", "#151515", "none", "#030303", "#1A1A1A"

				local manual_overrides = {
					Normal = { bg = bg_none },
					NormalNC = { bg = bg_none },
					LineNr = { fg = fg_dark, bg = bg_none },
					SignColumn = { bg = bg_none },
					EndOfBuffer = { bg = bg_none },
					VertSplit = { fg = fg_dark, bg = bg_none },
					WinSeparator = { fg = fg_dark, bg = bg_none },
					Folded = { fg = fg_dim, bg = bg_none, italic = true },
					NonText = { fg = fg_dark, bg = bg_none },
					NormalFloat = { bg = bg_none },
					FloatBorder = { fg = fg_dark, bg = bg_none },
					TelescopeBorder = { fg = fg_dark, bg = bg_none },
					TelescopePromptBorder = { fg = fg_dim, bg = bg_none },
					TelescopeTitle = { fg = black, bg = fg_main, bold = true },
					TelescopeSelection = { fg = fg_main, bg = bg_hl, bold = true },
					Search = { fg = fg_main, bg = fg_dark, bold = true },
					IncSearch = { fg = black, bg = fg_main, bold = true },
					CurSearch = { fg = black, bg = fg_main, bold = true },
					MatchParen = { fg = fg_main, bg = fg_dark, bold = true },
					SnacksPickerSelected = { bg = bg_hl, bold = true },
					SnacksPickerCursorLine = { bg = bg_hl },
					Visual = { bg = "#2A2A2A" },
					["@markup.link.url"] = { fg = fg_dim, underline = true },
					GitSignsAdd = { fg = fg_dim, bg = bg_none },
					GitSignsChange = { fg = fg_dim, bg = bg_none },
					GitSignsDelete = { fg = fg_dark, bg = bg_none },
					MiniStatuslineModeNormal = { fg = black, bg = fg_main, bold = true },
					MiniStatuslineModeInsert = { fg = black, bg = "#999999", bold = true },
					MiniStatuslineModeVisual = { fg = black, bg = "#666666", bold = true },
					MiniStatuslineModeReplace = { fg = black, bg = fg_dark, bold = true },
					MiniStatuslineModeCommand = { fg = black, bg = fg_main, bold = true },
					MiniStatuslineFilename = { fg = fg_main, bg = bg_status },
					MiniStatuslineDevinfo = { fg = fg_dim, bg = bg_status },
					MiniStatuslineFileinfo = { fg = fg_dim, bg = bg_status },
					MiniStatuslineInactive = { fg = fg_dark, bg = bg_none },
					StatusLine = { bg = bg_none, fg = fg_dim },
					StatusLineNC = { bg = bg_none, fg = fg_dark },
					DiagnosticWarn = { fg = fg_dim, bg = bg_none },
					DiagnosticInfo = { fg = fg_dim, bg = bg_none },
					SnacksDashboardHeader = { link = "Comment" },
					SnacksPickerFile = { fg = fg_main, bg = bg_none },
					SnacksPickerDir = { fg = fg_dim, bg = bg_none },
					SnacksPickerDiagnosticWarn = { fg = fg_dim, bg = bg_none },
					SnacksPickerDiagnosticInfo = { fg = fg_dim, bg = bg_none },
					TroubleNormal = { bg = bg_none },
					TroubleText = { fg = fg_dim },
					qfFileName = { fg = fg_dim, bg = bg_none, bold = true },
					qfLineNr = { fg = fg_dim, bg = bg_none },
					qfSeparator = { fg = fg_dark, bg = bg_none },
					QuickFixLine = { bg = "#2A2A2A", bold = true },
					Directory = { fg = fg_dim, bg = bg_none },
					Pmenu = { bg = "#111111", fg = "#999999" },
					PmenuSel = { bg = "#3A3A3A", bold = true },
					BlinkCmpMenu = { link = "Pmenu" },
					BlinkCmpMenuSelection = { link = "PmenuSel" },
					BlinkCmpMenuBorder = { fg = "#333333", bg = "#111111" },
					BlinkCmpLabelMatch = { fg = "#FFFFFF", bold = true },
					BlinkCmpDoc = { link = "Pmenu" },
					BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
					BlinkCmpSignatureHelp = { link = "Pmenu" },
					BlinkCmpSignatureHelpBorder = { link = "BlinkCmpMenuBorder" },
					RenderMarkdownH1Bg = { bg = bg_none, fg = fg_main, bold = true },
					RenderMarkdownH2Bg = { bg = bg_none, fg = fg_main, bold = true },
					RenderMarkdownH3Bg = { bg = bg_none, fg = fg_main, bold = true },
					RenderMarkdownH4Bg = { bg = bg_none, fg = fg_dim, bold = true },
					RenderMarkdownH5Bg = { bg = bg_none, fg = fg_dim, bold = true },
					RenderMarkdownH6Bg = { bg = bg_none, fg = fg_dim, bold = true },
					RenderMarkdownH1 = { link = "RenderMarkdownH1Bg" },
					RenderMarkdownH2 = { link = "RenderMarkdownH2Bg" },
					RenderMarkdownH3 = { link = "RenderMarkdownH3Bg" },
					RenderMarkdownH4 = { link = "RenderMarkdownH4Bg" },
					RenderMarkdownH5 = { link = "RenderMarkdownH5Bg" },
					RenderMarkdownH6 = { link = "RenderMarkdownH6Bg" },
					RenderMarkdownCode = { bg = bg_status },
					RenderMarkdownCodeInline = { bg = bg_hl, fg = fg_main },
					RenderMarkdownQuote = { fg = fg_dim, italic = true },
					RenderMarkdownDash = { fg = fg_dark },
					RenderMarkdownBullet = { fg = fg_dim },
					RenderMarkdownLink = { fg = fg_dim, underline = true },
				}

				for grp, st in pairs(manual_overrides) do
					vim.api.nvim_set_hl(0, grp, st)
				end
			end

			apply_ash_adjust()
			vim.api.nvim_create_autocmd("ColorScheme", { pattern = "ash", callback = apply_ash_adjust })
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		config = function()
			require("nvim-autopairs").setup({})
			local Rule = require("nvim-autopairs.rule")
			require("nvim-autopairs").add_rules({
				Rule(" ", " ")
					:with_pair(function(opts)
						local pair = opts.line:sub(opts.col - 1, opts.col)
						return vim.tbl_contains({ "()", "[]", "{}" }, pair)
					end)
					:with_move(function(opts)
						return opts.prev_char == " "
					end)
					:with_del(function(opts)
						local pair = opts.line:sub(opts.col - 2, opts.col + 1)
						return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, pair)
					end),
			})
		end,
	},
	{
		"lukas-reineke/virt-column.nvim",
		config = function()
			require("virt-column").setup({ char = "│" })
			vim.api.nvim_set_hl(0, "VirtColumn", { fg = "#4C4C4C", default = false })
		end,
	},
	{
		"m4xshen/smartcolumn.nvim",
		opts = {
			colorcolumn = "100",
			disabled_filetypes = { "help", "text", "markdown", "lazy", "mason", "neo-tree", "TelescopePrompt" },
			scope = "window",
		},
	},
	{
		"tpope/vim-projectionist",
		config = function()
			vim.g.projectionist_heuristics = {
				["*"] = {
					["src/*.cpp"] = { alternate = "include/{}.hpp", type = "source" },
					["include/*.hpp"] = { alternate = "src/{}.cpp", type = "header" },
					["*.cpp"] = { alternate = "{}.hpp", type = "source" },
					["*.hpp"] = { alternate = "{}.cpp", type = "header" },
				},
			}
		end,
	},
	{
		"ukonhattu/tmc.vim",
		cmd = { "TmcLogin", "TmcPickCourse", "TmcRunTests", "TmcSubmit" },
		init = function()
			vim.g.tmc_cli_path = "/usr/local/bin/tmc-langs-cli"
		end,
		keys = {
			{ "<leader>tt", ":TmcRunTests<CR>", desc = "tmc: run tests" },
			{ "<leader>ts", ":TmcSubmit<CR>", desc = "tmc: submit solution" },
		},
	},
	{ "mfussenegger/nvim-jdtls", ft = "java" },
	"ThePrimeagen/vim-be-good",
	{ "brianhuster/live-preview.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	{ "stevearc/dressing.nvim", opts = {} },
	{ "mbbill/undotree", keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "undotree reveal" } } },
	{
		"brenoprata10/nvim-highlight-colors",
		opts = { render = "background", enable_named_colors = true, enable_tailwind = true },
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{
		"Julian/lean.nvim",
		event = { "BufReadPre *.lean", "BufNewFile *.lean" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"Saghen/blink.cmp",
			"nvim-telescope/telescope.nvim",
			"andymass/vim-matchup",
			"andrewradev/switch.vim",
			"tomtom/tcomment_vim",
		},
		opts = { mappings = true },
	},
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"stevearc/aerial.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "man" },
				icons = {
					Class = " ",
					Constructor = " ",
					Enum = " ",
					Field = " ",
					Function = "󰊕 ",
					Interface = " ",
					Method = "󰆧 ",
					Module = "󰏗 ",
					Namespace = " ",
					Struct = "󰙅 ",
				},
				filter_kind = {
					"Class",
					"Constructor",
					"Enum",
					"Field",
					"Function",
					"Interface",
					"Method",
					"Module",
					"Namespace",
					"Struct",
				},
				layout = { default_direction = "left", max_width = { 40, 0.25 }, min_width = 20 },
				close_on_select = true,
				show_guides = true,
				keymaps = { ["<CR>"] = "actions.jump", ["p"] = "actions.scroll", ["q"] = "actions.close" },
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Prev Function" })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Next Function" })
				end,
			})
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "toggle aerial" })
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "AerialConstructorIcon", { fg = "#eeeeee", bold = true })
					vim.api.nvim_set_hl(0, "AerialFunctionIcon", { fg = "#4C4C4C" })
					vim.api.nvim_set_hl(0, "AerialMethodIcon", { fg = "#4C4C4C" })
				end,
			})
		end,
	},
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local devicons = require("nvim-web-devicons")
			local icons_by_extension, icons_by_filename = devicons.get_icons(), devicons.get_icons_by_filename()

			local function desaturate_hex(hex)
				if not hex or hex == "" then
					return "#888888"
				end
				hex = hex:gsub("#", "")
				local r, g, b =
					tonumber(hex:sub(1, 2), 16) or 0, tonumber(hex:sub(3, 4), 16) or 0, tonumber(hex:sub(5, 6), 16) or 0
				local lum = math.floor(0.299 * r + 0.587 * g + 0.114 * b)
				return string.format("#%02x%02x%02x", lum, lum, lum)
			end

			local custom_overrides, custom_overrides_ext = {}, {}
			if icons_by_filename then
				for key, data in pairs(icons_by_filename) do
					custom_overrides[key] = { icon = data.icon, color = desaturate_hex(data.color), name = data.name }
				end
			end
			if icons_by_extension then
				for key, data in pairs(icons_by_extension) do
					custom_overrides_ext[key] =
						{ icon = data.icon, color = desaturate_hex(data.color), name = data.name }
				end
			end

			devicons.setup({
				color_icons = true,
				override = custom_overrides,
				override_by_extension = custom_overrides_ext,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				multiwindow = false,
				max_lines = 0,
				min_window_height = 0,
				line_numbers = true,
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = nil,
			})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>H", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown() } },
			})
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(
					require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
				)
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
					map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
					map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd(
							{ "CursorHold", "CursorHoldI" },
							{ buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.document_highlight }
						)
						vim.api.nvim_create_autocmd(
							{ "CursorMoved", "CursorMovedI" },
							{ buffer = event.buf, group = highlight_augroup, callback = vim.lsp.buf.clear_references }
						)
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local servers = {
				astro = {},
				clangd = {},
				ts_ls = {},
				html = {},
				cssls = {},
				tailwindcss = {},
				emmet_ls = {
					filetypes = {
						"css",
						"eruby",
						"html",
						"javascript",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"svelte",
						"pug",
						"typescriptreact",
						"vue",
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
							diagnostics = { globals = { "vim", "Snacks" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, { "stylua", "prettierd", "markdownlint", "codelldb" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return { timeout_ms = 500, lsp_format = "fallback" }
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				astro = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "folke/lazydev.nvim" },
		opts_extend = { "sources.default" },
		config = function()
			local custom_icons = {
				Class = " ",
				Constructor = " ",
				Enum = " ",
				Field = " ",
				Function = "󰊕 ",
				Interface = " ",
				Method = "󰆧 ",
				Module = "󰏗 ",
				Namespace = " ",
				Struct = "󰙅 ",
				Property = " ",
				Variable = "󰀫 ",
				Snippet = " ",
				Keyword = "󰌋 ",
				Text = "󰉿 ",
			}
			require("blink.cmp").setup({
				keymap = { preset = "default" },
				appearance = { nerd_font_variant = "mono", kind_icons = custom_icons },
				completion = {
					documentation = { auto_show = true, auto_show_delay_ms = 500 },
					ghost_text = { enabled = true },
					menu = {
						draw = {
							components = {
								kind_icon = {
									text = function(ctx)
										local icon = custom_icons[ctx.kind] or ctx.kind_icon
										if ctx.item.source_name == "LSP" and ctx.item.documentation then
											local color_item = require("nvim-highlight-colors").format(
												ctx.item.documentation,
												{ kind = ctx.kind }
											)
											if color_item and color_item.abbr and color_item.abbr ~= "" then
												icon = color_item.abbr
											end
										end
										return icon .. ctx.icon_gap
									end,
									highlight = function(ctx)
										local highlight = "BlinkCmpKind" .. ctx.kind
										if ctx.item.source_name == "LSP" and ctx.item.documentation then
											local color_item = require("nvim-highlight-colors").format(
												ctx.item.documentation,
												{ kind = ctx.kind }
											)
											if color_item and color_item.abbr_hl_group then
												highlight = color_item.abbr_hl_group
											end
										end
										return highlight
									end,
								},
							},
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "lazydev", "buffer", "obsidian" },
					providers = {
						lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
						obsidian = { name = "obsidian", module = "blink.compat.source" },
					},
				},
				cmdline = {
					enabled = true,
					keymap = { preset = "cmdline" },
					sources = function()
						local type = vim.fn.getcmdtype()
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						if type == ":" then
							return { "cmdline" }
						end
						return {}
					end,
				},
				snippets = { preset = "default" },
				fuzzy = { implementation = "lua" },
				signature = { enabled = true },
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			require("mini.ai").setup({ n_lines = 500 })
			require("mini.surround").setup()
			require("mini.move").setup({
				mappings = {
					left = "<C-M-h>",
					right = "<C-M-l>",
					down = "<C-M-j>",
					up = "<C-M-k>",
					line_left = "<C-M-h>",
					line_right = "<C-M-l>",
					line_down = "<C-M-j>",
					line_up = "<C-M-k>",
				},
				options = { reindent_linewise = true },
			})
			require("mini.files").setup({
				windows = { width_focus = 30, width_nofocus = 15 },
				options = { use_as_default_explorer = true },
			})
			vim.keymap.set("n", "<leader>e", function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0))
			end, { desc = "Open mini.files (current file)" })
			vim.keymap.set("n", "<leader>E", function()
				require("mini.files").open()
			end, { desc = "Open mini.files (cwd)" })
			local statusline = require("mini.statusline")
			statusline.setup({
				use_icons = vim.g.have_nerd_font,
				content = {
					active = function()
						local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
						mode = mode and mode:sub(1, 1):lower() or ""
						local git = vim.b.gitsigns_head and (" " .. vim.b.gitsigns_head) or ""
						local git_dict = vim.b.gitsigns_status_dict
						if git_dict then
							local diffs = {}
							if git_dict.added and git_dict.added > 0 then
								table.insert(diffs, "+" .. git_dict.added)
							end
							if git_dict.changed and git_dict.changed > 0 then
								table.insert(diffs, "~" .. git_dict.changed)
							end
							if git_dict.removed and git_dict.removed > 0 then
								table.insert(diffs, "-" .. git_dict.removed)
							end
							if #diffs > 0 then
								git = git .. "  " .. table.concat(diffs, " ")
							end
						end
						local diagnostics = MiniStatusline.section_diagnostics({
							trunc_width = 75,
							icon = "",
							signs = { ERROR = "󰅚 ", WARN = "󰀪 ", INFO = "󰋽 ", HINT = "󰌶 " },
						})
						local filename = MiniStatusline.section_filename({ trunc_width = 140 })
						local fileinfo = vim.bo.filetype
						if vim.g.have_nerd_font and fileinfo ~= "" then
							local devicons = require("nvim-web-devicons")
							local icon =
								devicons.get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
							if icon then
								fileinfo = icon .. " " .. fileinfo
							end
						end
						local location = "%2l:%-2v"
						local function get_harpoon_marks()
							local ok, harpoon = pcall(require, "harpoon")
							if not ok then
								return ""
							end

							local list = harpoon:list()
							if list:length() == 0 then
								return ""
							end

							local current_file = vim.api.nvim_buf_get_name(0)
							local marks = {}

							for i = 1, list:length() do
								local item = list:get(i)
								if item and item.value then
									local is_current = current_file:find(item.value, 1, true) ~= nil
									if is_current then
										table.insert(marks, "[" .. i .. "]")
									else
										table.insert(marks, tostring(i))
									end
								end
							end

							return table.concat(marks, " ")
						end
						local harpoon_status = get_harpoon_marks()

						return MiniStatusline.combine_groups({
							{ hl = mode_hl, strings = { mode } },
							{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
							"%<",
							{ hl = "MiniStatuslineFilename", strings = { harpoon_status, filename } },
							"%=",
							{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
							{ hl = mode_hl, strings = { location } },
						})
					end,
				},
			})
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter").setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"css",
					"diff",
					"doxygen",
					"html",
					"javascript",
					"lua",
					"luadoc",
					"markdown",
					"markdown_inline",
					"query",
					"vim",
					"vimdoc",
				},
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = { "ruby" } },
				indent = { enable = false },
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<F1>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F2>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F3>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>bb",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>bB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			{
				"<F7>",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: See last session result.",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("mason-nvim-dap").setup({
				automatic_installation = true,
				handlers = {},
				ensure_installed = { "codelldb" },
			})

			---@diagnostic disable-next-line: missing-fields
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				---@diagnostic disable-next-line: missing-fields
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			vim.api.nvim_set_hl(0, "DapBreak", { fg = "#C6C6C6", bg = "#2A2A2A", bold = true })
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreak", linehl = "", numhl = "" })
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = { char = "│", tab_char = "│" },
			scope = { enabled = false },
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
			}

			local markdownlint = lint.linters.markdownlint
			vim.list_extend(markdownlint.args, {
				-- "--disable",
				-- "MD013",
				-- "MD025",
				-- "MD034",
			})

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
	{
		"3rd/image.nvim",
		-- dependencies = { { "vhyrro/luarocks.nvim", priority = 1001, opts = { rocks = { "magick" } } } },
		config = function()
			require("image").setup({
				backend = "kitty",
				kitty_method = "normal",
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "markdown", "vimwiki" },
					},
					neorg = { enabled = true },
					html = { enabled = false },
					css = { enabled = false },
				},
				max_width = nil,
				max_height = nil,
				max_width_window_percentage = nil,
				max_height_window_percentage = 50,
				window_overlap_clear_enabled = true,
				window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
				editor_only_render_when_focused = false,
				tmux_show_only_in_active_window = true,
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = {
				preset = {
					header = [[
the coal, the coal light, the callus, the caress
the comb, the calm, the colours, cortex
the code, the codeine, comma, context
collector, the green
the fine, the fall, the financier, the dream
fen, the fine, fin, defend, fawn
then do

coal, coal light, the colours, the caress
comb, the calm, the colours, the cortex
code, the codeine, the comma, context

the corpse, the likeness
die, cut, die, cut
die, cut, die, cut
die, cut, die, cut
die
        ]],
					keys = {
						{ icon = "", key = "f", desc = "find file", action = ":lua Snacks.picker.files()" },
						{ icon = "", key = "t", desc = "find text", action = ":lua Snacks.picker.grep()" },
						{
							icon = "",
							key = "c",
							desc = "config",
							action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
						},
						{
							icon = "",
							key = "o",
							desc = "open obsidian",
							action = ":e /home/terminus/Documents/terminus-obs/00\\ -\\ index/dashboard.md",
						},
						{ icon = "", key = "q", desc = "quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header", padding = 2, align = "left" },
					{ section = "keys", gap = 1, padding = 1, align = "right" },
					-- { section = 'startup', padding = 1 },
				},
			},
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = false, timeout = 3000 },
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = true },
		},
		keys = {
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "dismiss all notifications",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "git browse",
			},
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log_file()
				end,
				desc = "lazygit current file",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "lazygit log",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "rename file",
			},
			{
				"<c-\\>",
				function()
					Snacks.terminal()
				end,
				desc = "toggle terminal",
			},
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = true,
		event = {
			"BufReadPre ~/Documents/terminus-obs/**.md",
			"BufNewFile ~/Documents/terminus-obs/**.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "brain",
					path = "~/Documents/terminus-obs",
				},
			},

			notes_subdir = "50 - fleeting",
			new_notes_location = "notes_subdir",
			wiki_link_func = "use_alias_only",

			templates = {
				folder = "99 - meta/templates",
				date_format = "%Y-%m-%d",
				time_format = "%H:%M",
			},

			attachments = {
				img_folder = "99 - meta/attachments",
			},

			ui = { enable = false },

			picker = { name = "telescope.nvim" },

			mappings = {},
		},
		keys = {
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "new note" },
			{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "search notes" },
			{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "open in app" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "backlinks" },
			{ "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "paste image" },
			{
				"<leader>oh",
				"<cmd>e /home/terminus/Documents/terminus-obs/00\\ -\\ index/dashboard.md<cr>",
				desc = "open dashboard",
			},
			{ "<CR>", "<cmd>ObsidianFollowLink<cr>", desc = "follow link", ft = "markdown" },
		},
	},
}
