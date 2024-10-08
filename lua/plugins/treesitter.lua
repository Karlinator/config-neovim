return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = true,
	init = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
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
			},
			autoinstall = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
