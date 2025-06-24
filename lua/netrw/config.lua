local M = {}

local defaults = {
	mappings = {}
}

M.options = {}

function M.setup(options)
	M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})

	vim.api.nvim_create_autocmd("BufModifiedSet", {
		pattern = { "*" },
		callback = function ()
			-- check if file type is netrw
			if not (vim.bo and vim.bo.filetype == "netrw") then
				return
			end

			if vim.b.netrw_liststyle ~= 0 and vim.b.netrw_liststyle ~= 1 and vim.b.netrw_liststyle ~= 3 then
				return
			end

			vim.opt_local.signcolumn = "yes"

			local bufnr = vim.api.nvim_get_current_buf()

			require("netrw.ui").embelish(bufnr)
		end,
		group = vim.api.nvim_create_augroup("netrw", { clear = false }),
	})
end

return M
