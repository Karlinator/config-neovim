return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		opts = function(_, opts)
			local null_ls = require("null-ls")
			local virtual = os.getenv("VIRTUAL_ENV")
				or os.getenv("CONDA_PREFIX")
				or (vim.fn.finddir(".venv", vim.fn.getcwd() .. ";") and ".venv")
				or nil

			opts.sources = vim.list_extend(opts.sources or {}, {
				null_ls.builtins.diagnostics.mypy.with({
					extra_args = { "--python-executable", (virtual or "/usr") .. "/bin/python" },
				}),
				-- null_ls.builtins.diagnostics.mypy.with({
				-- 	-- command = virtual and (virtual .. "/bin/dmypy") or "dmypy",
				-- 	command = "dmypy",
				-- 	args = function(params)
				-- 		local t1 = {
				-- 			"run",
				-- 			"--timeout",
				-- 			"5000000",
				-- 			"--",
				-- 			"--hide-error-context",
				-- 			"--no-color-output",
				-- 			"--show-absolute-path",
				-- 			"--show-column-numbers",
				-- 			"--show-error-codes",
				-- 			"--no-error-summary",
				-- 			"--no-pretty",
				-- 			"--cache-fine-grained",
				-- 			"--sqlite-cache",
				-- 			"--python-executable",
				-- 			(virtual or "/usr") .. "/bin/python",
				--             vim.fn.getcwd()
				-- 		}
				-- 		-- local t2 = vim.lsp.buf.list_workspace_folders()
				-- 		-- for _, v in ipairs(t2) do
				-- 		-- 	table.insert(t1, v)
				-- 		-- end
				-- 		return t1
				-- 	end,
				-- 	timeout = 500000000,
				-- 	-- Do not run in fugitive windows, or when inside of a .venv area
				-- 	runtime_condition = function(params)
				-- 		if string.find(params.bufname, "fugitive") or string.find(params.bufname, ".venv") then
				-- 			return false
				-- 		else
				-- 			return true
				-- 		end
				-- 	end,
				-- }),
			})
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
				-- "codespell",
				"mypy",
				"rpmspec",
				"checkmake",
			},
			automatic_installation = false,
			handlers = {},
		},
	},
}
