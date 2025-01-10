-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Automatically commit lockfile after running Lazy Update (or Sync)
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyUpdate",
	callback = function()
		local repo_dir = "/home/karl/.config/nvim"
		local lockfile = repo_dir .. "/lazy-lock.json"

		local cmd = {
			"git",
			"-C",
			repo_dir,
			"commit",
			lockfile,
			"-m",
			"Update lazy-lock.json",
		}

		local success, process = pcall(function()
			return vim.system(cmd):wait()
		end)

		if process and process.code == 0 then
			vim.notify("Committed lazy-lock.json")
			vim.notify(process.stdout)
		else
			if not success then
				vim.notify("Failed to run command '" .. table.concat(cmd, " ") .. "':", vim.log.levels.WARN, {})
				vim.notify(tostring(process), vim.log.levels.WARN, {})
			else
				vim.notify("git ran but failed to commit:")
				vim.notify(process.stdout, vim.log.levels.WARN, {})
			end
		end
	end,
})
