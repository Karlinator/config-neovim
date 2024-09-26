return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		opts = function()
			local null_ls = require("null-ls")

			return {
				sources = {
					null_ls.builtins.diagnostics.mypy.with({
						extra_args = function()
							local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
							return { "--python-executable", virtual .. "/bin/python3" }
						end,
					}),
				},
			}
		end,

		init = function()
			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end, {})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"prettierd",
				"eslint_d",
				"stylua",
				"gitsigns",
				"gitrebase",
				"codespell",
				"mypy",
				"rpmspec",
				"checkmake",
			},
			automatic_installation = false,
			handlers = {},
		},
	},
}
