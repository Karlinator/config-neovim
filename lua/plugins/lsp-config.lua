return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"clangd",
				"unocss",
				"dockerls",
				"docker_compose_language_service",
				"eslint",
				"html",
				"jsonls",
				"jdtls",
				"ts_ls",
				"marksman",
				"intelephense",
				"ruff",
				"basedpyright",
				"sqls",
				"yamlls",
				"gitlab_ci_ls",
				"svelte",
			},
		},
		init = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfic = require("mason-lspconfig")
			mason_lspconfic.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["jdtls"] = function()
					lspconfig.jdtls.setup({
						settings = {
							java = {
								project = {
									referencedLibraries = {
										"lib/*",
										"/usr/share/java/*",
										"/usr/share/java/*/*",
									},
								},
							},
						},
					})
				end,
				["basedpyright"] = function()
					lspconfig.basedpyright.setup({
						settings = {
							basedpyright = {
								-- Using Ruff's import organizer
								disableOrganizeImports = true,
								autoImportCompletions = true,
								analysis = {
									-- Use mypy for type checking
									typeCheckingMode = "off",
								},
							},
						},
					})
				end,
				-- ["svelte"] = function()
				-- lspconfig.svelte.setup({
				-- 	capabilities = {
				-- 		workspace = {
				-- 			didChangeWatchedFiles = false,
				-- 		},
				-- 	},
				-- 	filetypes = { "svelte" },
				-- 	on_attach = function(client, bufnr)
				-- 		if client.name == "svelte" then
				-- 			vim.api.nvim_create_autocmd("BufWritePost", {
				-- 				pattern = { "*.js", "*.ts", "*.svelte" },
				--                 group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
				-- 				callback = function(ctx)
				-- 					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				-- 				end,
				-- 			})
				-- 		end
				-- 		if vim.bo[bufnr].filetype == "svelte" then
				-- 			vim.api.nvim_create_autocmd("BufWritePost", {
				-- 				pattern = { "*.js", "*.ts", "*.svelte" },
				-- 				callback = function(ctx)
				-- 					client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
				-- 				end,
				-- 			})
				-- 		end
				-- 	end,
				-- })
				-- end
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
			-- This is an extremely stupid workaround. It restarts the whole svelte language server every time I save a page ts file.
			-- Without this the language server just never catches the updated generated types, because the file watcher doesn't work.
			-- No other workaround I've tried has worked.
			vim.api.nvim_create_autocmd({ "BufWrite" }, {
				pattern = { "+page.server.ts", "+page.ts", "+layout.server.ts", "+layout.ts" },
				command = "LspRestart svelte",
			})

			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.gitlab-ci*.{yml,yaml}",
				callback = function()
					vim.bo.filetype = "yaml.gitlab"
				end,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
