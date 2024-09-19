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
end, { nargs = "?" })
vim.api.nvim_create_user_command("NormalIndent", function()
	vim.cmd("set expandtab tabstop=4 shiftwidth=4 softtabstop=4")
	vim.cmd("TSEnable indent")
end, {})

local stupidIndents = {
	OpointLuceneLib = 4,
	opointlucenelib = 4,
	SolrIndex = 4,
	["search-system"] = 2,
	["search-system-karl"] = 2,
	restarter = 2,
}

local path = vim.fn.getcwd():match("([^/]+)$")

if stupidIndents[path] then
	vim.cmd(string.format("StupidIndent %s", stupidIndents[path]))
end

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
