local M = {}

M.TYPE_DIR = 0
M.TYPE_FILE = 1
M.TYPE_SYMLINK = 2

local parse_liststyle = function(line, dir)	
	local _, to = string.find(line, "^[|%s]*")
	local pipelessLine = string.sub(line, to + 1, #line)
	
	if pipelessLine == "" then
		return nil
	end

	local _, shift = string.gsub(line, "|", "")

	while table.getn(dir) > shift do
		table.remove(dir)
	end

	-- symbolic link
	local _, _, node, link = string.find(pipelessLine, "^(.+)@\t%s*%-%->%s*(.+)")
	if node then
		return nil
	end

	-- folder
	local _, _, acdir = string.find(pipelessLine, "^(.*)/")
	if acdir then
		if shift == 0 then
			table.insert(dir, "")
		end
		table.insert(dir, acdir)
		return nil
	end

	-- file
	local ext = vim.fn.fnamemodify(pipelessLine, ":e")
	if string.sub(ext, -1) == "*" then
		ext = string.sub(ext, 1, -2)
		pipelessLine = string.sub(pipelessLine, 1, -2)
	end

	local _, to_file = string.find(line, "^(.*)")
	
	return {
		dir = dir,
		col = to_file,
		node = pipelessLine,
		extension = ext,
		type = M.TYPE_FILE,
	}
end

M.get_node = function(line, dir)
	if string.find(line, '^"') then
		return nil
	end

	if line == "" then
		return nil
	end

	local liststyle = vim.b.netrw_liststyle

	return parse_liststyle(line, dir)
end

return M
