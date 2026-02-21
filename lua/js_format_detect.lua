-- lua/format_detect.lua
local M = {}
local uv = vim.uv or vim.loop

local function exists(p)
	return p and uv.fs_stat(p) ~= nil
end
local function join(a, b)
	if not a or a == "" then
		return nil
	end
	return (a:gsub("/$", "")) .. "/" .. b
end

function M.uses_biome(root)
	if not root or root == "" then
		return false
	end
	return exists(join(root, "biome.json"))
		or exists(join(root, "biome.jsonc"))
		or exists(join(root, ".biome.json"))
		or exists(join(root, ".biome.jsonc"))
end

function M.uses_prettier(root)
	if not root or root == "" then
		return false
	end
	return exists(join(root, ".prettierrc"))
		or exists(join(root, ".prettierrc.json"))
		or exists(join(root, ".prettierrc.yaml"))
		or exists(join(root, ".prettierrc.yml"))
		or exists(join(root, ".prettierrc.js"))
		or exists(join(root, ".prettierrc.cjs"))
		or exists(join(root, "prettier.config.js"))
		or exists(join(root, "prettier.config.cjs"))
		or exists(join(root, ".prettierignore"))
end

-- Policy: Biome wins if both exist.
function M.pick(root)
	if not root or root == "" then
		return nil
	end
	if M.uses_biome(root) then
		return "biome"
	end
	if M.uses_prettier(root) then
		return "prettier"
	end
	return nil
end

return M
