vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nu rnu")
vim.opt.smartindent = false

vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { silent = true })

vim.api.nvim_create_user_command("StupidIndent", function()
	vim.cmd("set noexpandtab tabstop=8 shiftwidth=4 softtabstop=4")
	vim.cmd("TSDisable indent")
end, {})
vim.api.nvim_create_user_command("NormalIndent", function()
	vim.cmd("set expandtab tabstop=4 shiftwidth=4 softtabstop=4")
	vim.cmd("TSEnable indent")
end, {})
