vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nu rnu")
vim.opt.smartindent = false

vim.keymap.set("t", "<esc><leader>", "<C-\\><C-n>", { silent = true })

vim.api.nvim_create_user_command("StupidIndent", function(opts)
    local indent = opts.fargs[1] or "2"
	vim.cmd(string.format("set noexpandtab tabstop=8 shiftwidth=%s softtabstop=%s", indent, indent))
	vim.cmd("TSDisable indent")
end, { nargs='?' })
vim.api.nvim_create_user_command("NormalIndent", function()
	vim.cmd("set expandtab tabstop=4 shiftwidth=4 softtabstop=4")
	vim.cmd("TSEnable indent")
end, {})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
