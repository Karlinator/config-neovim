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

            vim.filetype.add({
                pattern = {
                    [".*%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab",
                    [".*/ci%-templates/.*%.ya?ml"] = "yaml.gitlab",
                },
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
