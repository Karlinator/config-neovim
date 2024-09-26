return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = true,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
