return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"joechrisellis/lsp-format-modifications.nvim",
		},
		opts = function(_, opts)
			local null_ls = require("null-ls")
			local detect = require("typecheck_detect")
			local fmt = require("js_format_detect")

			-- `params.root` is only set by generator_factory *after* runtime_condition
			-- runs, so it's nil here. Resolve it the same way none-ls does.
			local function root()
				return require("null-ls.utils").get_root()
			end

			opts.sources = vim.list_extend(opts.sources or {}, {
				null_ls.builtins.diagnostics.mypy.with({
					prefer_local = ".venv/bin/",
					runtime_condition = function()
						-- Enable mypy diagnostics only when this project "picks" mypy
						return detect.pick(root()) == "mypy"
					end,
				}),
				null_ls.builtins.formatting.biome.with({
					runtime_condition = function()
						return fmt.pick(root()) == "biome"
					end,
				}),

				-- Prettier daemon
				null_ls.builtins.formatting.prettierd.with({
					runtime_condition = function()
						return fmt.pick(root()) == "prettier"
					end,
				}),
			})
			opts.on_attach = function(client, bufnr)
				-- your usual configuration — options, keymaps, etc
				-- ...

				vim.api.nvim_buf_create_user_command(bufnr, "FormatModifications", function()
					require("lsp-format-modifications").format_modifications(client, bufnr, { format_on_save = false })
				end, {})
			end
		end,
		init = function()
			local format_sources = { ["null-ls"] = true, ruff = true, clangd = true, rust_analyzer = true }
			vim.keymap.set("n", "<leader>gf", function()
				vim.lsp.buf.format({
					filter = function(client)
						return format_sources[client.name]
					end,
				})
			end, {})
			vim.keymap.set("n", "<leader>cf", ":FormatModifications<CR>")
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
				"biome",
				"eslint_d",
				"stylua",
				"mypy",
				"checkmake",
			},
			automatic_installation = false,
			handlers = {},
		},
	},
}
