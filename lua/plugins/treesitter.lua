return {
	-- nvim-treesitter is archived and unsupported on Neovim 0.12; tree-sitter-manager
	-- is a maintained installer that pairs with 0.12's native treesitter highlighting.
	"romus204/tree-sitter-manager.nvim",
	lazy = false,
	config = function()
		require("tree-sitter-manager").setup({
			ensure_installed = {
				"c",
				"lua",
				"python",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
				"svelte",
				"php",
				"cpp",
				"java",
				"xml",
				"typescript",
				"css",
				"json",
			},
			auto_install = true,
			highlight = true,
		})

		-- jsonl is just repeated top-level JSON values, which the json grammar handles.
		-- The manager only auto-starts highlighting for a parser's own filetype, so wire
		-- jsonl up by hand.
		vim.treesitter.language.register("json", "jsonl")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "jsonl",
			callback = function(args)
				pcall(vim.treesitter.start, args.buf, "json")
			end,
		})
	end,
}
