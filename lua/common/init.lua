local M = {}

M.split = function (str, sep)
    if sep == nil then
		sep = "%s"
	end
	local t = {}
	for match in string.gmatch(str, "([^"..sep.."]+)") do
		table.insert(t, match)
	end
	return t
end

return M
