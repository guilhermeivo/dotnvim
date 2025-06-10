local M = {}

local config = require("netrw.config")
local parse = require("netrw.parse")

local get_status = function(node)
	local status = ""
	local hl_group = ""

	if node.type == parse.TYPE_FILE then
		if node.dir ~= nil then
			curdir = "." .. table.concat(node.dir, "/") .. "/" .. node.node
			status = vim.fn.system("git status --porcelain=v1 -s " .. curdir .. " 2>/dev/null | tr -d '\n'")
			status = string.gsub(status, "^%s+", "")
			status = string.sub(status, 1, 1)
		end
	end

	if status == "M" then
		hl_group = "GitGutterChange"
	elseif status == "A" then
		hl_group = "GitGutterAdd"
	end

	return { status, hl_group }
end

M.embelish = function(bufnr)
	local namespace = vim.api.nvim_create_namespace("netrw")

	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

	dir = {}
	for i, line in ipairs(lines) do
		local node = parse.get_node(line, dir)
		if not node then
			goto continue
		end

		if not node.col then
			goto continue
		end

		local opts = { id = i }
		local status, hl_group = unpack(get_status(node))
		if node.col == 0 then -- first column
			--if hl_group then
				--opts.sign_hl_group = "hl_group"
			--end
			--opts.virt_text = { { status } }
			--vim.api.nvim_buf_set_extmark(bufnr, namespace, i, 0, opts)
 		else
			if hl_group then
				opts.virt_text = { { status, hl_group } }
			else
				opts.virt_text = { { status } }
			end
			vim.api.nvim_buf_set_extmark(bufnr, namespace, i - 1, node.col, opts)	
		end
		::continue::
	end

	-- Fixes weird case where the cursor spawns inside of the sign column.
	vim.cmd([[norm lh]])
end

return M
