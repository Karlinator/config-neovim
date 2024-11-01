return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	opts = {
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = true,
				hide_by_name = {
					".git",
				},
			},
			use_libuv_file_watcher = true,
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
		},
	},
	init = function()
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem toggle left<CR>")
	end,
}
