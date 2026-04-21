---@type vim.lsp.Config
return {
	on_new_config = function(new_config, root_dir)
		local venv_bin = root_dir .. "/.venv/bin/ruff"
		if vim.fn.executable(venv_bin) == 1 then
			new_config.cmd = { venv_bin, "server" }
		end
	end,
}
