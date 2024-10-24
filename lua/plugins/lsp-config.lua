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
				"vtsls",
				"marksman",
				"intelephense",
				"ruff_lsp",
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
							},
						},
					},
				},
			})
			lspconfig.vtsls.setup(opts)
			lspconfig.marksman.setup(opts)
			lspconfig.intelephense.setup(opts)
			lspconfig.ruff_lsp.setup(opts)
			lspconfig.pyright.setup(opts)
			lspconfig.sqls.setup(opts)
			lspconfig.yamlls.setup(opts)
			lspconfig.gitlab_ci_ls.setup(opts)
			lspconfig.rust_analyzer.setup(opts)
			lspconfig.svelte.setup(opts)

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
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {})
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {})
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
