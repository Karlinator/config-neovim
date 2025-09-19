---@type vim.lsp.Config
return {
	settings = {
		basedpyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
			autoImportCompletions = true,
			analysis = {
				-- Use mypy for type checking
				typeCheckingMode = "basic",
				reportUndefinedVariable = "hint",
			},
		},
	},
}
