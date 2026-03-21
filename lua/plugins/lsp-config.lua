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
				"tsgo",
				"marksman",
				"intelephense",
				"ruff",
				"basedpyright",
				"sqls",
				"yamlls",
				"rpmspec",
				"gitlab_ci_ls",
				"svelte",
				"ty",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
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
			vim.keymap.set("n", "<leader>ch", function()
				local params = { uri = vim.uri_from_bufnr(0) }
				vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, uri)
					if err or not uri or uri == "" then
						vim.notify("No corresponding file found", vim.log.levels.WARN)
						return
					end
					vim.cmd.edit(vim.uri_to_fname(uri))
				end)
			end, { desc = "Switch between source/header" })

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
				},
			})
		end,
	},
}
