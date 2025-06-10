local M = {}

-- TODO: create util file
function split(str, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for match in string.gmatch(str, "([^"..sep.."]+)") do
		table.insert(t, match)
	end
	return t
end

M.update = function()
	vim.fn.sign_unplace('Git')

	file = vim.fn.expand('%:p')
	-- staged
	lines = vim.fn.system("git diff --unified=0 HEAD " .. file .. "")

	local t = {}
	for negative, positive in string.gmatch(lines, "@@%s[-|+](.*,?.*)[-|+](.*,?.*)%s@@") do
		table.insert(t, positive)
	end

	if not t then
		return nil
	end

	sign_list = {}
	for index, lnum in pairs(t) do
		num = split(lnum, ",")
		start = num[1]
		finish = start
		if num[2] then
			finish = start + num[2] - 1
		end
		for i=start,finish do
			sign = {}
			sign["group"] = "Git"
			sign["name"] = "GitChange"
			sign["buffer"] = file
			sign["lnum"] = i
			table.insert(sign_list, sign)
		end
	end
	vim.fn.sign_placelist(sign_list)
end

return M
