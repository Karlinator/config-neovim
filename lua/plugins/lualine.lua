return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "dracula",
		},
		sections = {
			lualine_b = { { "b:gitsigns_head", icon = "" } },
			lualine_c = {
				{ "filename", path = 1 },
				{
					function()
						return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
					end,
					padding = { right = 1, left = 1 },
					separator = { left = "", right = "" },
				},
			},
		},
	},
}
