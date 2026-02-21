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

	-- if ty has settings you want, add them here
	settings = {
		ty = {},
	},
}
