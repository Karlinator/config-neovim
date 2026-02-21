-- lua/typecheck_detect.lua
local M = {}

local uv = vim.uv or vim.loop

local function path_join(a, b)
	if not a or a == "" then
		return nil
	end
	if not b or b == "" then
		return a
	end
	return (a:gsub("/$", "")) .. "/" .. b
end

local function readfile(path)
	if not path then
		return nil
	end
	local fd = uv.fs_open(path, "r", 438) -- 0666
	if not fd then
		return nil
	end
	local stat = uv.fs_fstat(fd)
	if not stat then
		uv.fs_close(fd)
		return nil
	end
	local data = uv.fs_read(fd, stat.size, 0)
	uv.fs_close(fd)
	return data
end

local function file_exists(path)
	return path ~= nil and uv.fs_stat(path) ~= nil
end

local function pyproject_has_table(root, tbl_header)
	local p = path_join(root, "pyproject.toml")
	if not file_exists(p) then
		return false
	end
	local s = readfile(p)
	if not s then
		return false
	end
	return s:match("%[" .. vim.pesc(tbl_header) .. "%]") ~= nil
end

local function setupcfg_has_section(root, section)
	local p = path_join(root, "setup.cfg")
	if not file_exists(p) then
		return false
	end
	local s = readfile(p)
	if not s then
		return false
	end
	return s:match("%[" .. vim.pesc(section) .. "%]") ~= nil
end

function M.uses_ty(root)
	if not root or root == "" then
		return false
	end
	if file_exists(path_join(root, "ty.toml")) then
		return true
	end
	return pyproject_has_table(root, "tool.ty")
end

function M.uses_mypy(root)
	if not root or root == "" then
		return false
	end
	if file_exists(path_join(root, "mypy.ini")) then
		return true
	end
	if file_exists(path_join(root, ".mypy.ini")) then
		return true
	end
	if pyproject_has_table(root, "tool.mypy") then
		return true
	end
	if setupcfg_has_section(root, "mypy") then
		return true
	end
	return false
end

-- Policy: prefer mypy when both appear configured.
function M.pick(root)
	if not root or root == "" then
		return nil
	end
	if M.uses_mypy(root) then
		return "mypy"
	end
	if M.uses_ty(root) then
		return "ty"
	end
	return nil
end

return M
