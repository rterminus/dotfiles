local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
	return
end

local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path = mason_path .. "/jdtls"
local java_debug_path = mason_path .. "/java-debug-adapter"
local java_test_path = mason_path .. "/java-test"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

local bundles = {
	vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", true), "\n"))

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.inlayHint = { dynamicRegistration = true }
local capabilities = require("blink.cmp").get_lsp_capabilities(client_capabilities)

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",

		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. jdtls_path .. "/lombok.jar",

		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_linux",

		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	capabilities = capabilities,

	settings = {
		java = {
			inlayHints = {
				parameterNames = {
					enabled = "all",
				},
			},
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			completion = {
				favoriteStaticMembers = {
					"org.junit.jupiter.api.Assertions.*",
					"org.mockito.Mockito.*",
				},
				importOrder = { "java", "javax", "com", "org" },
			},
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},
		},
	},

	init_options = {
		bundles = bundles,
		extendedClientCapabilities = extendedClientCapabilities,
	},
}

config.on_attach = function(client, bufnr)
	jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })

	require("jdtls.dap").setup_dap_main_class_configs()

	client.server_capabilities.inlayHintProvider = true
	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

	local function map(mode, keys, func, desc)
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Java: " .. desc })
	end

	map("n", "<leader>th", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
	end, "[T]oggle Inlay [H]ints")

	map("n", "<leader>co", jdtls.organize_imports, "[C]ode [O]rganize Imports")
	map("n", "<leader>cv", jdtls.extract_variable, "[C]ode Extract [V]ariable")
	map("v", "<leader>cv", function()
		jdtls.extract_variable({ visual = true })
	end, "[C]ode Extract [V]ariable")
	map("n", "<leader>cc", jdtls.extract_constant, "[C]ode Extract [C]onstant")
	map("v", "<leader>cc", function()
		jdtls.extract_constant({ visual = true })
	end, "[C]ode Extract [C]onstant")
	map("v", "<leader>cm", function()
		jdtls.extract_method({ visual = true })
	end, "[C]ode Extract [M]ethod")

	map("n", "<leader>tc", jdtls.test_class, "[T]est [C]lass")
	map("n", "<leader>tm", jdtls.test_nearest_method, "[T]est [M]ethod")
end

jdtls.start_or_attach(config)
