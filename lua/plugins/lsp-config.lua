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
				"typos_lsp",
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
				"pyright",
				"sqls",
				"yamlls",
				"gitlab_ci_ls",
				"svelte",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local opts = { capabilities = capabilities }
			lspconfig.lua_ls.setup(opts)
			lspconfig.typos_lsp.setup({
				capabilities = capabilities,
				init_options = {
					config = "~/.typos.toml",
				},
			})
			lspconfig.clangd.setup(opts)
			lspconfig.unocss.setup(opts)
			lspconfig.dockerls.setup(opts)
			lspconfig.docker_compose_language_service.setup(opts)
			lspconfig.eslint.setup(opts)
			lspconfig.html.setup(opts)
			lspconfig.jsonls.setup(opts)
			lspconfig.jdtls.setup({
				capabilities = capabilities,
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
			lspconfig.ts_ls.setup(opts)
			lspconfig.marksman.setup(opts)
			lspconfig.intelephense.setup(opts)
			lspconfig.ruff.setup(opts)
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
						},
					},
				},
			})
			lspconfig.sqls.setup(opts)
			lspconfig.yamlls.setup(opts)
			lspconfig.gitlab_ci_ls.setup(opts)
			lspconfig.rust_analyzer.setup(opts)
			lspconfig.svelte.setup(opts)
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
