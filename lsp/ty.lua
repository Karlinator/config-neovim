local detect = require("typecheck_detect")
local util = require("lspconfig.util")

local base_root = util.root_pattern("pyproject.toml", "ty.toml", "setup.cfg", "mypy.ini", ".mypy.ini", ".git")

---@type vim.lsp.Config
return {
	root_dir = function(fname)
		local root = base_root(fname)
		if not root then
			return nil
		end
		if detect.pick(root) == "ty" then
			return root
		end
		return nil
	end,

	on_new_config = function(new_config, root_dir)
		local venv_bin = root_dir .. "/.venv/bin/ty"
		if vim.fn.executable(venv_bin) == 1 then
			new_config.cmd = { venv_bin, "server" }
		end
	end,

	-- if ty has settings you want, add them here
	settings = {
		ty = {},
	},
}
