vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set nu rnu")
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.undofile = true

vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", { silent = true })

vim.api.nvim_create_user_command("StupidIndent", function(opts)
	local indent = opts.fargs[1] or "2"
	vim.cmd(string.format("set noexpandtab tabstop=8 shiftwidth=%s softtabstop=%s", indent, indent))
	vim.cmd("TSDisable indent")
end, { nargs = "?" })
vim.api.nvim_create_user_command("NormalIndent", function()
	vim.cmd("set expandtab tabstop=4 shiftwidth=4 softtabstop=4")
	vim.cmd("TSEnable indent")
end, {})

local stupidIndents = {
	opointlucenelib = 4,
	solrindex = 4,
	["search-system"] = 2,
	["search-system-karl"] = 2,
	restarter = 2,
	watchindex = 4,
	ocl = 2,
}

local path = string.lower(vim.fn.getcwd():match("([^/]+)$"))

if stupidIndents[path] then
	vim.cmd(string.format("StupidIndent %s", stupidIndents[path]))
end

vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float({ source = true })
end, {})
vim.keymap.set("n", "<leader>ge", vim.diagnostic.goto_next)
